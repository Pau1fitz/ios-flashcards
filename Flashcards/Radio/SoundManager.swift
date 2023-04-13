//
//  SoundManager.swift
//  Flashcards
//
//  Created by Paul Fitzgerald on 10/04/2023.
//

import Foundation
import AVKit
import Combine

class SoundManager : ObservableObject {
    var audioPlayer: AVPlayer?
    
    @Published var isBuffering = false
    @Published var stationPlaying: RadioStation? = nil
   
    private var observation: AnyCancellable?
    
    func playSound(radioStation: RadioStation){
        if let url = URL(string: radioStation.url) {
            self.audioPlayer = AVPlayer(url: url)
            observation = audioPlayer?.currentItem?.publisher(for: \.isPlaybackBufferEmpty).sink(receiveValue: { [weak self] isBuffering in
              self?.isBuffering = isBuffering
            })

            self.stationPlaying = radioStation
            do{
                try AVAudioSession.sharedInstance().setCategory(.playback)
                try AVAudioSession.sharedInstance().setActive(true)
            } catch {
                print(error.localizedDescription)
            }
            
            self.audioPlayer!.audiovisualBackgroundPlaybackPolicy = .continuesIfPossible
        }
    }
}
