//
//  WebView.swift
//  ZhiHuDaily
//
//  Created by JasonEWNL on 8/8/20.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: String
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        
        if let url = URL(string: url) {
            webView.load(URLRequest(url: url))
            webView.allowsBackForwardNavigationGestures = false
        }
        
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {}
}
