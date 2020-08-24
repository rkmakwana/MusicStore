//
//  Record.swift
//  MusicStore
//
//  Created by Rashmikant Makwana on 24/08/20.
//  Copyright © 2020 Rashmikant Makwana. All rights reserved.
//

import Foundation

struct Record: Codable {
    let trackId: Int
    let artistName: String
    let collectionName: String?
    let trackName: String
    var artworkUrl100: URL?
    let collectionPrice: Double
    let releaseDate: Date
}
