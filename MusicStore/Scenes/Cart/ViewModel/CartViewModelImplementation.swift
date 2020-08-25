//
//  CartViewModelImplementation.swift
//  MusicStore
//
//  Created by Rashmikant Makwana on 26/08/20.
//  Copyright © 2020 Rashmikant Makwana. All rights reserved.
//

import Foundation

class CartViewModelImplementation: CartViewModel {

    private weak var view: CartView?
    private let records: [Record]!
    
    init(view: CartView, records: [Record]) {
        self.view = view
        self.records = records
    }
    
    var numberOfRows: Int {
        records.count
    }
    
    func viewDidLoad() {
        view?.reloadTable()
        view?.displayNoResultsView(status: records.isEmpty)
    }
    
    func configure(cell: RecordsCellView, for indexPath: IndexPath) {
        let record = records[indexPath.row]
        cell.configure(with: record)
        cell.hideSelection()
    }
    
}
