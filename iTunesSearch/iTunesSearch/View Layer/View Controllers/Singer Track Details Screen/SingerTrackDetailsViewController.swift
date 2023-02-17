//
//  TrackDetailsViewController.swift
//  iTunesSearch
//
//  Created by user on 06.02.2023.
//

import UIKit
import AVFoundation

protocol SingerTrackDetailsDelegate: AnyObject {
    func dismissCoordinator()
}

class SingerTrackDetailsViewController: UIViewController {
    /// Navigation
    weak var coodinatorDelegate: SingerTrackDetailsDelegate?
    
    /// Properties
    var viewModel: SingerTrackDetailsViewModelInterface!
    
    /// UI Properties
    private var musicPaused = false
    private let leadingAndTrailingConstant: CGFloat = 110
    private lazy var trackImg: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(systemName: Constants.SingerTrackDetailsScreen.defaultTrackImgName)
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.oppositeSystemBackgroundColor.cgColor
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var trackName: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .oppositeSystemBackgroundColor
        view.textAlignment = .left
        view.font = .boldSystemFont(ofSize: 20)
        view.text = "Rommance"
        view.numberOfLines = 1
        return view
    }()
    
    private lazy var singerName: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .red
        view.textAlignment = .left
        view.font = .boldSystemFont(ofSize: 15)
        view.text = "Lady Gaga"
        view.numberOfLines = 1
        return view
    }()
    
    private lazy var collectionName: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .oppositeSystemBackgroundColor
        view.textAlignment = .left
        view.numberOfLines = 3
        view.font.withSize(10)
        return view
    }()
    
    private lazy var collectionPrice: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .oppositeSystemBackgroundColor
        view.textAlignment = .left
        //        view.font = .boldSystemFont(ofSize: 10)
        view.font.withSize(10)
        return view
    }()
    
    private lazy var trackPrice: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .oppositeSystemBackgroundColor
        view.textAlignment = .left
        view.font.withSize(10)
        return view
    }()
    
    private lazy var releaseDate: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .oppositeSystemBackgroundColor
        view.textAlignment = .left
        view.font.withSize(10)
        return view
    }()
    
    private lazy var genre: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .oppositeSystemBackgroundColor
        view.textAlignment = .left
        view.font.withSize(10)
        return view
    }()
    
    private lazy var country: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .oppositeSystemBackgroundColor
        view.textAlignment = .left
        view.font.withSize(10)
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fillProportionally
        view.spacing = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var progressView: UIProgressView = {
        let view = UIProgressView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.progressTintColor = .red
        view.layer.cornerRadius = 3
        return view
    }()
    
    private lazy var trackCurrentTime: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .oppositeSystemBackgroundColor
        view.textAlignment = .left
        view.font.withSize(5)
        view.text = "0:00"
        return view
    }()
    
    private lazy var trackDuration: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .oppositeSystemBackgroundColor
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
            self?.viewModel.playTrack()
        }), for: .touchUpInside)
        
        return view
    }()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUIComponents()
        
        viewModel.dataSource = { [weak self] result in
            switch result {
            case .success(let success):
                let details = success.details
                let track = success.track
                
                self?.trackName.text = details?.trackName
                self?.singerName.text = details?.singerName
                self?.collectionName.appentText(defaultText: Constants.SingerTrackDetailsScreen.collectionName, text: details?.collectionName)
                self?.collectionPrice.attributedText(defaultText: Constants.SingerTrackDetailsScreen.collectionPrice, text: details?.collectionPrice)
                self?.trackPrice.attributedText(defaultText: Constants.SingerTrackDetailsScreen.trackPrice, text: details?.trackPrice)
                self?.releaseDate.appentText(defaultText: Constants.SingerTrackDetailsScreen.releaseDate, text: details?.releaseDate)
                self?.genre.appentText(defaultText: Constants.SingerTrackDetailsScreen.genre, text: details?.genre)
                self?.country.appentText(defaultText: Constants.SingerTrackDetailsScreen.country, text: details?.country)
                
                self?.trackImg.image = details?.image?.image
                
                self?.trackCurrentTime.text = track?.currentTime ?? "00:00"
                self?.trackDuration.text = track?.duration ?? "00:00"
                self?.animateImage(isPlaying: track?.isPlaying)
                self?.animateProgressView(progress: track?.progress)
            case .failure(let failure):
                self?.presentAlertController(msg: failure.localizedDescription, title: Constants.Alert.title)
            }
        }
    }
    
    deinit {
        coodinatorDelegate?.dismissCoordinator()
    }
    
    func initUIComponents() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(trackImg)
        view.addSubview(trackName)
        view.addSubview(singerName)
        view.addSubview(stackView)
        view.addSubview(progressView)
        view.addSubview(trackCurrentTime)
        view.addSubview(trackDuration)
        view.addSubview(playDemoButton)
        
        trackImg.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        trackImg.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingAndTrailingConstant).isActive = true
        trackImg.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -leadingAndTrailingConstant).isActive = true
        trackImg.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - (leadingAndTrailingConstant * 2)).isActive = true
        
        trackName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: UIScreen.main.bounds.width - (75 * 2) + 60).isActive = true
        trackName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        trackName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        trackName.setContentHuggingPriority(UILayoutPriority(rawValue: 745), for: .vertical)
        
        singerName.topAnchor.constraint(equalTo: trackName.bottomAnchor, constant: 5).isActive = true
        singerName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        singerName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        singerName.setContentHuggingPriority(UILayoutPriority(rawValue: 746), for: .vertical)
        
        stackView.topAnchor.constraint(equalTo: singerName.bottomAnchor, constant: 30).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        stackView.setContentHuggingPriority(UILayoutPriority(rawValue: 751), for: .vertical)
        
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
        progressView.topAnchor.constraint(greaterThanOrEqualTo: stackView.bottomAnchor, constant: 20).isActive = true
        
        trackCurrentTime.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 5).isActive = true
        trackCurrentTime.leadingAnchor.constraint(equalTo: progressView.leadingAnchor, constant: 0).isActive = true
        
        trackDuration.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 5).isActive = true
        trackDuration.trailingAnchor.constraint(equalTo: progressView.trailingAnchor, constant: 0).isActive = true
        
        playDemoButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true
        playDemoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
    }
    
    private func animateProgressView(progress: Float?) {
        guard let progress = progress else { return }
        progressView.setProgress(progress, animated: true)
        
    }
    
    private func animateImage(isPlaying: Bool?) {
        guard let isPlaying = isPlaying else { return }
        UIView.animate(withDuration: 0.3, delay: 0) {
            self.trackImg.transform = (isPlaying == false) ? .identity : CGAffineTransform(scaleX: 1.5, y: 1.5)
        }
        
        playDemoButton.playerButtonState(isPlaying: isPlaying)
        playDemoButton.configuration?.showsActivityIndicator = false
    }
}
