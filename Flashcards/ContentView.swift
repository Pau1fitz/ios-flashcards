//
//  ContentView.swift
//  Flashcards
//
//  Created by Paul Fitzgerald on 07/04/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var store = TranslationsStore()
    @State var isRadioPlaying = false
 
    func saveTranslations () {
        TranslationsStore.save(translatedItems: store.translations) { result in
            if case .failure(let error) = result {
                fatalError(error.localizedDescription)
            }
        }
    }
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            TranslationListView(translations: $store.translations, currentIndex: $store.currentIndex, saveAction: saveTranslations)
                .tabItem {
                    Label("Translate", systemImage: "list.dash")
                }
            
            FlashcardView(translations: $store.translations, currentIndex: $store.currentIndex)
                .tabItem {
                    Label("Flashcards", systemImage: "square.on.square")
               }
        }
        .onAppear {
            TranslationsStore.load { result in
                switch result {
                case .failure(let error):
                    fatalError(error.localizedDescription)
                case .success(let translations):
                    store.translations = translations
                }
            }
        }
    }
}
