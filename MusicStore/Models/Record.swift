//
//  Record.swift
//  MusicStore
//
//  Created by Rashmikant Makwana on 24/08/20.
//  Copyright © 2020 Rashmikant Makwana. All rights reserved.
//

import Foundation

class Record: Codable, Hashable {
    
    let trackId: Int
    let artistName: String
    let collectionName: String?
    let trackName: String
    var artworkUrl100: URL?
    let collectionPrice: Double
    let releaseDate: Date
    
    // For managing selection
    var selected: Bool?
    public var isSelected: Bool {
        if let status = selected {
            return status
        } else {
            return false
        }
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(trackId)
    }
    
    // Assuming tracks with same name as duplicates
    static func == (lhs: Record, rhs: Record) -> Bool {
        return (lhs.trackName == rhs.trackName)
    }
    
}
