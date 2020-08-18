//
//  StoryMediumWidgetEntryView.swift
//  StoryWidgetExtension
//
//  Created by TwTStudio on 8/17/20.
//

import SwiftUI

struct StoryMediumWidgetEntryView: View {
    let entry: StoryEntry
    var twoStoryPairs: [(Story, Image)] { Array(entry.storyPairs.shuffled().prefix(2)) }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                ForEach(twoStoryPairs, id: \.0.id) { storyPair in
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
