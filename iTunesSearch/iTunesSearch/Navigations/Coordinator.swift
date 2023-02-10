//
//  Coordinator.swift
//  iTunesSearch
//
//  Created by user on 06.02.2023.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigationController : UINavigationController? { get }
    func start(id: Int?)
}

