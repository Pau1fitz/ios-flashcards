//
//  SoundManager.swift
//  Flashcards
//
//  Created by Paul Fitzgerald on 10/04/2023.
//

import Foundation
import AVKit
import Combine
import MediaPlayer
import AVFoundation

class SoundManager : ObservableObject {
    var audioPlayer: AVPlayer?
    
    @Published var isBuffering = false
    @Published var stationPlaying: RadioStation? = nil
    @Published var isPlaying = false
   
    private var observation: AnyCancellable?
    
    func play() {
        isPlaying = true
        self.audioPlayer!.play()
    }
    
    func pause() {
        isPlaying = false
        self.audioPlayer!.pause()
    }
    
    func setupRemoteTransportControls() {
        let commandCenter = MPRemoteCommandCenter.shared()

        commandCenter.playCommand.isEnabled = true
        commandCenter.playCommand.addTarget { [unowned self] event in
            if !self.isPlaying {
                self.play()
                return .success
            }
            return .commandFailed
        }
        
        commandCenter.pauseCommand.isEnabled = true
        commandCenter.pauseCommand.addTarget { [unowned self] event in
            if self.isPlaying {
                self.pause()
                return .success
            }
            return .commandFailed
        }
    }
    
    func setupNowPlaying() {
        var nowPlayingInfo = [String : Any]()
        nowPlayingInfo[MPMediaItemPropertyTitle] = stationPlaying?.name
        if let image = UIImage(named: stationPlaying!.smallImage) {
            nowPlayingInfo[MPMediaItemPropertyArtwork] =
                MPMediaItemArtwork(boundsSize: image.size) { size in
                    return image
            }
        }
        
        nowPlayingInfo[MPNowPlayingInfoPropertyIsLiveStream] = true
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
    }
    
    func playSound(radioStation: RadioStation){
        if let url = URL(string: radioStation.url) {
            self.audioPlayer = AVPlayer(url: url)
            self.stationPlaying = radioStation
            
            observation = audioPlayer?.currentItem?.publisher(for: \.isPlaybackBufferEmpty).sink(receiveValue: { [weak self] isBuffering in
              self?.isBuffering = isBuffering
            })
            
            do {
                try AVAudioSession.sharedInstance().setCategory(.playAndRecord, mode: .default, policy: .default, options: .defaultToSpeaker)
                try AVAudioSession.sharedInstance().setActive(true)
            } catch {
                print(error.localizedDescription)
            }
            
            self.audioPlayer!.audiovisualBackgroundPlaybackPolicy = .continuesIfPossible
            
            setupRemoteTransportControls()
            setupNowPlaying()
        }
    }
}
