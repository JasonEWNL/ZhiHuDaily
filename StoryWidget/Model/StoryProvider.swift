//
//  StoryProvider.swift
//  StoryWidgetExtension
//
//  Created by TwTStudio on 8/17/20.
//

import SwiftUI
import WidgetKit

struct StoryProvider: IntentTimelineProvider {
    func placeholder(in context: Context) -> StoryEntry {
        StoryEntry(date: Date(), storyPairs: storyPairs)
    }

    func getSnapshot(for configuration: StoryIntent, in context: Context, completion: @escaping (StoryEntry) -> ()) {
        let entry = StoryEntry(date: Date(), storyPairs: storyPairs)
        completion(entry)
    }

    func getTimeline(for configuration: StoryIntent, in context: Context, completion: @escaping (Timeline<StoryEntry>) -> ()) {
        var entries = [StoryEntry]()
        
        let selectDate = configuration.dateComponents?.date ?? Date()
        
        NewsManager.getDate(tab: "past", date: selectDate) { result in
            switch result {
            case .success(let dateNews):
                DispatchQueue.global().async {
                    let semaphore = DispatchSemaphore(value: 0)
                    
                    var storyPairs = [(Story, Image)]()
                    for story in dateNews.stories {
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
