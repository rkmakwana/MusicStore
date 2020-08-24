//
//  RecordsListViewModel.swift
//  MusicStore
//
//  Created by Rashmikant Makwana on 24/08/20.
//  Copyright © 2020 Rashmikant Makwana. All rights reserved.
//

import Foundation

protocol RecordsListViewModel {
    var numberOfRows: Int { get }
    func viewDidLoad()
    func fetchList()
    func configure(cell: RecordsCellView, for indexPath: IndexPath)
}
