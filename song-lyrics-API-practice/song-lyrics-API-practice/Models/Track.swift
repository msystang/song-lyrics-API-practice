//
//  Song.swift
//  song-lyrics-API-practice
//
//  Created by Sunni Tang on 9/9/19.
//  Copyright © 2019 Sunni Tang. All rights reserved.
//

import Foundation

struct TrackListWrapper: Codable {
    let trackList: TrackList
    
    private enum CodingKeys: String, CodingKey {
        case trackList = "body"
    }
}

struct TrackList: Codable {
    let track: [Track]
}

struct Track: Codable {
    let trackID: Int
    let trackName: String
    
    private enum CodingKets: String, CodingKey {
        case trackID = "track_id"
        case trackName = "track_name"
    }
}
