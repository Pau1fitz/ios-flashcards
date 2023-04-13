//
//  CardView.swift
//  Flashcards
//
//  Created by Paul Fitzgerald on 07/04/2023.
//

import SwiftUI

struct CardView: View {
    var card: TranslatedItem
    var selectedLanguage: String
    
    @Binding var isShowingAnswer: Bool
    @State private var offset = CGSize.zero
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(.white)
                .shadow(radius: 2.0)

            VStack {
                VStack {
                    Text(selectedLanguage == "EN" ? card.english : card.portuguese)
                        .fontWeight(.heavy)
                        .font(.system(size: 18))
                }
                .padding([.vertical], 8.0)
               
                if isShowingAnswer {
                    Text(selectedLanguage == "EN" ? card.portuguese : card.english)
                        .opacity(0.8)
                        .font(.system(size: 16))
                }
            }
            .padding(20)
            .multilineTextAlignment(.center)
        }
        .padding()
        .frame(width: UIScreen.main.bounds.size.width, height: 250)
        .onTapGesture {
            withAnimation {
                isShowingAnswer.toggle()
            }
        }
    }
}

