//
//  MatchesView.swift
//  Flashcards
//
//  Created by Paul Fitzgerald on 13/04/2023.
//

import SwiftUI
import ConfettiSwiftUI

struct MatchesView: View {
    var matches: [TranslatedItem]
    
    @State private var isPlaying: Bool = false
    @State private var guesses: [String] = []
    @State private var correctAnswers: [String] = []
    @State private var timePassed = 0.0
    @State private var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State private var displayedMatches: [TranslatedItem] = []
    @State private var gameOver: Bool = false
    @State private var englishWords: [String] = []
    @State private var portugueseWords: [String] = []
    @State private var completedAllMatches: Int = 0
    
    var body: some View {
        VStack {
            if gameOver == true {
                VStack {
                    HStack {
                        Spacer()
                        Text("Time up, try again.")
                        Spacer()
                    }
                    Button("Restart") {
                        timePassed = 0
                        displayedMatches = getRandomItems(from: matches)
                        correctAnswers = []
                        timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
                        gameOver = false
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(Color.black)
                }
           
            } else {
                if displayedMatches.count >= 5 {
                    VStack (alignment: .leading) {
                        Text("Tap the matching pairs")
                            .font(.system(size: 32, weight: .bold))
                        
                        ProgressView(value: timePassed, total: 500)
                              .onReceive(timer) { _ in
                                  if timePassed < 500 {
                                      timePassed += 2
                                  }
                                  
                                  if timePassed >= 500 {
                                      gameOver = true
                                  }
                                  
                                  if correctAnswers.count == 12 {
                                      completedAllMatches = 1
                                      timer.upstream.connect().cancel()
                                  }
                              }
                              .tint(.black)
                              .padding(.bottom, 8.0)
                        
                        Grid(alignment: .leading, horizontalSpacing: 18, verticalSpacing: 18) {
                            ForEach(0..<6) { index in
                                GridRow {
                                    MatchesCardView(text: portugueseWords[index], matches: matches, shouldSpeak: true, guesses: $guesses, correctAnswers: $correctAnswers)
                                    MatchesCardView(text: englishWords[index], matches: matches, shouldSpeak: false, guesses: $guesses, correctAnswers: $correctAnswers)
                                }
                            }
                        }
                        HStack {
                            Spacer()
                            Button("Restart") {
                                timePassed = 0
                                displayedMatches = getRandomItems(from: matches)
                                englishWords = displayedMatches.map { $0.english }.shuffled()
                                portugueseWords = displayedMatches.map { $0.portuguese }.shuffled()
                                correctAnswers = []
                                timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
                                gameOver = false
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(Color.black)
                            
                        }
                        .padding(.vertical, 8.0)
                    }
                    .padding()
                    .confettiCannon(counter: $completedAllMatches, num: 100, confettiSize: 20.0, radius: 500.0, repetitions: 4, repetitionInterval: 0.7)
                } else {
                    Text("At least 6 translations required")
                }
                
            }
        }
        .onAppear {
            if !isPlaying {
                isPlaying = true
                displayedMatches = getRandomItems(from: matches)
                englishWords = displayedMatches.map { $0.english }.shuffled()
                portugueseWords = displayedMatches.map { $0.portuguese }.shuffled()
            }
        }
    }
}


struct MatchesView_Previews: PreviewProvider {
    static var previews: some View {
        MatchesView(matches: [
            TranslatedItem(english: "hello", portuguese: "ola"),
            TranslatedItem(english: "although", portuguese: "embora"),
            TranslatedItem(english: "name", portuguese: "nome"),
            TranslatedItem(english: "body", portuguese: "corpo"),
            TranslatedItem(english: "arm", portuguese: "braço"),
            TranslatedItem(english: "neck", portuguese: "pescoco"),
            TranslatedItem(english: "elbow", portuguese: "cortovelo"),
        ])
    }
}
