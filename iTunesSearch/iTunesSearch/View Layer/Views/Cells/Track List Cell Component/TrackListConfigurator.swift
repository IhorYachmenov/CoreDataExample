//
//  TrackListConfigurator.swift
//  iTunesSearch
//
//  Created by user on 24.01.2023.
//

import UIKit

//protocol TrackListConfiguratorProtocol: AnyObject {
//    func userPressButton(state: ButtonState, index: Int)
//}

struct TrackListConfigurator : UIContentConfiguration {
    
    var trackName: String = "Track Name"
    var singerName: String = "Singer Name"
    var trackPrice: String = "9.99"
    var country: String = "USA"
    
//    weak var delegate: TrackListConfiguratorProtocol?
    
    func makeContentView() -> UIView & UIContentView {
        return TrackListContentView(configuration:self)
    }
    func updated(for state: UIConfigurationState) -> TrackListConfigurator {
        return self
    }
}

