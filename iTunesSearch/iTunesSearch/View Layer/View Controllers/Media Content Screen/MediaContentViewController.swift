//
//  SingerTrackMediaViewController.swift
//  iTunesSearch
//
//  Created by user on 05.03.2023.
//

import UIKit

protocol MediaContentDelegate: AnyObject {
    func dismissCoordinator()
    func openClipCoordinator()
}

class MediaContentViewController: UIViewController {
    /// Navigation
    weak var coodinatorDelegate: MediaContentDelegate?
    
    private lazy var openClipButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Imitation Of Opening"
        configuration.imagePlacement = .leading
        configuration.imagePadding = 15
        configuration.baseForegroundColor = .white
        configuration.cornerStyle = .large
        configuration.background.backgroundColor = .red
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 15, bottom: 15, trailing: 15)
        
        configuration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.backgroundColor = UIColor.red
            outgoing.font = UIFont.boldSystemFont(ofSize: 20)
            return outgoing
        }
        view.configuration = configuration
        
        view.addAction(UIAction(handler: { [weak self] _ in
            self?.coodinatorDelegate?.openClipCoordinator()
        }), for: .touchUpInside)
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUIComponents()
    }
    
    deinit {
        print("Media VC deinit")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if let navigationController = parent as? UINavigationController, navigationController.viewControllers.count == 1 {
            coodinatorDelegate?.dismissCoordinator()
        }
    }
    
    private func initUIComponents() {
        view.backgroundColor = .systemBackground
        
//        isModalInPresentation = true
        
        title = Constants.MediaContentScreen.pageTitle
        navigationController?.navigationBar.tintColor = .oppositeSystemBackgroundColor
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: Constants.Common.backButtonTitle, style: .plain, target: self, action: #selector(backButtonTapped))
        
        view.addSubview(openClipButton)
        openClipButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        openClipButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
    }
    
    @objc private func backButtonTapped() {
        coodinatorDelegate?.dismissCoordinator()
    }
}

