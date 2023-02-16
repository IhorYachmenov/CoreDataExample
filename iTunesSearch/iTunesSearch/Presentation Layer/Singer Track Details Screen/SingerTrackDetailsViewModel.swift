//
//  SingerTrackDetailsViewModel.swift
//  iTunesSearch
//
//  Created by user on 13.02.2023.
//

import Foundation

final class SingerTrackDetailsViewModel: SingerTrackDetailsViewModelInterface {
    var audioDataSource: ((Result<PresentationModel.PlayerObject, Error>) -> ())?
    var imageDataSource: ((Result<Data, Error>) -> ())?
    
    private var useCase: SingerTrackDetailsUseCaseInterface
    
    init(useCase: SingerTrackDetailsUseCaseInterface) {
        self.useCase = useCase
        
        useCase.subscribeOnAudioData { [weak self] result in
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    self?.audioDataSource?(.success(PresentationModel.PlayerObject(mediaModel: success)))
                }
            case .failure(let failure):
                DispatchQueue.main.async {
                    self?.audioDataSource?(.failure(failure))
                }
            }
        }
    }
    
    func fetchTrackDetails(trackId: String, completion: @escaping (Result<PresentationModel.SingerTrackDetail, StorageError>) -> ()) {
        useCase.fetchTrackDetails(trackId: trackId) { [weak self] result in
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    completion(.success(PresentationModel.SingerTrackDetail(dataModel: success)))
                }
                
                self?.useCase.downloadImage(url: success.trackImgURL) { result in
                    switch result {
                    case .success(let success):
                        self?.imageDataSource?(.success(success))
                    case .failure(let failure):
                        self?.imageDataSource?(.failure(failure))
                    }
                }
            case .failure(let failure):
                DispatchQueue.main.async {
                    completion(.failure(failure))
                }
            }
        }
    }
    
    func playTrack(url: String?) {
        useCase.playTrack(url: url)
    }
}
