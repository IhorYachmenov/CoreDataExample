//
//  SingerClipScreen.swift
//  iTunesSearch
//
//  Created by user on 05.03.2023.
//

import UIKit

protocol SingerClipDelegate: AnyObject {
    func clipScreenDidDismissed()
}

class SingerClipScreen: UIViewController {
    /// Navigation
    weak var coodinatorDelegate: SingerClipDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUIComponents()
    }
    
    private func initUIComponents() {
        view.backgroundColor = .systemGray
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
//        if (isMovingFromParent == false) {
//            coodinatorDelegate?.clipScreenDidDismissed()
//        }
    }
}
