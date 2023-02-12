//
//  CoordinatorsTests.swift
//  iTunesSearchTests
//
//  Created by user on 12.02.2023.
//

import UIKit
import XCTest
@testable import iTunesSearch

class CoordinatorsTests: XCTestCase {
    
    var window: UIWindow!
    var navigationController: UINavigationController!
    var router: AppRouter!
    var appCoordinator: AppCoordinator!
    var singerTracksCoordinator: SingerTracksCoordinator!
    var sinderTrackDetailsCoordinator: SingerTrackDetailsCoordinator!
    
    override func setUp() {
        super.setUp()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        navigationController = UINavigationController()
        router = AppRouter(navigationController: navigationController)
        appCoordinator = AppCoordinator(window: window, router: router)
        singerTracksCoordinator = SingerTracksCoordinator(router: router)
        sinderTrackDetailsCoordinator = SingerTrackDetailsCoordinator(router: router, id: 1)
    }
    
    override func tearDown() {
        super.tearDown()
        
        window = nil
        navigationController = nil
        router = nil
        appCoordinator = nil
        singerTracksCoordinator = nil
        sinderTrackDetailsCoordinator = nil
    }
    
    func testCoordinatorFlow() {
        // Start the app coordinator
        appCoordinator.start()
        
        // Check that the window is now visible
        XCTAssertTrue(window.isKeyWindow)
        
        // Start the singer tracks coordinator
        singerTracksCoordinator.start()
        
        // Check that the top view controller is the singer tracks view controller
        XCTAssertTrue(router.navigationController.topViewController is SingerTracksViewController)
        
        // Start the singer track details coordinator
        sinderTrackDetailsCoordinator.start()
        
        // Check that the top view controller is the singer track details view controller
        XCTAssertTrue(router.navigationController.topViewController is SingerTrackDetailsViewController)
        
        // Check that the singer track details view controller has the correct id
        guard let singerTrackDetailsVC = router.navigationController.topViewController as? SingerTrackDetailsViewController else {
            XCTFail("Top view controller should be a SingerTrackDetailsViewController")
            return
        }
        XCTAssertEqual(singerTrackDetailsVC.trackId, 1)
    }
}
