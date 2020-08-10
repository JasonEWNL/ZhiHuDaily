//
//  RefreshButton.swift
//  ZhiHuDaily
//
//  Created by JasonEWNL on 8/8/20.
//

import SwiftUI

struct RefreshButton: View {
    @Binding var isLoading: Bool
    let action: () -> Void
    @State private var isAnimating = false
    
    private let symbol = "arrow.triangle.2.circlepath"
    
    var body: some View {
        if isLoading {
            Image(systemName: symbol)
                .foregroundColor(.secondary)
                .rotationEffect(.degrees(isAnimating ? 360 : 0))
                .animation(
                    isLoading
                    ? Animation.linear(duration: 2).repeatForever(autoreverses: false)
                    : .default
                )
                .onAppear {
                    isAnimating = true
                }
                .onDisappear {
                    isAnimating = false
                }
        } else {
            Image(systemName: symbol)
                .foregroundColor(.primary)
                .onTapGesture(perform: action)
        }
    }
}

struct RefreshButton_Previews: PreviewProvider {
    static var previews: some View {
        RefreshButton(isLoading: .constant(true), action: {})
    }
}
