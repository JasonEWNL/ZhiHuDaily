//
//  ContentView.swift
//  ZhiHuDaily
//
//  Created by JasonEWNL on 8/8/20.
//

import SwiftUI

enum Tab: String {
    case home, past
}

struct ContentView: View {
    @State private var selection = Tab.home
    @State private var selectDate = Date()
    
    var body: some View {
        TabView(selection: $selection) {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text(Localizable.home.rawValue)
                }
                .tag(Tab.home)
            
            PastView(selectDate: $selectDate)
                .tabItem {
                    Image(systemName: "calendar")
                    Text(Localizable.past.rawValue)
                }
                .tag(Tab.past)
        }
        .onOpenURL { url in
            let urlString = url.absoluteString
            let pastTab = Tab.past
            if urlString.contains(pastTab.rawValue) {
                selection = pastTab
                let dateString = urlString.components(separatedBy: "/")[3]
                selectDate = dateString.createDate(from: "yyyyMMdd")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
