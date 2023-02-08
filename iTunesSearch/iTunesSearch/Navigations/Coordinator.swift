//
//  Coordinator.swift
//  iTunesSearch
//
//  Created by user on 06.02.2023.
//

import UIKit

protocol Coordinator : AnyObject {
    var parentCoordinator: Coordinator? { get set }
    var children: [Coordinator] { get set }
    var navigationController : UINavigationController { get set }
    
    func start()
}

