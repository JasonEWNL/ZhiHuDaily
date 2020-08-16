//
//  TopStorySmallWidgetEntryView.swift
//  TopStoryWidgetExtension
//
//  Created by JasonEWNL on 8/9/20.
//

import SwiftUI

struct TopStorySmallWidgetEntryView: View {
    let entry: TopStoryEntry
    
    var body: some View {
        if let topStoryPair = entry.topStoryPairs.randomElement() {
            ZStack {
                topStoryPair.1
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                VStack {
                    Spacer()
                        .frame(maxHeight: .infinity)
                    
                    VStack(alignment: .leading) {
                        Text(topStoryPair.0.title)
                            .font(.footnote)
                            .foregroundColor(.white)
                        
                        Text(topStoryPair.0.hint)
                            .font(.caption)
                            .foregroundColor(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                    }
                    .padding()
                    .background(
                        Color(topStoryPair.0.color)
                            .blur(radius: 25)
                            .blendMode(.multiply)
                    )
                }
            }
            .widgetURL(topStoryPair.0.inAppURL)
        }
    }
}
