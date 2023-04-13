//
//  FlashcardView.swift
//  Flashcards
//
//  Created by Paul Fitzgerald on 10/04/2023.
//

import SwiftUI

struct FlashcardView: View {
    @Binding var translations: [TranslatedItem]
    @Binding var currentIndex: Int
    @State private var isShowingAnswer = false
    @State private var selectedLanguage: String = "EN"
    
    func toggleSelectedLanguage () {
        selectedLanguage = selectedLanguage == "EN" ? "PT" : "EN"
    }
    
    var body: some View {
        if translations.count > 0 {
            VStack (alignment: .leading) {
                Divider()
                
                HStack (alignment: .center) {
                    Spacer()
                    Text(selectedLanguage == "EN" ? "Inglês" : "Português")
                        .frame(width: 100.0)
                    Spacer()
                    Image(systemName: "arrow.right.arrow.left")
                        .foregroundColor(.black)
                        .onTapGesture {
                            toggleSelectedLanguage()
                        }
                    Spacer()
                    Text(selectedLanguage == "EN" ?  "Português" : "Inglês")
                        .frame(width: 100.0)
                    Spacer()
                    
                }
                Divider()
                
                CardView(card: translations[currentIndex], selectedLanguage: selectedLanguage, isShowingAnswer: $isShowingAnswer)
                
                HStack {
                    Spacer()
                    Button("Previous") {
                        if currentIndex != 0 {
                            currentIndex = currentIndex - 1
                            isShowingAnswer = false
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(Color.black)
                    
                    Spacer()
                    
                    Button("Next") {
                        if currentIndex < translations.count - 1 {
                            currentIndex = currentIndex + 1
                            isShowingAnswer = false
                        }
                        
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(Color.black)
                    
                    Spacer()
                }
                .padding()
                
                Spacer()
            }
        } else {
            Text("No translations available")
        }
 
    }
}
