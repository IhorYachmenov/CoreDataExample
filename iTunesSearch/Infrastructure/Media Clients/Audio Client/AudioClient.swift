//
//  AudioPlayer.swift
//  iTunesSearch
//
//  Created by user on 15.02.2023.
//

import Foundation
import AVFoundation
import Data_Model_Layer

public final class AudioClient: NSObject, AudioClientInterface {
    public var dataPublisher: ((DTO.AudioData) -> ())?
    
    private var model: DTO.AudioData!
    private var audioPlayer: AVAudioPlayer!
    private var timer: Timer?
    
    public override init() {
        model = DTO.AudioData(currentTime: "00:00", duration: "00:00", isPlaying: false, progress: 0)
    }
   
    public func playTrack(url: URL, completion: @escaping (Error?) -> ()) {
        if let audioPlayer = audioPlayer {
            if (audioPlayer.isPlaying) {
                audioPlayer.pause()
                pauseDataUpdates()
                return
            } else {
                audioPlayer.play()
                enableDataUpdates()
                return
            }
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer.delegate = self
            if (audioPlayer.prepareToPlay()) {
                audioPlayer.play()
                enableDataUpdates()
                completion(nil)
            }
        } catch {
            completion(error)
        }
    }

    private func pushUpdate(){
        dataPublisher?(model)
    }
    
    private func enableDataUpdates() {
        DispatchQueue.main.async { [weak self] in
            self?.timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] timer in
                self?.trackData()
            }
        }
    }
    
    private func pauseDataUpdates() {
        DispatchQueue.main.async { [weak self] in
            self?.timer?.invalidate()
            self?.timer = nil
            self?.model.isPlaying = false
            self?.pushUpdate()
        }
    }
    
    @objc private func trackData() {
        if let audioPlayer = audioPlayer {
            let currentTime = audioPlayer.currentTime
            let duration = audioPlayer.duration
            let progress = Float(currentTime / duration)
            let currentTimeString = String(format: "%02d:%02d", Int(currentTime / 60), Int(currentTime.truncatingRemainder(dividingBy: 60)))
            let durationString = String(format: "%02d:%02d", Int(duration / 60), Int(duration.truncatingRemainder(dividingBy: 60)))
 
            model = DTO.AudioData(currentTime: currentTimeString, duration: durationString, isPlaying: audioPlayer.isPlaying, progress: progress)
            pushUpdate()
        }
    }
}

// MARK: - AVAudioPlayerDelegate
extension AudioClient: AVAudioPlayerDelegate {
    public func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        timer?.fire()
        audioPlayer = nil
    }
}
