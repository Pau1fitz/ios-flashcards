//
//  ContentView.swift
//  Flashcards
//
//  Created by Paul Fitzgerald on 07/04/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var store = TranslationsStore()
    
    func saveTranslations () {
        TranslationsStore.save(translatedItems: store.translations) { result in
            if case .failure(let error) = result {
                fatalError(error.localizedDescription)
            }
        }
    }
    
    var body: some View {
        TabView {
            Text("Home")
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            TranslationListView(translations: $store.translations, saveAction: saveTranslations)
                .tabItem {
                    Label("Translate", systemImage: "list.dash")
                }
            
            FlashcardView(translations: $store.translations)
                .tabItem {
                    Label("Flashcards", systemImage: "greetingcard.fill")
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
