//
//  HomeDescriptionView.swift
//  ZhiHuDaily
//
//  Created by TwTStudio on 8/16/20.
//

import SwiftUI

struct HomeDescriptionView: View {
    var body: some View {
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
}
