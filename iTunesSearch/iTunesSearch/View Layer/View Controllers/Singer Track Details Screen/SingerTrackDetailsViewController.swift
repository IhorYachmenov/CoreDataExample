//
//  TrackDetailsViewController.swift
//  iTunesSearch
//
//  Created by user on 06.02.2023.
//

import UIKit

class SingerTrackDetailsViewController: UIViewController {
    /// Navigation
    var coordinator: SingerTrackDetailsCoordinator!
    
    /// UI Properties
    private let leadingAndTrailingConstant: CGFloat = 75
    private lazy var trackImg: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(systemName: Constants.SingerTrackDetailsScreen.defaultTrackImgName)
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.black.cgColor
        return view
    }()
    
    private lazy var trackName: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .black
        view.textAlignment = .left
        view.font = .boldSystemFont(ofSize: 20)
        view.text = "Rommance"
        return view
    }()
    
    private lazy var singerName: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .black
        view.textAlignment = .left
        view.font.withSize(20)
        view.text = "Lady Gaga"
        return view
    }()
    
    private lazy var collectionName: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .black
        view.textAlignment = .left
        view.font.withSize(10)
        view.text = "Collection name:"
        return view
    }()
    
    private lazy var collectionPrice: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .red
        view.textAlignment = .left
        view.font = .boldSystemFont(ofSize: 10)
        view.text = "Collection Price:"
        return view
    }()
    
    private lazy var trackPrice: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .red
        view.textAlignment = .left
        view.font = .boldSystemFont(ofSize: 10)
        view.text = "Track Price:"
        return view
    }()
    
    private lazy var releaseDate: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .black
        view.textAlignment = .left
        view.font.withSize(10)
        view.text = "Release Date:"
        return view
    }()
    
    private lazy var genre: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .black
        view.textAlignment = .left
        view.font.withSize(10)
        view.text = "Genre:"
        return view
    }()
    
    private lazy var country: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .black
        view.textAlignment = .left
        view.font.withSize(10)
        view.text = "Country:"
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var playDemoButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        var configuration = UIButton.Configuration.filled()
        configuration.title = Constants.SingerTrackDetailsScreen.playButtonTitle
        configuration.image = UIImage(systemName: Constants.SingerTrackDetailsScreen.playButtonDefaultImgName)
        configuration.imagePlacement = .leading
        configuration.imagePadding = 15
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
            print("Play")
        }), for: .touchUpInside)
        
        return view
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUIComponents()
    }
    
    func initUIComponents() {
        view.backgroundColor = .white
        
        view.addSubview(trackImg)
        view.addSubview(trackName)
        view.addSubview(singerName)
        view.addSubview(stackView)
        view.addSubview(playDemoButton)
        
        
        trackImg.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        trackImg.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingAndTrailingConstant).isActive = true
        trackImg.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -leadingAndTrailingConstant).isActive = true
        trackImg.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - (leadingAndTrailingConstant * 2)).isActive = true
        
        trackName.topAnchor.constraint(equalTo: trackImg.bottomAnchor, constant: 40).isActive = true
        trackName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        trackName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        
        singerName.topAnchor.constraint(equalTo: trackName.bottomAnchor, constant: 5).isActive = true
        singerName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        singerName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        
        stackView.topAnchor.constraint(equalTo: singerName.bottomAnchor, constant: 20).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        
        stackView.addArrangedSubview(collectionName)
        stackView.addArrangedSubview(collectionPrice)
        stackView.addArrangedSubview(trackPrice)
        stackView.addArrangedSubview(releaseDate)
        stackView.addArrangedSubview(genre)
        stackView.addArrangedSubview(country)
        
        playDemoButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true
        playDemoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
    }
}
