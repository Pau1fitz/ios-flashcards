//
//  RadioStationView.swift
//  Flashcards
//
//  Created by Paul Fitzgerald on 10/04/2023.
//

import SwiftUI

struct RadioStationView: View {
    var radioStation: RadioStation
    var soundManager: SoundManager
    var isBuffering: Bool
    
    @State var isPlaying = false
    
    var body: some View {
        VStack {
            VStack {
                Spacer()
                Image(radioStation.logo)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150.0, height: 150.0)
                        
                Spacer()

                if(isBuffering) {
                    VStack {
                        ProgressView()
                    }
                    .frame(width: 55.0, height: 55.0)
                    
                } else {
                    Image(systemName: isPlaying ? "pause.circle": "play.circle")
                        .font(.system(size: 50))
                        .padding(.trailing)
                        .onTapGesture {
                            soundManager.playSound(sound: radioStation.url)
                            !isPlaying ? soundManager.audioPlayer?.play() : soundManager.audioPlayer?.pause()
                            isPlaying.toggle()
                        }
                }
                    
                Spacer()
            }
        }
        .onAppear(perform: {
            if(!isPlaying) {
                soundManager.playSound(sound: radioStation.url)
                soundManager.audioPlayer?.play()
                isPlaying.toggle()
            }
        
        })
    }
}

