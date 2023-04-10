//
//  FlashcardView.swift
//  Flashcards
//
//  Created by Paul Fitzgerald on 10/04/2023.
//

import SwiftUI

struct FlashcardView: View {
    @Binding var translations: [TranslatedItem]
    @State var currentIndex = 0
    
    var body: some View {
        VStack (alignment: .leading){
            Spacer()
            CardView(card: translations[currentIndex])
            
            HStack {
                Spacer()
                Button("Previous") {
                    if currentIndex != 0 {
                        currentIndex = currentIndex - 1
                    }
                }
                .buttonStyle(.borderedProminent)
                
                Spacer()
                
                Button("Next") {
                    if currentIndex < translations.count - 1 {
                        currentIndex = currentIndex + 1
                    }
                    
                }
                .buttonStyle(.borderedProminent)
                
                Spacer()
            }
            .padding()
            
            Spacer()
                
        }
        .padding()
    }
}
