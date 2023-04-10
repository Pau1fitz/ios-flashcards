//
//  ContentView.swift
//  Flashcards
//
//  Created by Paul Fitzgerald on 07/04/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            TranslationListView()
                .tabItem {
                    Label("Translate", systemImage: "book.circle")
                }
            
            FlashcardView()
                .tabItem {
                    Label("Flashcards", systemImage: "greetingcard.fill")
               }
        }
    }
}

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = Double(total - position)
        return self.offset(x: 0, y: offset * 10)
    }
}
