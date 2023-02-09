//
//  TrackDetailsViewController.swift
//  iTunesSearch
//
//  Created by user on 06.02.2023.
//

import UIKit

protocol SingerTrackDetailsViewControllerDelegate: AnyObject {
}

class SingerTrackDetailsViewController: UIViewController {
    /// Navigation
    var navigationDelegate: SingerTrackDetailsViewControllerDelegate?
    
    /// Properties
    var trackId: Int?
    
    /// UI Properties
    private var musicPaused = false
    private let leadingAndTrailingConstant: CGFloat = 110
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
        view.text = Constants.SingerTrackDetailsScreen.collectionName
        return view
    }()
    
    private lazy var collectionPrice: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .black
        view.textAlignment = .left
//        view.font = .boldSystemFont(ofSize: 10)
        view.font.withSize(10)
        view.text = Constants.SingerTrackDetailsScreen.collectionPrice
        return view
    }()
    
    private lazy var trackPrice: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .black
        view.textAlignment = .left
//        view.font = .boldSystemFont(ofSize: 10)
        view.font.withSize(10)
        view.text = Constants.SingerTrackDetailsScreen.trackPrice
        return view
    }()
    
    private lazy var releaseDate: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .black
        view.textAlignment = .left
        view.font.withSize(10)
        view.text = Constants.SingerTrackDetailsScreen.releaseDate
        return view
    }()
    
    private lazy var genre: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .black
        view.textAlignment = .left
        view.font.withSize(10)
        view.text = Constants.SingerTrackDetailsScreen.genre
        return view
    }()
    
    private lazy var country: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .black
        view.textAlignment = .left
        view.font.withSize(10)
        view.text = Constants.SingerTrackDetailsScreen.country
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let progress = Progress(totalUnitCount: 100)
    
    private lazy var progressView: UIProgressView = {
        let view = UIProgressView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.progressTintColor = .red
        view.layer.cornerRadius = 3
        return view
    }()
    
    private lazy var currentTimeOfTrack: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .black
        view.textAlignment = .left
        view.font.withSize(5)
        view.text = "0:00"
        return view
    }()
    
    private lazy var endTimeOfTrack: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .black
        view.textAlignment = .right
        view.font.withSize(5)
        view.text = "3:00"
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
            self?.animateProgressView()
            self?.animateImage()
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
        view.addSubview(progressView)
        view.addSubview(currentTimeOfTrack)
        view.addSubview(endTimeOfTrack)
        view.addSubview(playDemoButton)
        
        
        trackImg.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        trackImg.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingAndTrailingConstant).isActive = true
        trackImg.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -leadingAndTrailingConstant).isActive = true
        trackImg.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - (leadingAndTrailingConstant * 2)).isActive = true
        
        trackName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: UIScreen.main.bounds.width - (75 * 2) + 60).isActive = true
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
        
        progressView.heightAnchor.constraint(equalToConstant: 6).isActive = true
        progressView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        progressView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        progressView.bottomAnchor.constraint(equalTo: playDemoButton.topAnchor, constant: -50).isActive = true

        currentTimeOfTrack.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 5).isActive = true
        currentTimeOfTrack.leadingAnchor.constraint(equalTo: progressView.leadingAnchor, constant: 0).isActive = true
        
        endTimeOfTrack.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 5).isActive = true
        endTimeOfTrack.trailingAnchor.constraint(equalTo: progressView.trailingAnchor, constant: 0).isActive = true
        
        playDemoButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true
        playDemoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func animateProgressView() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
            guard self?.progress.isFinished == false else {
                timer.invalidate()
                return
            }
            
            self?.progress.completedUnitCount += 1
            
            let progressFloat = Float(self?.progress.fractionCompleted ?? 0)
            self?.progressView.setProgress(progressFloat, animated: true)
        }
    }
    
    func animateImage() {
        musicPaused = !musicPaused
        UIView.animate(withDuration: 0.3, delay: 0) {
            self.trackImg.transform = (self.musicPaused == false) ? .identity : CGAffineTransform(scaleX: 1.5, y: 1.5)
        }
    }
}
