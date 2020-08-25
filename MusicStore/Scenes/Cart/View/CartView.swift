//
//  CartView.swift
//  MusicStore
//
//  Created by Rashmikant Makwana on 26/08/20.
//  Copyright © 2020 Rashmikant Makwana. All rights reserved.
//

import Foundation

protocol CartView: class {
    func reloadTable()
    func displayNoResultsView(status: Bool)
}
