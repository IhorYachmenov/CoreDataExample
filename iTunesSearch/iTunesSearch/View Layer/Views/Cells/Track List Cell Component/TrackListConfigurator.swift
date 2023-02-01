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
    
    var model: PresentationModel.SingerTrack
    
//    weak var delegate: TrackListConfiguratorProtocol?
    
    func makeContentView() -> UIView & UIContentView {
        return TrackListContentView(configuration:self)
    }
    func updated(for state: UIConfigurationState) -> TrackListConfigurator {
        return self
    }
}

