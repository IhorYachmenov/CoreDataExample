//
//  SingerTrackDetailsViewModel.swift
//  iTunesSearch
//
//  Created by user on 13.02.2023.
//

import Foundation

final class SingerTrackDetailsViewModel: SingerTrackDetailsViewModelInterface {
    var dataSource: ((Result<PresentationModel.SingerTrackDetails, Error>) -> ())?
    
    private var trackId: String
    private var audioURL: String?
    private var useCase: SingerTrackDetailsUseCaseInterface
    
    private var dataModel = PresentationModel.SingerTrackDetails()
    
    init(trackId: String, useCase: SingerTrackDetailsUseCaseInterface) {
        self.useCase = useCase
        self.trackId = trackId
        
        self.useCase.fetchTrackDetails(trackId: trackId) { [weak self] failure in
            if let failure = failure {
                DispatchQueue.main.async {
                    self?.dataSource?(.failure(failure))
                }
            }
        }
        
        self.useCase.subscribeOnData { [weak self] data in
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

    }
    
    func playTrack() {
        useCase.playTrack(url: audioURL)
    }
    
    
    private func pushDataModel() {
        dataSource?(.success(dataModel))
    }
}
