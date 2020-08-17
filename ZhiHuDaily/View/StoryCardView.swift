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
        HStack {
            URLImage(
                URL(string: story.image)!,
                content: {
                    $0.image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxHeight: 120)
                }
            )
            
            VStack(alignment: .leading, spacing: 8) {
                Text(story.title)
                    .font(.callout)
                    .foregroundColor(.primary)
                
                Text(story.hint)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
    }
}
