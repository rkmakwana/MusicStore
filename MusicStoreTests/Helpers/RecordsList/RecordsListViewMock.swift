//
//  RecordsListViewMock.swift
//  MusicStoreTests
//
//  Created by Rashmikant Makwana on 26/08/20.
//  Copyright © 2020 Rashmikant Makwana. All rights reserved.
//

import Foundation
@testable import MusicStore

class RecordsListViewMock: RecordsListView {
    
    var tableReloaded = false
    var errorMessageDisplayed: String = ""
    var loaderVisible = false
    var noResultsViewVisible = false
    var sortOptionUpdated = false
    var cartCountUpdated = false
    
    func reloadTable() {
        tableReloaded = true
    }
    
    func showAlert(title: String, message: String) {
        errorMessageDisplayed = message
    }
    
    func showLoader() {
        loaderVisible = true
    }
    
    func hideLoader() {
        loaderVisible = false
    }
    
    func displayNoResultsView(status: Bool) {
        noResultsViewVisible = status
    }
    
    func updateSortOption() {
        sortOptionUpdated = true
    }
    
    func updateCart() {
        cartCountUpdated = true
    }
    
    func navigateToCart(viewController: CartView) {
        
    }
}
