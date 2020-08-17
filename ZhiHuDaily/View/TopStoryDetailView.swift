//
//  TopStoryDetailView.swift
//  ZhiHuDaily
//
//  Created by JasonEWNL on 8/8/20.
//

import SwiftUI

struct TopStoryDetailView: View {
    let topStory: TopStory
    
    var body: some View {
        WebView(url: topStory.url)
            .navigationBarTitle(topStory.title, displayMode: .inline)
            .edgesIgnoringSafeArea(.bottom)
            .edgesIgnoringSafeArea(.horizontal)
    }
}
