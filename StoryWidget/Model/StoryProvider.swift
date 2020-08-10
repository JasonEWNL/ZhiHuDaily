//
//  StoryProvider.swift
//  StoryWidgetExtension
//
//  Created by JasonEWNL on 8/9/20.
//

import SwiftUI
import WidgetKit

struct StoryProvider: TimelineProvider {
    func placeholder(in context: Context) -> StoryEntry {
        StoryEntry(date: Date(), storyPairs: storyPairs)
    }

    func getSnapshot(in context: Context, completion: @escaping (StoryEntry) -> ()) {
        let entry = StoryEntry(date: Date(), storyPairs: storyPairs)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<StoryEntry>) -> ()) {
        var entries: [StoryEntry] = []
        
        NewsManager.newsGet { result in
            switch result {
            case .success(let news):
                DispatchQueue.global().async {
                    let semaphore = DispatchSemaphore(value: 0)
                    
                    var storyPairs = [(TopStory, Image)]()
                    for story in news.topStories {
                        Network.batchImage(story.image) { result in
                            switch result {
                            case .success(let image):
                                storyPairs.append((story, image))
                            case .failure(let error):
                                print(error)
                            }
                            semaphore.signal()
                        }
                        semaphore.wait()
                    }
                    
                    let entry = StoryEntry(date: Date(), storyPairs: storyPairs)
                    entries.append(entry)
                    let timeline = Timeline(entries: entries, policy: .never)
                    DispatchQueue.main.async {
                        completion(timeline)
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
