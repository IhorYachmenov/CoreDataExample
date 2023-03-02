//
//  MediaModel.swift
//  Data Model Layer
//
//  Created by user on 02.03.2023.
//

import Foundation

public enum MediaModel {
    public struct AudioData {
        public let currentTime: String
        public let duration: String
        public var isPlaying: Bool
        public var progress: Float
    }
}
