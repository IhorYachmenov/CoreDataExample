//
//  Router.swift
//  iTunesSearch
//
//  Created by user on 08.02.2023.
//

import UIKit

protocol Router: AnyObject {
    func present( vc: UIViewController, id: Int)
    func dismiss( animated: Bool)
}

extension Router {
    
    func dismiss(_ animated: Bool) {
        
    }
}
