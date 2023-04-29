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
    @State private var isUsingUsersItems = true
    @State private var displayedCards: [TranslatedItem] = []
    
    func toggleSelectedLanguage () {
        selectedLanguage = selectedLanguage == "EN" ? "PT" : "EN"
    }
    
    var body: some View {
        VStack {
            if displayedCards.count > 0 {
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
                    
                    CardView(selectedLanguage: selectedLanguage, card: $displayedCards[currentIndex], isShowingAnswer: $isShowingAnswer)
                    
                    HStack {
                        Spacer()
                        
                        Button {
                            if currentIndex != 0 {
                                currentIndex = currentIndex - 1
                                isShowingAnswer = false
                            }
                        } label: {
                            Text("Previous")
                                .padding(.horizontal, 8)
                                .frame(height: 32)
                                .foregroundColor(.white)
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(Color.black)
                        
                        Spacer()
                        
                        Button {
                            if currentIndex < displayedCards.count - 1 {
                                currentIndex = currentIndex + 1
                                isShowingAnswer = false
                            }
                        } label: {
                            Text("Next")
                                .padding(.horizontal, 8)
                                .frame(height: 32)
                                .foregroundColor(.white)
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(Color.black)
                        
                        Spacer()
                    }
                    .padding()
                    .padding(.bottom, 24)
                    
                    HStack {
                        Spacer()
                        Button {
                            isUsingUsersItems.toggle()
                            displayedCards = isUsingUsersItems ? translations: generatedTranslatedItems.shuffled()
                        } label: {
                            Text(isUsingUsersItems ? "Practice Other Words" : "Practice Your Words")
                                .padding(.horizontal, 8)
                                .frame(height: 32)
                                .foregroundColor(.white)
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(Color.black)
                        Spacer()
                    }
                
                    
                    Spacer()
                }
            } else {
                VStack {
                    Text("No translations available")
                    Button("Practice Other Words") {
                        isUsingUsersItems.toggle()
                        displayedCards = generatedTranslatedItems.shuffled()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(Color.black)
                }
            }
        }.onAppear {
            displayedCards = isUsingUsersItems ? translations : generatedTranslatedItems.shuffled()
        }
    }
}
