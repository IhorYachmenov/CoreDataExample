//
//  DataLayerTests.swift
//  iTunesSearchTests
//
//  Created by user on 20.02.2023.
//

import XCTest
@testable import iTunesSearch
import Data_Transfer_Objects
import Data_Layer

class PersistentStorageRepositoryTests: XCTestCase {
    private var repositoryPattern: PersistentStorageRepositoryInterface!
    
    override func setUp() {
        super.setUp()
        
        repositoryPattern = PersistentStorageRepository()
    }
    
    override func tearDown() {
        super.tearDown()
        
        repositoryPattern = nil
    }
    
    func testPersistentStorageRepository_saveAndFetch() {
        let savingTestData = DTO.SingerTrack(
            trackName: "Rommance",
            singerName: "Lady Gaga",
            trackPrice: "9.99",
            country: "USA",
            collectionName: "Test Collection",
            collectionPrice: "9.99",
            releaseDate: "-",
            genre: "-",
            demoURL: "_",
            trackImgURL: "-",
            trackId: "0001")
        
        repositoryPattern.saveSingerTrack(singerTrack: savingTestData) { error in
            XCTAssertNil(error)
        }
        
        repositoryPattern.observeData { dataModel in
            XCTAssert(dataModel.count == 1)
            XCTAssert(dataModel.last!.trackId == savingTestData.trackId && dataModel.last!.trackName == savingTestData.trackName)
        }
    }
}
