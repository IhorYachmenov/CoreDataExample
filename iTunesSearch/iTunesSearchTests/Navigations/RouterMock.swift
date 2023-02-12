//
//  RouterMock.swift
//  iTunesSearchTests
//
//  Created by user on 12.02.2023.
//

import UIKit
@testable import iTunesSearch

class RouterMock: Router {
    
    var navigationController = UINavigationController()
    var pushCalled = false
    var pushViewController: UIViewController?
    var dismissCalled = false
    
    func push(_ viewController: UIViewController, animated: Bool) {
        pushCalled = true
        pushViewController = viewController
    }
    
    func dismiss(animated: Bool, completion: (() -> Void)?) {
        dismissCalled = true
        completion?()
    }
    
}
