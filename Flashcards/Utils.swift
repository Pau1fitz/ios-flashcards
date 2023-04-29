//
//  Utils.swift
//  Flashcards
//
//  Created by Paul Fitzgerald on 13/04/2023.
//

import Foundation
import SwiftUI

struct EdgeBorder: Shape {
    var width: CGFloat
    var edges: [Edge]

    func path(in rect: CGRect) -> Path {
        var path = Path()
        for edge in edges {
            var x: CGFloat {
                switch edge {
                case .top, .bottom, .leading: return rect.minX
                case .trailing: return rect.maxX - width
                }
            }

            var y: CGFloat {
                switch edge {
                case .top, .leading, .trailing: return rect.minY
                case .bottom: return rect.maxY - width
                }
            }

            var w: CGFloat {
                switch edge {
                case .top, .bottom: return rect.width
                case .leading, .trailing: return width
                }
            }

            var h: CGFloat {
                switch edge {
                case .top, .bottom: return width
                case .leading, .trailing: return rect.height
                }
            }
            path.addRect(CGRect(x: x, y: y, width: w, height: h))
        }
        return path
    }
}

extension View {
    func border(width: CGFloat, edges: [Edge], color: Color) -> some View {
        overlay(EdgeBorder(width: width, edges: edges).foregroundColor(color))
    }
}


func getRandomItems(from items: [TranslatedItem]) -> [TranslatedItem] {
    if items.count == 0 {
        return []
    }
    var newItems: [TranslatedItem] = []
    var chosenItems: Set<TranslatedItem> = []

    while newItems.count < 6 {
        let randomIndex = Int.random(in: 0..<items.count)
        let item = items[randomIndex]
        if !chosenItems.contains(item) {
            newItems.append(item)
            chosenItems.insert(item)
        }
    }
    return newItems
}

func checkGuesses(guesses: [String], allItems: [TranslatedItem]) -> Bool {
    print("allItems")
    print(allItems)
    var found = false
    for item in allItems {
        if (guesses[0] == item.english && guesses[1] == item.portuguese || guesses[1] == item.english && guesses[0] == item.portuguese) {
            found = true
            break
        }
    }
    return found
}
