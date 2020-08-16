//
//  TopStoryProvider.swift
//  TopStoryWidgetExtension
//
//  Created by JasonEWNL on 8/9/20.
//

import SwiftUI
import WidgetKit

struct TopStoryProvider: TimelineProvider {
    func placeholder(in context: Context) -> TopStoryEntry {
        TopStoryEntry(date: Date(), topStoryPairs: topStoryPairs)
    }

    func getSnapshot(in context: Context, completion: @escaping (TopStoryEntry) -> ()) {
        let entry = TopStoryEntry(date: Date(), topStoryPairs: topStoryPairs)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<TopStoryEntry>) -> ()) {
        var entries: [TopStoryEntry] = []
        
        NewsManager.getLatest { result in
            switch result {
            case .success(let news):
                DispatchQueue.global().async {
                    let semaphore = DispatchSemaphore(value: 0)
                    
                    var topStoryPairs = [(TopStory, Image)]()
                    for topStory in news.topStories {
                        Network.batchImage(topStory.image) { result in
                            switch result {
                            case .success(let image):
                                topStoryPairs.append((topStory, image))
                            case .failure(let error):
                                print(error)
                            }
                            semaphore.signal()
                        }
                        semaphore.wait()
                    }
                    
                    let entry = TopStoryEntry(date: Date(), topStoryPairs: topStoryPairs)
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
