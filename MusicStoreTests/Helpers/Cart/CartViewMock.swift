//
//  CartViewMock.swift
//  MusicStoreTests
//
//  Created by Rashmikant Makwana on 26/08/20.
//  Copyright © 2020 Rashmikant Makwana. All rights reserved.
//

import Foundation

@testable import MusicStore

class CartViewMock: CartView {
    
    var displayingNoResultsView = false
    var tableReloaded = false
    
    func displayNoResultsView(status: Bool) {
        displayingNoResultsView = status
    }
    
    func reloadTable() {
        tableReloaded = true
    }
}
