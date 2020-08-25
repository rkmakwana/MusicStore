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
    var sortOption: String { get }
    func viewDidLoad()
    func fetchList()
    func select(cell: RecordsCellView, for indexPath: IndexPath)
    func configure(cell: RecordsCellView, for indexPath: IndexPath)
    func setSearch(active: Bool)
    func search(for key: String)
    
    var totalSortOptions: Int { get }
    func sortOption(at index: Int) -> String
    func changeSortOption(index: Int)
    
    var cartItemsCount: Int { get }
    func cartAction()
}
