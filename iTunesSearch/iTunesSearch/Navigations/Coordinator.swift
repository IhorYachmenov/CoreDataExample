//
//  Coordinator.swift
//  iTunesSearch
//
//  Created by user on 06.02.2023.
//

import UIKit

//protocol Coordinator: AnyObject {
//    var children: [Coordinator] { get set }
//    var navigationController : UINavigationController? { get }
//    func start(id: Int?)
//}
//
//extension Coordinator {
//    func start(id: Int?) {
//        children.append(self)
//    }
//}

protocol Coordinator: AnyObject {
    var children: [Coordinator] { get set }
    var router: Router { get }
    
    func start()
    func stop()
    func coordinate(to coordinator: Coordinator)
}

protocol Router: AnyObject {
    var navigationController: UINavigationController { get }
    
    func present(_ viewController: UIViewController, animated: Bool)
    func dismiss(animated: Bool)
    func push(_ viewController: UIViewController, animated: Bool)
    func pop(animated: Bool)
}

extension Coordinator {
    func coordinate(to coordinator: Coordinator) {
        children.append(coordinator)
        coordinator.start()
    }
}
