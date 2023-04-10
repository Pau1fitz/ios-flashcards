//
//  Card.swift
//  Flashcards
//
//  Created by Paul Fitzgerald on 07/04/2023.
//

import Foundation

struct Card {
    let prompt: String
    let answer: String

    static let example = Card(prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")
}
