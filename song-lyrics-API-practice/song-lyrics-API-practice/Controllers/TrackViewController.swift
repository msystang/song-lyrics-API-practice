//
//  ViewController.swift
//  song-lyrics-API-practice
//
//  Created by Sunni Tang on 9/9/19.
//  Copyright © 2019 Sunni Tang. All rights reserved.
//

import UIKit

class TrackViewController: UIViewController {
    
    @IBOutlet weak var tracksTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var tracks = [Track]() {
        didSet {
            tracksTableView.reloadData()
        }
    }
    
    var searchString: String? = nil {
        didSet {
            tracksTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureSearchBar()
    }
    
    private func configureTableView() {
        tracksTableView.delegate = self
        tracksTableView.dataSource = self
    }
    
    private func configureSearchBar() {
        searchBar.delegate = self
    }
    
    private func loadSearchData() {
        if let searchString = searchString {
            let trackURL = "http://api.musixmatch.com/ws/1.1/track.search?q_track_artist=\(searchString)&apikey=795786026b2e330c30c0de2bfa9c9b83"
            TrackAPIClient.shared.getTracks(from: trackURL) { (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .failure(let error):
                        print(error)
                    case .success(let data):
                        self.tracks = data
                    }
                }
            }
        }
    }
}

extension TrackViewController: UITableViewDelegate {}

extension TrackViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let track = tracks[indexPath.row]
        let trackCell = tracksTableView.dequeueReusableCell(withIdentifier: "trackCell", for: indexPath)
        
        trackCell.textLabel?.text = track.trackName
        trackCell.detailTextLabel?.text = track.artistName
        
        return trackCell
    }
}

extension TrackViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchString = searchText
        loadSearchData()
    }
}
