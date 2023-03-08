//
//  Router.swift
//  iTunesSearch
//
//  Created by user on 08.02.2023.
//

import UIKit

protocol Router: AnyObject {
    var coordinatorComponent: CoordinatorComponents { get }
    
    func present(_ viewController: UIViewController, animated: Bool)
    func dismiss(animated: Bool, completion: (() -> Void)?)
    func push(_ viewController: UIViewController, animated: Bool)
    func pop(animated: Bool)
}



