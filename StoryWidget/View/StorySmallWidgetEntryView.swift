//
//  StorySmallWidgetEntryView.swift
//  StoryWidgetExtension
//
//  Created by JasonEWNL on 8/9/20.
//

import SwiftUI

struct StorySmallWidgetEntryView: View {
    let entry: StoryEntry
    
    var body: some View {
        if let storyPair = entry.storyPairs.randomElement() {
            ZStack {
                storyPair.1
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                VStack {
                    Spacer()
                        .frame(maxHeight: .infinity)
                    
                    VStack(alignment: .leading) {
                        Text(storyPair.0.title)
                            .font(.footnote)
                            .foregroundColor(.white)
                        
                        Text(storyPair.0.hint)
                            .font(.caption)
                            .foregroundColor(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                    }
                    .padding()
                    .background(
                        Color(storyPair.0.color)
                            .blur(radius: 25)
                            .blendMode(.multiply)
                    )
                }
            }
            .widgetURL(storyPair.0.inAppURL)
        }
    }
}
