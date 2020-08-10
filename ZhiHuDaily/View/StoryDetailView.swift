//
//  StoryDetailView.swift
//  ZhiHuDaily
//
//  Created by JasonEWNL on 8/9/20.
//

import SwiftUI

struct StoryDetailView: View {
    let story: Story
    
    var body: some View {
        WebView(url: story.url)
            .navigationBarTitle(story.title, displayMode: .inline)
            .edgesIgnoringSafeArea(.bottom)
            .edgesIgnoringSafeArea(.horizontal)
    }
}
