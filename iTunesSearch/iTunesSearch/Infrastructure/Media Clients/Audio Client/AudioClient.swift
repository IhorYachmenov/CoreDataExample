//
//  AudioPlayer.swift
//  iTunesSearch
//
//  Created by user on 15.02.2023.
//

import Foundation
import AVFoundation

class AudioClient {
    
    var player: AVAudioPlayer!
    
    init() {
        
    }
    
    func playTrack(url: URL) {
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player.play()
        } catch {
            print("Error Playing Audio ", error)
        }
    }
}

extension AudioClient: AudioClientInterface {
    
}
