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
    
    func fetchTrackDetailsWith(id: String, completion: @escaping (Result<PresentationModel.SingerTrackDetail, StorageError>) -> ()) {
        storageUseCase.fetchTrackDetailsWith(id: id) { result in
            switch result {
            case .success(let success):
                completion(.success(success.toViewEntity()))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}
