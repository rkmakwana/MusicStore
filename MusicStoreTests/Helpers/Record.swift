//
//  Record.swift
//  MusicStoreTests
//
//  Created by Rashmikant Makwana on 26/08/20.
//  Copyright © 2020 Rashmikant Makwana. All rights reserved.
//

import Foundation
@testable import MusicStore

extension Record {
    
    static func createRecordsList(numberOfItems: Int) -> [Record] {
        var records = [Record]()
        for i in 0..<numberOfItems {
            do {
                try records.append(createRecord(id: i))
            } catch let e {
                print(e)
            }
        }
        return records
    }
    
    static func createRecord(id: Int) throws -> Record {
        let date = randomDate(range: 365*12)
        let jsonRecords = [
            "trackId": id*1000,
            "artistName": "Artist name \(id)",
            "collectionName": "Collection name - \(id)",
            "trackName": "Track name - \(id)",
            "artworkUrl100": "http://some.url.path/\(id)",
            "collectionPrice": Float.random(in: 1.0..<20.0),
            "releaseDate": date
            ] as [String : Any]
        let data = try JSONSerialization.data(withJSONObject: jsonRecords, options: .prettyPrinted)
        
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = AppConstants.globalDateFormat
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        let records = try decoder.decode(Record.self, from: data)
        return records
    }

    // Generate a random date in the range of days upto current date
    static func randomDate(range: Int) -> String {
        let interval =  Date().timeIntervalSince1970
        // There are 86,400 milliseconds in a day (ignoring leap dates)
        // Multiply the 86,400 milliseconds against the valid range of days
        let intervalRange = Double(86_400 * range)
        // Select a random point within the interval range
        let random = Double(arc4random_uniform(UInt32(intervalRange)) + 1)
        // Since this can either be in the past or future, we shift the range
        // so that the halfway point is the present
        let newInterval = interval + (random - (intervalRange / 2.0))
        // Initialize a date value with our newly created interval
        let date = Date(timeIntervalSince1970: newInterval)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = AppConstants.globalDateFormat
        
        return dateFormatter.string(from: date)
    }
}
