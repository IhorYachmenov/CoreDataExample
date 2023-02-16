//
//  SingerTrackDetailsViewModel.swift
//  iTunesSearch
//
//  Created by user on 13.02.2023.
//

import Foundation

final class SingerTrackDetailsViewModel: SingerTrackDetailsViewModelInterface {
    private var trackId: String
    private var audioURL: String?
    private var useCase: SingerTrackDetailsUseCaseInterface
    private var audioPlayerUseCase: AudioPlayerUseCaseInterface
    private lazy var dataModel = PresentationModel.SingerTrackDetails()
    
    var dataSource: ((Result<PresentationModel.SingerTrackDetails, Error>) -> ())?
    
    init(trackId: String, useCase: SingerTrackDetailsUseCaseInterface, audioPlayerUseCase: AudioPlayerUseCaseInterface) {
        self.useCase = useCase
        self.trackId = trackId
        self.audioPlayerUseCase = audioPlayerUseCase
        
        self.useCase.fetchTrackDetails(trackId: trackId) { [weak self] failure in
            if let failure = failure {
                DispatchQueue.main.async {
                    self?.dataSource?(.failure(failure))
                }
            }
        }
        
        self.useCase.subscribeOnTrackData { [weak self] data in
            if let data = data {
                self?.audioURL = data.demoURL
                self?.dataModel.details = PresentationModel.SingerTrackDetails.Details(dataModel: data)
                self?.pushDataModel()
                
                self?.useCase.downloadImage(url: data.trackImgURL) { [weak self] result in
                    switch result {
                    case .success(let success):
                        self?.dataModel.details?.image = success
                        self?.pushDataModel()
                    case .failure(_):
                        break
                    }
                }
            }
        }
        
        self.audioPlayerUseCase.subscribeOnAudioData(completion: { [weak self] result in
            switch result {
            case .success(let success):
                self?.dataModel.track = PresentationModel.SingerTrackDetails.Track(mediaModel: success)
                self?.pushDataModel()
            case .failure(let failure):
                DispatchQueue.main.async {
                    self?.dataSource?(.failure(failure))
                }
            }
        })

    }
    
    func playTrack() {
        audioPlayerUseCase.playTrack(url: audioURL) { error in
            if let error = error {
                DispatchQueue.main.async { [weak self] in
                    self?.dataSource?(.failure(error))
                }
            }
        }
    }
    
    
    private func pushDataModel() {
        DispatchQueue.main.async { [weak self] in
            self?.dataSource?(.success(self!.dataModel))
        }
    }
}
