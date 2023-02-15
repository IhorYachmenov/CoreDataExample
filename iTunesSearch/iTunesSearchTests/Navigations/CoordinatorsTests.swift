//
//  CoordinatorsTests.swift
//  iTunesSearchTests
//
//  Created by user on 12.02.2023.
//

import XCTest
@testable import iTunesSearch

class CoordinatorsTests: XCTestCase {
    var window: WindowMock!
    var router: Router!
    var appCoordinator: AppCoordinator!
    
    override func setUp() {
        super.setUp()
        
        window = WindowMock()
        router = RouterMock()
        appCoordinator = AppCoordinator(window: window, router: router)
    }
    
    override func tearDown() {
        super.tearDown()
        
        window = nil
        router = nil
        appCoordinator = nil
    }
    
    func testAppCordinators_openTrackDetailScreen() {
        // Run app coordinator
        appCoordinator.start()

        XCTAssert(appCoordinator.children.count == 1)
        XCTAssert(appCoordinator.children.last is SingerTracksCoordinator)

        // Open track details coordinator
        let tracksCoordinator = appCoordinator.children.last as! SingerTracksCoordinator
        tracksCoordinator.coordinator(didSelect: "1")
        
        XCTAssert(tracksCoordinator.children.count == 1)
        XCTAssert(tracksCoordinator.children.last is SingerTrackDetailsCoordinator)
        
        // Close track detail coordinator
        let trackDetailsCoordinator = tracksCoordinator.children.last as! SingerTrackDetailsCoordinator
        trackDetailsCoordinator.stop()
        
        XCTAssert(tracksCoordinator.children.count == 0)
    }
}
