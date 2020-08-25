//
//  RecordsListUseCaseMock.swift
//  MusicStoreTests
//
//  Created by Rashmikant Makwana on 26/08/20.
//  Copyright © 2020 Rashmikant Makwana. All rights reserved.
//

import Foundation
@testable import MusicStore

class RecordsListUseCaseMock: RecordsListUseCase {
    
    var resultsToReturn: [Record]? = nil
    var errorToReturn: Error? = nil
    
    func getRecords(completion: @escaping FetchRecordsCompletionHandler) {
        completion(resultsToReturn, errorToReturn)
    }
    
}
