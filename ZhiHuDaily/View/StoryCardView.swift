//
//  StoryCardView.swift
//  ZhiHuDaily
//
//  Created by JasonEWNL on 8/9/20.
//

import SwiftUI

struct StoryCardView: View {
    let story: Story
    
    var body: some View {
        VStack {
            URLImage(
                URL(string: story.image)!,
                content: {
                    $0.image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
            )
            
            Text(story.title)
                .font(.callout)
                .foregroundColor(.primary)
            
            Text(story.hint)
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}
