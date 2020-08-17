//
//  ContentView.swift
//  ZhiHuDaily
//
//  Created by JasonEWNL on 8/8/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text(Localizable.home.rawValue)
                }
            
            PastView()
                .tabItem {
                    Image(systemName: "calendar")
                    Text(Localizable.past.rawValue)
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
