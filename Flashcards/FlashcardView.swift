//
//  FlashcardView.swift
//  Flashcards
//
//  Created by Paul Fitzgerald on 10/04/2023.
//

import SwiftUI

struct FlashcardView: View {
    @Binding var translations: [TranslatedItem]
    
    var body: some View {
        ZStack {
            VStack {
                ZStack {
                    ForEach(0..<translations.count, id: \.self) { index in
                        CardView(card: translations[index])
                            .stacked(at: index, in: translations.count)
                    }
                }
                HStack {
                    Spacer()
                    Button("Restart") {
    //                    translateData()
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding(.horizontal)
            }

        }
    }
}
