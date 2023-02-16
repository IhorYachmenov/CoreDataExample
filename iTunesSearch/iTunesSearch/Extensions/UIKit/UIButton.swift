//
//  UIButton.swift
//  iTunesSearch
//
//  Created by user on 16.02.2023.
//

import UIKit

extension UIButton {
    func playerButtonState(isPlaying: Bool) {
        if (isPlaying) {
            self.configuration?.title = Constants.SingerTrackDetailsScreen.pauseButtonTitle
            self.configuration?.image = UIImage(systemName: Constants.SingerTrackDetailsScreen.playButtonPauseImgName)
        } else {
            self.configuration?.image = UIImage(systemName: Constants.SingerTrackDetailsScreen.playButtonDefaultImgName)
            self.configuration?.title = Constants.SingerTrackDetailsScreen.playButtonTitle
        }
    }
}
