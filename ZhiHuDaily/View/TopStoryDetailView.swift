//
//  TopStoryDetailView.swift
//  ZhiHuDaily
//
//  Created by JasonEWNL on 8/8/20.
//

import SwiftUI

struct TopStoryDetailView: View {
    let story: TopStory
    
    var body: some View {
        WebView(url: story.url)
            .navigationBarTitle(story.title, displayMode: .inline)
            .edgesIgnoringSafeArea(.bottom)
            .edgesIgnoringSafeArea(.horizontal)
    }
}
