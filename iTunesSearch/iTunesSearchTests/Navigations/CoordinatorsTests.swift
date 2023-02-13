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
    
    override func setUp() {
        super.setUp()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        navigationController = UINavigationController()
        router = AppRouter(navigationController: navigationController)
        appCoordinator = AppCoordinator(window: window, router: router)
        singerTracksCoordinator = SingerTracksCoordinator(router: router)
    }
    
    override func tearDown() {
        super.tearDown()
        
        window = nil
        navigationController = nil
        router = nil
        appCoordinator = nil
        singerTracksCoordinator = nil
    }
    
    func testAppCordinators_openTrackDetailScreen() {
        appCoordinator.start()

        XCTAssert(router.navigationController.viewControllers.count == 1)
        XCTAssert(router.navigationController.topViewController is SingerTracksViewController)

        // Simulate user tapping a track cell
        singerTracksCoordinator.coordinator(didSelectTrackWithId: 1)

        let detailsViewControllerExpectation = XCTestExpectation(description: "Wait for details screen to appear")

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            detailsViewControllerExpectation.fulfill()
        }

        wait(for: [detailsViewControllerExpectation], timeout: 1.1)

        XCTAssert(router.navigationController.viewControllers.count == 2)
        XCTAssert(router.navigationController.topViewController is SingerTrackDetailsViewController) 
    }
}
