//
//  PastView.swift
//  ZhiHuDaily
//
//  Created by TwTStudio on 8/16/20.
//

import SwiftUI

struct PastView: View {
    @State private var selectDate = Date()
    private var requestDate: Date { selectDate.addingTimeInterval(24 * 60 * 60) }
    @State private var showDate = false
    
    @State private var dateNews = DateNews()
    
    private var stories: [Story] { dateNews.stories }
    
    @State private var select: URL?
    @State private var isLoading = false
    
    var body: some View {
        NavigationView {
            List {
                if !stories.isEmpty {
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
            .listStyle(PlainListStyle()) // default change to `SidebarListStyle` if using `destination...` initializer for `NavigationLink`
            .navigationTitle(Localizable.past.rawValue)
            .navigationBarItems(
                leading: CalendarSymbolView(date: selectDate).onTapGesture { showDate = true },
                trailing: RefreshButton(isLoading: $isLoading, action: load)
            )
            .onOpenURL { url in
                select = url
            }
            .sheet(isPresented: $showDate, onDismiss: load) {
                DatePicker(
                    selection: $selectDate,
                    in: ...Date(),
                    displayedComponents: DatePickerComponents.date
                ) {
                    EmptyView()
                }
                .datePickerStyle(GraphicalDatePickerStyle())
                .frame(maxHeight: 400)
            }
            
            HomeDescriptionView()
        }
        .onAppear(perform: load)
    }
    
    func load() {
        isLoading = true
        
        NewsManager.getDate(date: requestDate) { result in
            switch result {
            case .success(let dateNews):
                self.dateNews = dateNews
            case .failure(let error):
                print(error)
            }
            
            isLoading = false
        }
    }
}

struct PastView_Previews: PreviewProvider {
    static var previews: some View {
        PastView()
    }
}
