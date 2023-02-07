//
//  TrackLiskContentView.swift
//  iTunesSearch
//
//  Created by user on 24.01.2023.
//

import UIKit

class SingerTrackListContentView: UIView, UIContentView {
    var configuration: UIContentConfiguration {
        didSet {
            initViewsData(configurator: configuration as! SingerTrackListConfigurator)
        }
    }
        
    lazy var trackName: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 1
        view.textColor = .red
        view.textAlignment = .left
        view.font.withSize(20)
        return view
    }()
    
    lazy var singerName: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 1
        view.textColor = .purple
        view.textAlignment = .left
        view.font = .boldSystemFont(ofSize: 20)
        return view
    }()
    
    lazy var country: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 1
        view.textColor = .black
        view.textAlignment = .right
        view.font.withSize(20)
        return view
    }()
    
    lazy var trackPrice: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 1
        view.textColor = .blue
        view.textAlignment = .right
        view.font = .boldSystemFont(ofSize: 20)
        return view
    }()

    init(configuration: UIContentConfiguration) {
        self.configuration = configuration
        super.init(frame:.zero)
        backgroundColor = .clear

        addSubview(singerName)
        addSubview(trackName)
        addSubview(country)
        addSubview(trackPrice)
        
        singerName.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        singerName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        
        trackName.topAnchor.constraint(equalTo: singerName.bottomAnchor, constant: 5).isActive = true
        trackName.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        trackName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        trackName.setContentHuggingPriority(UILayoutPriority(rawValue: 749), for: .vertical)
        
        country.centerYAnchor.constraint(equalTo: singerName.centerYAnchor).isActive = true
        country.leadingAnchor.constraint(equalTo: singerName.trailingAnchor, constant: 20).isActive = true
        country.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        country.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 751), for: .horizontal)
        country.setContentHuggingPriority(UILayoutPriority(rawValue: 751), for: .horizontal)
        
        trackPrice.centerYAnchor.constraint(equalTo: trackName.centerYAnchor).isActive = true
        trackPrice.leadingAnchor.constraint(equalTo: trackName.trailingAnchor, constant: 20).isActive = true
        trackPrice.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -10).isActive = true
        trackPrice.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        trackPrice.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 751), for: .horizontal)
        trackPrice.setContentHuggingPriority(UILayoutPriority(rawValue: 751), for: .horizontal)
        

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initViewsData(configurator: SingerTrackListConfigurator) {
        self.singerName.text = configurator.model.singerName
        self.trackName.text = configurator.model.trackName
        self.country.text = configurator.model.country
        self.trackPrice.text = configurator.model.trackPrice
    }
}

