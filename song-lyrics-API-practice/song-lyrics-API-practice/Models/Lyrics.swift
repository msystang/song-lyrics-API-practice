//
//  Lyrics.swift
//  song-lyrics-API-practice
//
//  Created by Sunni Tang on 9/9/19.
//  Copyright © 2019 Sunni Tang. All rights reserved.
//

import Foundation

struct LyricsOuterWrapper: Codable {
    let message: LyricsWrapper
}

struct LyricsWrapper: Codable {
    let body: Lyrics
}

struct Lyrics: Codable {
    let lyrics: String
    
    private enum CodingKeys: String, CodingKey {
        case lyrics = "lyrics_body"
    }
}


