//
//  RecordsListUseCaseImplementation.swift
//  MusicStore
//
//  Created by Rashmikant Makwana on 24/08/20.
//  Copyright © 2020 Rashmikant Makwana. All rights reserved.
//

import Foundation

class RecordsListUseCaseImplementation: RecordsListUseCase {
    
    func getRecords(completion: @escaping FetchRecordsCompletionHandler) {
        FetchRecordsRequest().dispatch(onSuccess: { (response) in
            completion(response.results, nil)
        }) { error in
            completion(nil, error)
        }
    }
    
}
