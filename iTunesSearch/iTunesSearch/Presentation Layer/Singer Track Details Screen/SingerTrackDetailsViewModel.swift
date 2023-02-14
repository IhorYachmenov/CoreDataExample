//
//  SingerTrackDetailsViewModel.swift
//  iTunesSearch
//
//  Created by user on 13.02.2023.
//

import Foundation

final class SingerTrackDetailsViewModel: SingerTrackDetailsViewModelInterface {
    
    var imageSource: ((Result<Data, Error>) -> ())?
    
    private var useCase: SingerTrackDetailsUseCaseInterface
    
    init(useCase: SingerTrackDetailsUseCaseInterface) {
        self.useCase = useCase
    }
    
    func fetchTrackDetails(trackId: String, completion: @escaping (Result<PresentationModel.SingerTrackDetail, StorageError>) -> ()) {
        useCase.fetchTrackDetails(trackId: trackId) { [weak self] result in
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    completion(.success(PresentationModel.SingerTrackDetail(dataModel: success)))
                }
                
                let url = URL(string: success.trackImgURL)
                
                if let url = url {
                    self?.useCase.downloadImage(url: url) { result in
                        switch result {
                        case .success(let success):
                            self?.imageSource?(.success(success))
                        case .failure(let failure):
                            self?.imageSource?(.failure(failure))
                        }
                    }
                }
                
            case .failure(let failure):
                DispatchQueue.main.async {
                    completion(.failure(failure))
                }
            }
        }
    }
}
