//
//  TopStoryCardView.swift
//  ZhiHuDaily
//
//  Created by JasonEWNL on 8/8/20.
//

import SwiftUI

struct TopStoryCardView: View {
    let story: TopStory
    
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
