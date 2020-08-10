//
//  ContentView.swift
//  ZhiHuDaily
//
//  Created by JasonEWNL on 8/8/20.
//

import SwiftUI

struct ContentView: View {
    @State private var news = News()
    
    private var topStories: [TopStory] { news.topStories }
    private var stories: [Story] { news.stories }
    
    @State private var select: URL?
    @State private var isLoading = false
    
    var body: some View {
        NavigationView {
            List {
                if !topStories.isEmpty {
                    Section(header: Text(Localizable.topStories.rawValue)) {
                        ForEach(topStories, id: \.id) { story in
                            NavigationLink(destination: TopStoryDetailView(story: story), tag: story.inAppURL, selection: $select) {
                                TopStoryCardView(story: story)
                                    .onTapGesture {
                                        select = story.inAppURL
                                    }
                            }
                        }
                    }
                }
                
                if !stories.isEmpty {
                    Section(header: Text(Localizable.stories.rawValue)) {
                        ForEach(stories, id: \.id) { story in
                            NavigationLink(destination: StoryDetailView(story: story), tag: story.inAppURL, selection: $select) {
                                StoryCardView(story: story)
                                    .onTapGesture {
                                        select = story.inAppURL
                                    }
                            }
                        }
                    }
                }
            }
            .listStyle(PlainListStyle()) // default change to `SidebarListStyle` if using `destination...` initializer for `NavigationLink`
            .navigationTitle(Localizable.home.rawValue)
            .navigationBarItems(trailing: RefreshButton(isLoading: $isLoading, action: load))
            .onOpenURL { url in
                select = url
            }
            
            VStack {
                Text(Localizable.homeDescriptionContent.rawValue)
                    .font(.title)
                    .italic()
                    .padding()
                
                Text(Localizable.homeDescriptionSignature.rawValue)
                    .italic()
                    .foregroundColor(.secondary)
            }
        }
        .onAppear(perform: load)
    }
    
    func load() {
        isLoading = true
        
        NewsManager.newsGet { result in
            switch result {
            case .success(let news):
                self.news = news
            case .failure(let error):
                print(error)
            }
            
            isLoading = false
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
