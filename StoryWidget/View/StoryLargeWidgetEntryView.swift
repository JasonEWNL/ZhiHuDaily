//
//  StoryLargeWidgetEntryView.swift
//  StoryWidgetExtension
//
//  Created by JasonEWNL on 8/9/20.
//

import SwiftUI

struct StoryLargeWidgetEntryView: View {
    let entry: StoryEntry
    var fourStoryPairs: [(TopStory, Image)] { Array(entry.storyPairs.shuffled().prefix(4)) }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                ForEach(fourStoryPairs, id: \.0.id) { storyPair in
                    Link(destination: storyPair.0.inAppURL) {
                        HStack {
                            storyPair.1
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            
                            VStack(alignment: .leading) {
                                Text(storyPair.0.title)
                                    .font(.footnote)
                                    .foregroundColor(.primary)
                                
                                Text(storyPair.0.hint)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
            }
            .padding(.vertical)
            
            Spacer()
        }
        .padding(.horizontal)
    }
}
