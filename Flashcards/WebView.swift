//
//  WebView.swift
//  Flashcards
//
//  Created by Paul Fitzgerald on 10/04/2023.
//

import SwiftUI
import WebKit

struct WebView : UIViewRepresentable {
    
    let request: URLRequest
    var webview: WKWebView?
    
    init(web: WKWebView?, request: URLRequest) {
        self.webview = WKWebView()
        self.request = request
    }
    func makeUIView(context: Context) -> WKWebView  {
        self.webview!
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        DispatchQueue.main.async {
            uiView.load(request)
        }
    }
    
    func goBack(){
        webview?.goBack()
    }

    func goForward(){
        webview?.goForward()
    }
    
}
