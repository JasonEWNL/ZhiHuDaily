//
//  TopStoryMediumWidgetEntryView.swift
//  TopStoryWidgetExtension
//
//  Created by JasonEWNL on 8/9/20.
//

import SwiftUI

struct TopStoryMediumWidgetEntryView: View {
    let entry: TopStoryEntry
    var twoStoryPairs: [(TopStory, Image)] { Array(entry.topStoryPairs.shuffled().prefix(2)) }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                ForEach(twoStoryPairs, id: \.0.id) { topStoryPair in
                    Link(destination: topStoryPair.0.inAppURL) {
                        HStack {
                            topStoryPair.1
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            
                            VStack(alignment: .leading) {
                                Text(topStoryPair.0.title)
                                    .font(.footnote)
                                    .foregroundColor(.primary)
                                
                                Text(topStoryPair.0.hint)
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
