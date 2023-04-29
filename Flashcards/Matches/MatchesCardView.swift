//
//  MatchesCardView.swift
//  Flashcards
//
//  Created by Paul Fitzgerald on 13/04/2023.
//

import SwiftUI
import Combine
import AVFoundation

struct MatchesCardView: View {
    var text: String
    var shouldSpeak: Bool
    @Binding var matches: [TranslatedItem]
    @Binding var guesses: [String]
    @Binding var correctAnswers: [String]
    
    @State private var synthesizer = AVSpeechSynthesizer()

    func textToSpeech(speak: String) {
        let utterance = AVSpeechUtterance(string: speak)
        utterance.voice = AVSpeechSynthesisVoice(language: "pt-PT")
        utterance.rate = 0.40
        self.synthesizer.speak(utterance)
    }
    

    var body: some View {
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
                if shouldSpeak {
                    textToSpeech(speak: text)
                }
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
        .onAppear {
            do {
                try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
                try AVAudioSession.sharedInstance().setActive(true)
             }
            catch {
                print("Fail to enable session")
            }
        }
    }
}
