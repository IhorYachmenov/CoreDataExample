//
//  MediaModel.swift
//  Data Model Layer
//
//  Created by user on 02.03.2023.
//

import Foundation

public extension DTO {
    struct AudioData {
        public let currentTime: String
        public let duration: String
        public var isPlaying: Bool
        public var progress: Float
        
        public init(
            currentTime: String,
            duration: String,
            isPlaying: Bool,
            progress: Float
        ) {
            self.currentTime = currentTime
            self.duration = duration
            self.isPlaying = isPlaying
            self.progress = progress
        }
    }
}
