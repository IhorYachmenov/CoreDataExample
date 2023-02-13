//
//  iTunesSearchTests.swift
//  iTunesSearchTests
//
//  Created by user on 24.01.2023.
//

import XCTest
@testable import iTunesSearch

class SingerTrackDetailsCoordinatorTests: XCTestCase {
    var sut: SingerTrackDetailsCoordinator!
    var router: RouterMock!
    
    override func setUp() {
        super.setUp()
        
        router = RouterMock()
        sut = SingerTrackDetailsCoordinator(router: router, id: 1)
    }
    
    override func tearDown() {
        super.tearDown()
        
        router = nil
        sut = nil
    }
    
    func testStart() {
        sut.start()
        XCTAssertTrue(router.pushCalled)
        XCTAssertTrue(router.pushViewController is SingerTrackDetailsViewController)
    }
    
    func testStop() {
        sut.stop()
        XCTAssertTrue(router.dismissCalled)
    }
    
    func testDismissCoordinator() {
        var coordinatorFinished = false
        sut.onDetailCoordinatorFinished = {
            coordinatorFinished = true
        }
        
        sut.start()
        sut.dismissCoordinator()
        XCTAssertTrue(coordinatorFinished)
    }
}
