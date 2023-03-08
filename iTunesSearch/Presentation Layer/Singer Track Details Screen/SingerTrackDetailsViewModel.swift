//
//  SingerTrackDetailsViewModel.swift
//  iTunesSearch
//
//  Created by user on 13.02.2023.
//

import Foundation
import Domain_Layer
import Data_Transfer_Objects

public final class SingerTrackDetailsViewModel: SingerTrackDetailsViewModelInterface {
    private var trackId: String
    private var audioURL: String?
    private var useCase: SingerTrackDetailsUseCaseInterface
    private var audioPlayerUseCase: AudioPlayerUseCaseInterface
    private lazy var dataModel = PresentationModel.SingerTrackDetails()
    
    public var observeData: ((Result<PresentationModel.SingerTrackDetails, Error>) -> ())?
    
    public init(trackId: String, useCase: SingerTrackDetailsUseCaseInterface, audioPlayerUseCase: AudioPlayerUseCaseInterface) {
        self.useCase = useCase
        self.trackId = trackId
        self.audioPlayerUseCase = audioPlayerUseCase
        
        self.useCase.fetchTrackDetails(trackId: trackId) { [weak self] failure in
            if let failure = failure {
                DispatchQueue.main.async {
                    self?.observeData?(.failure(failure))
                }
            }
        }
        
        self.useCase.observeData { [weak self] data in
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
        
        self.audioPlayerUseCase.observeData(completion: { [weak self] data in
            self?.dataModel.track = PresentationModel.SingerTrackDetails.Track(mediaModel: data)
            self?.pushDataModel()
        })
    }
    
    public func playTrack() {
        audioPlayerUseCase.playTrack(url: audioURL) { failure in
            if let failure = failure {
                DispatchQueue.main.async { [weak self] in
                    self?.observeData?(.failure(failure))
                }
            }
        }
    }
    
    private func pushDataModel() {
        DispatchQueue.main.async { [weak self] in
            self?.observeData?(.success(self!.dataModel))
        }
    }
}
