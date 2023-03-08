//
//  SingerClipScreen.swift
//  iTunesSearch
//
//  Created by user on 05.03.2023.
//

import UIKit

protocol SingerClipDelegate: AnyObject {
    func openClip()
}

class SingerClipScreen: UIViewController {
    /// Navigation
    weak var coodinatorDelegate: SingerClipDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUIComponents()
        coodinatorDelegate?.openClip()
    }
    
    deinit {
        print("SingerClipScreen VC deinit")
    }
    
    private func initUIComponents() {
        view.backgroundColor = .systemGray
    }
    
}
