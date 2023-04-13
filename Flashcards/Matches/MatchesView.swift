//
//  MatchesView.swift
//  Flashcards
//
//  Created by Paul Fitzgerald on 13/04/2023.
//

import SwiftUI

struct MatchesView: View {
    var matches: [TranslatedItem]
    
    @State private var displayedMatches: [TranslatedItem] = []
    @State private var isPlaying: Bool = false
    
    
    func getRandomItems(from items: [TranslatedItem]) -> [TranslatedItem] {
        
        if items.count == 0 {
            return []
        }
        var newItems: [TranslatedItem] = []
        var chosenItems: Set<TranslatedItem> = []

        while newItems.count < 2 {
            let randomIndex = Int.random(in: 0..<items.count)
            let item = items[randomIndex]
            if !chosenItems.contains(item) {
                newItems.append(item)
                chosenItems.insert(item)
            }
        }
        return newItems
    }
    
    

    var body: some View {
        
        if matches.count >= 2 {
            VStack {
                Text("Matches here")
            }
            .onAppear {
                if !isPlaying {
                    displayedMatches = getRandomItems(from: matches)
                    isPlaying = true
                }
            }
        } else {
            Text("At least 10 translations required")
        }
 
    }
}

