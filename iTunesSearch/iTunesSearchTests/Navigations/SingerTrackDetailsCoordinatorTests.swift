//
//  iTunesSearchTests.swift
//  iTunesSearchTests
//
//  Created by user on 24.01.2023.
//

import XCTest
@testable import iTunesSearch

final class iTunesSearchTests: XCTestCase {

    private var appCoordinator: AppCoordinator!
    private var navigatioContoller: UINavigationController!
    private var singerTracksCoordinator: SingerTracksCoordinator!
    private var singerTrackDetails: SingerTrackDetailsCoordinator!
    
    override func setUp() {
        super.setUp()
        navigatioContoller = UINavigationController.init()
        appCoordinator = AppCoordinator(navigationController: navigatioContoller)
        singerTracksCoordinator = SingerTracksCoordinator(navigationController: appCoordinator.navigationController)
        singerTrackDetails = SingerTrackDetailsCoordinator(navigationController: singerTracksCoordinator.navigationController)


    }
    
    override func tearDown() {
        super.tearDown()
        
        navigatioContoller = nil
        appCoordinator = nil
    }
    
    func testSingerTrackDetailsViewController_PresentViewController() {
        appCoordinator.start(id: nil)
        singerTracksCoordinator.start(id: nil)
        singerTrackDetails.start(id: nil)
        
        XCTAssertEqual(singerTrackDetails.children.count, 3)
        
    }
}
