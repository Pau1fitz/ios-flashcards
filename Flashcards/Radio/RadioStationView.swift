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
    
    var body: some View {
        VStack {
            VStack {
                Spacer()
                Image(radioStation.logo)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150.0, height: 150.0)
                        
                Spacer()

                if isBuffering {
                    VStack {
                        ProgressView()
                    }
                    .frame(width: 55.0, height: 55.0)
                    
                } else {
                    Image(systemName: soundManager.isPlaying ? "pause.circle": "play.circle")
                        .font(.system(size: 50))
                        .padding(.trailing)
                        .onTapGesture {
                            soundManager.playSound(radioStation: radioStation)
                            !soundManager.isPlaying ? soundManager.play() : soundManager.pause()
                        }
                }
                    
                Spacer()
            }
        }
        .onAppear(perform: {
            if soundManager.stationPlaying?.name != radioStation.name {
                soundManager.playSound(radioStation: radioStation)
                soundManager.play()
            }
        
        })
    }
}


