//
//  CardView.swift
//  Flashcards
//
//  Created by Paul Fitzgerald on 07/04/2023.
//

import SwiftUI

struct CardView: View {
    let card: Card
    
    @State private var isShowingAnswer = false
    @State private var offset = CGSize.zero
    
    var body: some View {
        GeometryReader {  geometry in
           
            ZStack {
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .fill(.white)
                    .shadow(radius: 4)

                VStack {
                    Text(card.prompt)
                        .font(.title2)
                        .foregroundColor(.black)

                    if isShowingAnswer {
                        Text(card.answer)
                            .font(.title2)
                            .foregroundColor(.gray)
                    }
                }
                .padding(20)
                .multilineTextAlignment(.center)
            }
            .padding()
            .frame(width: geometry.size.width, height: 250)
            .rotationEffect(.degrees(Double(offset.width / 5)))
            .offset(x: offset.width * 5, y: 0)
            .opacity(2 - Double(abs(offset.width / 50)))
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        offset = gesture.translation
                    }
                    .onEnded { _ in
                        if abs(offset.width) > 100 {
                            // remove the card
                        } else {
                            offset = .zero
                        }
                    }
            )
            .onTapGesture {
                isShowingAnswer.toggle()
            }
        }
       
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card.example)
    }
}
