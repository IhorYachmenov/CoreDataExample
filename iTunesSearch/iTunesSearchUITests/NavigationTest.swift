//
//  NavigationTest.swift
//  iTunesSearchUITests
//
//  Created by user on 10.02.2023.
//

import XCTest
import iTunesSearch

final class NavigationTest: XCTestCase {
    private var sut: SingerTrackDetailsViewController!
    
    override func setUp() {
        super.setUp()
        
        sut = SingerTrackDetailsViewController()
    }
    
    override func tearDown() {
        super.tearDown()
        
        sut = nil
    }
}
