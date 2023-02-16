//
//  AudioPlayer.swift
//  iTunesSearch
//
//  Created by user on 15.02.2023.
//

import Foundation
import AVFoundation

class AudioClient: NSObject, AudioClientInterface {
    var dataPublisher: ((MediaModel.AudioDetail) -> ())?
    
    private var model: MediaModel.AudioDetail!
    private var audioPlayer: AVAudioPlayer!
    private var timer: Timer?
    
    override init() {}
   
    func playTrack(url: URL, completion: @escaping (Error?) -> ()) {
        if let audioPlayer = audioPlayer {
            if (audioPlayer.isPlaying) {
                model.isPlaying = audioPlayer.isPlaying
                audioPlayer.pause()
                pauseDataUpdates()
                return
            } else {
                model.isPlaying = audioPlayer.isPlaying
                audioPlayer.play()
                enableDataUpdates()
                return
            }
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer.delegate = self
            if (audioPlayer!.prepareToPlay()) {
                audioPlayer!.play()
            
                enableDataUpdates()
                completion(nil)
            }
        } catch {
            completion(NSError.error(msg: error.localizedDescription))
        }
    }

    
    private func pushUpdate(){
        dataPublisher?(model)
    }
    
    private func enableDataUpdates() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] timer in
            self?.trackData()
        }
    }
    
    private func pauseDataUpdates() {
        DispatchQueue.main.async { [weak self] in
            self?.timer?.invalidate()
            self?.timer = nil
        }
    }
    
    
    @objc private func trackData() {
        if let audioPlayer = audioPlayer {
            let currentTime = audioPlayer.currentTime
            let duration = audioPlayer.duration
            let progress = Float(currentTime / duration)
            let currentTimeString = String(format: "%02d:%02d", Int(currentTime / 60), Int(currentTime.truncatingRemainder(dividingBy: 60)))
            let durationString = String(format: "%02d:%02d", Int(duration / 60), Int(duration.truncatingRemainder(dividingBy: 60)))
 
            model = MediaModel.AudioDetail(currentTime: currentTimeString, duration: durationString, isPlaying: audioPlayer.isPlaying, progress: progress)
            pushUpdate()
        }
    }
}

// MARK: - AVAudioPlayerDelegate
extension AudioClient: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        timer?.fire()
        audioPlayer = nil
    }
}
