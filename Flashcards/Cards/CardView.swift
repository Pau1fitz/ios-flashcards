//
//  CardView.swift
//  Flashcards
//
//  Created by Paul Fitzgerald on 07/04/2023.
//

import SwiftUI

struct CardView: View {
    let card: TranslatedItem
    @Binding var isShowingAnswer: Bool
    @State private var offset = CGSize.zero
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(.white)
                .shadow(radius: 4)

            VStack {
                Text(card.portuguese)
                    .fontWeight(.heavy)
                    .font(.system(size: 14))

                if isShowingAnswer {
                    Text(card.english)
                        .opacity(0.8)
                        .font(.system(size: 12))
                }
            }
            .padding(20)
            .multilineTextAlignment(.center)
        }
        .padding()
        .frame(width: UIScreen.main.bounds.size.width, height: 250)
        .onTapGesture {
            isShowingAnswer.toggle()
        }
    }
}

