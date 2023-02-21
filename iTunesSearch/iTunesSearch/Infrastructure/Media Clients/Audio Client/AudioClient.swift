//
//  AudioPlayer.swift
//  iTunesSearch
//
//  Created by user on 15.02.2023.
//

import AVFoundation

class AudioClient: NSObject, AudioClientInterface {
    var dataPublisher: ((MediaModel.AudioData) -> ())?
    
    private var model: MediaModel.AudioData!
    private var audioPlayer: AVAudioPlayer!
    private var timer: Timer?
    
    override init() {
        model = MediaModel.AudioData(currentTime: "00:00", duration: "00:00", isPlaying: false, progress: 0)
    }
   
    func playTrack(url: URL, completion: @escaping (Error?) -> ()) {
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
 
            model = MediaModel.AudioData(currentTime: currentTimeString, duration: durationString, isPlaying: audioPlayer.isPlaying, progress: progress)
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
