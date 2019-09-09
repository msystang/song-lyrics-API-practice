//
//  TrackAPIClient.swift
//  song-lyrics-API-practice
//
//  Created by Sunni Tang on 9/9/19.
//  Copyright © 2019 Sunni Tang. All rights reserved.
//

import Foundation

class TrackAPIClient {
    private init() {}
    
    static let shared = TrackAPIClient()
    
    func getTracks(from urlStr: String, completionHandler: @escaping (Result<[Track], AppError>) -> ()) {
        
        NetworkManager.shared.getData(from: urlStr) { (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
                return
            case .success(let data):
                do {
                    let trackInfo = try JSONDecoder().decode(TrackListWrapper.self, from: data)
                    completionHandler(.success(trackInfo.trackList.track))
                } catch {
                    completionHandler(.failure(.couldNotParseJSON(rawError: error)))
                }
            }
        }
    }
}

