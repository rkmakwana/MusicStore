//
//  RecordsListUseCase.swift
//  MusicStore
//
//  Created by Rashmikant Makwana on 24/08/20.
//  Copyright © 2020 Rashmikant Makwana. All rights reserved.
//

import Foundation

typealias FetchRecordsCompletionHandler = (_ response: [Record]?, _ error: Error?) -> Void

protocol RecordsListUseCase {
    func getRecords(completion: @escaping FetchRecordsCompletionHandler)
}
