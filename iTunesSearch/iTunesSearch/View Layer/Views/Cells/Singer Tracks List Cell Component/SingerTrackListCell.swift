//
//  TrackListCell.swift
//  iTunesSearch
//
//  Created by user on 24.01.2023.
//

import UIKit

class SingerTrackListCell: UITableViewCell {
    static let identifier = "TrackListCell"
    
    override func updateConfiguration(using state: UICellConfigurationState) {
        super.updateConfiguration(using: state)
    
        var backgroundConfig = backgroundConfiguration?.updated(for: state)
        backgroundConfig?.backgroundColor = .white
        
//        if state.isHighlighted || state.isSelected {
//            backgroundConfig?.backgroundColor = .lightGray
//        }
        
        backgroundConfiguration = backgroundConfig
    }
}
