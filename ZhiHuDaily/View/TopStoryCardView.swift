//
//  TopStoryCardView.swift
//  ZhiHuDaily
//
//  Created by JasonEWNL on 8/8/20.
//

import SwiftUI

struct TopStoryCardView: View {
    let topStory: TopStory
    
    var body: some View {
        HStack {
            URLImage(
                URL(string: topStory.image)!,
                content: {
                    $0.image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxHeight: 120)
                }
            )
            
            VStack(alignment: .leading, spacing: 8) {
                Text(topStory.title)
                    .font(.callout)
                    .foregroundColor(.primary)
                
                Text(topStory.hint)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
    }
}
