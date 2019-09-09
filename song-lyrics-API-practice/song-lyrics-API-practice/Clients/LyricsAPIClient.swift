//
//  LyricsAPIClient.swift
//  song-lyrics-API-practice
//
//  Created by Sunni Tang on 9/9/19.
//  Copyright © 2019 Sunni Tang. All rights reserved.
//

import Foundation

class LyricsAPIClient {
    private init() {}
    
    static let shared = LyricsAPIClient()
    
    func getLyrics(from urlStr: String, completionHandler: @escaping (Result<Lyrics, AppError>) -> ()) {
        
        NetworkManager.shared.getData(from: urlStr) { (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
                return
            case .success(let data):
                do {
                    let lyricsInfo = try JSONDecoder().decode(LyricsOuterWrapper.self, from: data)
                    completionHandler(.success(lyricsInfo.message.body))
                } catch {
                    completionHandler(.failure(.couldNotParseJSON(rawError: error)))
                }
            }
        }
    }
}

