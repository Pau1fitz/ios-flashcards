//
//  MatchesView.swift
//  Flashcards
//
//  Created by Paul Fitzgerald on 13/04/2023.
//

import SwiftUI

struct MatchesView: View {
    var matches: [TranslatedItem]
    
    @State private var isPlaying: Bool = false
    @State private var guesses: [String] = []
    @State private var correctAnswers: [String] = []
    @State private var timePassed = 0.0
    @State private var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State private var displayedMatches: [TranslatedItem] = []
    @State private var gameOver: Bool = false
    

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
                                      timer.upstream.connect().cancel()
                                  }
                              }
                              .tint(.black)
                              .padding(.bottom, 8.0)
                        
                        Grid(alignment: .leading, horizontalSpacing: 18, verticalSpacing: 18) {
                            GridRow {
                                MatchesCardView(text: displayedMatches[0].portuguese, matches: matches, guesses: $guesses, correctAnswers: $correctAnswers)
                                MatchesCardView(text: displayedMatches[0].english, matches: matches, guesses: $guesses, correctAnswers: $correctAnswers)
                            }
                            GridRow {
                                MatchesCardView(text: displayedMatches[1].english, matches: matches, guesses: $guesses, correctAnswers: $correctAnswers)
                                MatchesCardView(text: displayedMatches[1].portuguese, matches: matches, guesses: $guesses, correctAnswers: $correctAnswers)
                            }
                            GridRow {
                                MatchesCardView(text: displayedMatches[2].portuguese, matches: matches, guesses: $guesses, correctAnswers: $correctAnswers)
                                MatchesCardView(text: displayedMatches[2].english, matches: matches, guesses: $guesses, correctAnswers: $correctAnswers)
                            }
                            GridRow {
                                MatchesCardView(text: displayedMatches[3].portuguese, matches: matches, guesses: $guesses, correctAnswers: $correctAnswers)
                                MatchesCardView(text: displayedMatches[3].english, matches: matches, guesses: $guesses, correctAnswers: $correctAnswers)
                            }
                            GridRow {
                                MatchesCardView(text: displayedMatches[4].english, matches: matches, guesses: $guesses, correctAnswers: $correctAnswers)
                                MatchesCardView(text: displayedMatches[4].portuguese, matches: matches, guesses: $guesses, correctAnswers: $correctAnswers)
                            }
                            GridRow {
                                MatchesCardView(text: displayedMatches[5].english, matches: matches, guesses: $guesses, correctAnswers: $correctAnswers)
                                MatchesCardView(text: displayedMatches[5].portuguese, matches: matches, guesses: $guesses, correctAnswers: $correctAnswers)
                            }
                        }
                        HStack {
                            Spacer()
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
                        .padding(.vertical, 8.0)
                    }
                    .padding()
                 
                } else {
                    Text("At least 6 translations required")
                }
                
            }
        }
        .onAppear {
            if !isPlaying {
                isPlaying = true
                displayedMatches = getRandomItems(from: matches)
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
