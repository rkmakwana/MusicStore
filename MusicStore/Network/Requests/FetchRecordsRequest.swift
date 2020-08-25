//
//  FetchRecordsRequest.swift
//  Factastic
//
//  Created by Rashmikant Makwana on 21/08/20.
//  Copyright © 2020 Rashmikant Makwana. All rights reserved.
//

import Foundation

struct FetchRecordsRequestResponse: Codable {
    let results: [Record]?
}

struct FetchRecordsRequest: APIEndpoint, Codable {
    
    func endpoint() -> String {
        return Endpoints.fetchRecordsEndpoint
    }
    
    func dispatch(
        onSuccess successHandler: @escaping ((_: FetchRecordsRequestResponse) -> Void),
        onFailure failureHandler: @escaping ((_: Error) -> Void)) {
        
        NetworkClient.get(
            request: self,
            onSuccess: successHandler,
            onError: failureHandler)
    }
}
