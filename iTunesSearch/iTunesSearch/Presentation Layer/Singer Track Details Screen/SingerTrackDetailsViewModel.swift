//
//  SingerTrackDetailsViewModel.swift
//  iTunesSearch
//
//  Created by user on 13.02.2023.
//

import Foundation

final class SingerTrackDetailsViewModel: SingerTrackDetailsViewModelInterface {
    
    private var storageUseCase: SingerTrackDetailsUseCaseInterface
    
    init(useCase: SingerTrackDetailsUseCaseInterface) {
        storageUseCase = useCase
    }
    
    func fetchTrackDetails(trackId: String, completion: @escaping (Result<PresentationModel.SingerTrackDetail, StorageError>) -> ()) {
        storageUseCase.fetchTrackDetails(trackId: trackId) { result in
            switch result {
            case .success(let success):
                completion(.success(PresentationModel.SingerTrackDetail(dataModel: success)))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}
