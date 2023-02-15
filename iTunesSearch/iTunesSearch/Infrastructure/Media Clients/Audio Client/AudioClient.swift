//
//  AudioPlayer.swift
//  iTunesSearch
//
//  Created by user on 15.02.2023.
//

import Foundation
import AVFoundation

struct PlayerObject {
    let currentTime: String
    let duration: String
    let isPaused: Bool
    let progress: Progress
}

class AudioClient: AudioClientInterface {
    typealias AudioObject = PlayerObject
    
    var audioDataPublisher: ((Result<AudioObject, Error>) -> ())?
    
    // Update progress later
    private let progress = Progress(totalUnitCount: 100)
    private var player: AVAudioPlayer!
    
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


