//
//  HomeView.swift
//  ZhiHuDaily
//
//  Created by TwTStudio on 8/16/20.
//

import SwiftUI

struct HomeView: View {
    @State private var latestNews = LatestNews()
    
    private var topStories: [TopStory] { latestNews.topStories }
    private var stories: [Story] { latestNews.stories }
    
    @State private var select: URL?
    @State private var isLoading = false
    
    var body: some View {
        NavigationView {
            List {
                if !topStories.isEmpty {
                    Section(header: Text(Localizable.topStories.rawValue)) {
                        ForEach(topStories, id: \.id) { topStory in
                            NavigationLink(destination: TopStoryDetailView(topStory: topStory), tag: topStory.inAppURL, selection: $select) {
                                TopStoryCardView(topStory: topStory)
                                    .onTapGesture {
                                        select = topStory.inAppURL
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
            .navigationBarItems(
                leading: CalendarSymbolView(date: Date()),
                trailing: RefreshButton(isLoading: $isLoading, action: load)
            )
            .onOpenURL { url in
                select = url
            }
            
            HomeDescriptionView()
        }
        .onAppear(perform: load)
    }
    
    func load() {
        isLoading = true
        
        NewsManager.getLatest { result in
            switch result {
            case .success(let latestNews):
                self.latestNews = latestNews
            case .failure(let error):
                print(error)
            }
            
            isLoading = false
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
