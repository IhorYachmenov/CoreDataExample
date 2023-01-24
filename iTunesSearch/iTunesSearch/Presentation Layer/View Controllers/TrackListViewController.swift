//
//  ViewController.swift
//  iTunesSearch
//
//  Created by user on 24.01.2023.
//

import UIKit

class TrackListViewController: UIViewController {

    private lazy var viewModel = TrackListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        
        viewModel.findArtistTracks(Artist: "Janet Jackson") { result in
            switch result {
            case .success(let success):
                print(success)
            case .failure(let failure):
                print("Failure")
            }
        }
    }
    
}

