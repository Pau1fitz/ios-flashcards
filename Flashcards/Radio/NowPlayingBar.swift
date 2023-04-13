//
//  NowPlayingBar.swift
//  Flashcards
//
//  Created by Paul Fitzgerald on 13/04/2023.
//

import SwiftUI



struct NowPlayingBar<Content: View>: View {
    var content: Content
    var stationPlaying: RadioStation?
    
    @ViewBuilder var body: some View {
        ZStack(alignment: .bottom) {
            content
            if stationPlaying != nil {
                ZStack {
                    
                    Rectangle().foregroundColor(Color.white).frame(width: UIScreen.main.bounds.size.width, height: 60)
                        .border(width: 1, edges: [.top], color: .black)
                    HStack {
                        Button(action: {}) {
                            HStack {
                                AsyncImage(url: URL(string: stationPlaying!.image)) { image in
                                    image.resizable()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 45.0, height: 45.0)
                                .clipShape(RoundedRectangle(cornerRadius: 4.0))
                                .padding()
                                
                                Text(stationPlaying!.name)

                                Spacer()
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        Button(action: {
                            
                        }) {
                            Image(systemName: "play.fill").font(.title3)
                        }
                        .buttonStyle(PlainButtonStyle()).padding(.horizontal)
                    }
                }
                .offset(y: 10.0)
            }
        }
    }
}


