//
//  AudioPlayer.swift
//  iTunesSearch
//
//  Created by user on 15.02.2023.
//

import Foundation
import AVFoundation

class AudioClient: AudioClientInterface {
    typealias AudioObject = MediaModel.PlayerObject
    
    var audioDataPublisher: ((Result<AudioObject, Error>) -> ())?
    
    // Update progress later
    private let progress = Progress(totalUnitCount: 100)
    private var player: AVAudioPlayer!
    
    init() {
        
    }
    
    func playTrack(url: URL) {
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player.prepareToPlay()
            player.play()
        } catch {
            print("Error Playing Audio ", error)
        }
    }
}


