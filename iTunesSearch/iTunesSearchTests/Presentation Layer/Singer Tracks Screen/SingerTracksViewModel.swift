//
//  SingerTracksViewModel.swift
//  iTunesSearchTests
//
//  Created by user on 20.02.2023.
//

import XCTest
@testable import iTunesSearch

class SingerTracksViewModelTests: XCTestCase {
    var viewModel: SingerTracksViewModelInterface!
    var downloadUseCase: DownloadSingerTrackUseCaseInterface!
    
    override func setUp() {
        super.setUp()
        
        downloadUseCase = DownloadSingerTrackUseCaseMoc()
        let useCase = SingerTracksWorkerUseCase(useCase: downloadUseCase, useCase: StorageSingerTracksUseCase(storageRepository: PersistentStorageRepository()))
        viewModel = SingerTracksViewModel(useCase: useCase)
    }
    
    override func tearDown() {
        super.tearDown()
        
        viewModel = nil
        downloadUseCase = nil
    }
    
    func testSingerTracksViewModel_downloadAndSave() {
        viewModel.downloadSong()
        viewModel.dataSource = { result in
            switch result {
            case .success(let data):
                XCTAssert(data.last!.trackId == "0001" && data.last!.trackName == "Rommance")
            case .failure(_):
                break
            }
        }
    }
}
