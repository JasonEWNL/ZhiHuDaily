//
//  CalendarSymbolView.swift
//  ZhiHuDaily
//
//  Created by TwTStudio on 8/16/20.
//

import SwiftUI

struct CalendarSymbolView: View {
    let date: Date
    
    var body: some View {
        VStack {
            Text(date.format(with: "LLL"))
                .font(.caption)
                .foregroundColor(.red)
            
            Text(date.format(with: "dd"))
                .font(.headline)
        }
    }
}

struct CalendarSymbolView_Previews: PreviewProvider {
    static private let date = Date()
    
    static var previews: some View {
        Group {
            Group {
                CalendarSymbolView(date: date)
                
                ZStack {
                    Color.black
                        .edgesIgnoringSafeArea(.all)
                    
                    CalendarSymbolView(date: date)
                }
                .environment(\.colorScheme, .dark)
            }
            
            Group {
                CalendarSymbolView(date: date)
                
                ZStack {
                    Color.black
                        .edgesIgnoringSafeArea(.all)
                    
                    CalendarSymbolView(date: date)
                }
                .environment(\.colorScheme, .dark)
            }
            .environment(\.locale, .init(identifier: "zh_Hans")) // seem not working for dates
        }
        .previewLayout(.fixed(width: 50, height: 50))
    }
}
