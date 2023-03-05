//
//  TrackListConfigurator.swift
//  iTunesSearch
//
//  Created by user on 24.01.2023.
//

import UIKit
import Presentation_Layer
import Data_Model_Layer

//protocol TrackListConfiguratorProtocol: AnyObject {
//    func userPressButton(state: ButtonState, index: Int)
//}

struct SingerTrackListConfigurator : UIContentConfiguration {
    var model: PresentationModel.SingerTrack
    
//    weak var delegate: TrackListConfiguratorProtocol?
    
    func makeContentView() -> UIView & UIContentView {
        return SingerTrackListContentView(configuration:self)
    }
    
    func updated(for state: UIConfigurationState) -> SingerTrackListConfigurator {
        return self
    }
}

