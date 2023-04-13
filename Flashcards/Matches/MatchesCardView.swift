//
//  MatchesCardView.swift
//  Flashcards
//
//  Created by Paul Fitzgerald on 13/04/2023.
//

import SwiftUI
import Combine

struct MatchesCardView: View {
    var text: String
    var matches: [TranslatedItem]
    @Binding var guesses: [String]
    @Binding var correctAnswers: [String]
    
    var body: some View {
        
        let lightGreen : Color = Color(red: 234/255, green: 254/255, blue: 215/255)
        let darkGreen : Color = Color(red: 195/255, green: 243/255, blue: 151/255)
        let fontGreen : Color = Color(red: 128/255, green: 179/255, blue: 75/255)
        
        ZStack  {
            RoundedRectangle(cornerRadius: 4.0, style: .continuous)
                .fill(correctAnswers.contains(text) ? lightGreen : .white)
                .opacity(guesses.contains(text) ? 0.5 : 1.0)
                .shadow(color: correctAnswers.contains(text) ? darkGreen : .gray, radius: 2.0)
                .border(width: correctAnswers.contains(text) ? 2.0 : 0, edges: [.top, .leading, .bottom, .trailing], color: darkGreen)
            Text(text)
                .multilineTextAlignment(.center)
                .opacity(guesses.contains(text) ? 0.1 : 1.0)
                .foregroundColor(correctAnswers.contains(text) ? fontGreen : .black)
        }.onTapGesture {
            withAnimation {
                guesses.append(text)
                if guesses.count == 2 {
                    let isCorrect = checkGuesses(guesses: guesses, allItems: matches)
                    if isCorrect {
                        correctAnswers.append(guesses[0])
                        correctAnswers.append(guesses[1])
                        
                    }
                    guesses = []
                }
            }
        }
        .allowsHitTesting(correctAnswers.contains(text) ? false : true)
    }
}
