//
//  TranslatedItem.swift
//  Flashcards
//
//  Created by Paul Fitzgerald on 10/04/2023.
//

import Foundation

struct TranslatedItem: Identifiable, Codable {
    let id: UUID
    var english: String
    var portuguese: String
    
    init(id: UUID = UUID(), english: String, portuguese: String) {
        self.id = id
        self.english = english
        self.portuguese = portuguese
    }
}
