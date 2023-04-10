//
//  FlashcardView.swift
//  Flashcards
//
//  Created by Paul Fitzgerald on 10/04/2023.
//

import SwiftUI

struct FlashcardView: View {
    @State private var cards = [Card](repeating: Card.example, count: 10)
    
    var body: some View {
        ZStack {
            VStack {
                ZStack {
                    ForEach(0..<cards.count, id: \.self) { index in
                        CardView(card: cards[index])
                            .stacked(at: index, in: cards.count)
                    }
                }
            }
        }
    }
}

struct FlashcardView_Previews: PreviewProvider {
    static var previews: some View {
        FlashcardView()
    }
}
