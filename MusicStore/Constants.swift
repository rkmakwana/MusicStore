//
//  Constants.swift
//  MusicStore
//
//  Created by Rashmikant Makwana on 25/08/20.
//  Copyright © 2020 Rashmikant Makwana. All rights reserved.
//

import Foundation

struct AppConstants {
    static let title = "My Music"
    static let defaultDateFormat = "MMM dd, yyyy"
}

struct Endpoints {
    static let fetchRecordsEndpoint = "https://itunes.apple.com/search?term=all"
}

struct ImageNames {
    static let selectedCheckMark = "selected"
    static let unselectedCheckMark = "unselected"
    static let noRecords = "noResults"
}
