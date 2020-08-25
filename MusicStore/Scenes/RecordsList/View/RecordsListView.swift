//
//  RecordsListView.swift
//  MusicStore
//
//  Created by Rashmikant Makwana on 24/08/20.
//  Copyright © 2020 Rashmikant Makwana. All rights reserved.
//

import Foundation

protocol RecordsListView: class {
    func reloadTable()
    func showAlert(title: String, message: String)
    func showLoader()
    func hideLoader()
    func displayNoResultsView(status: Bool)
    func updateSortOption()
}
