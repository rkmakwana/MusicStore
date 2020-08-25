//
//  RecordsListViewModelImplementation.swift
//  MusicStore
//
//  Created by Rashmikant Makwana on 24/08/20.
//  Copyright © 2020 Rashmikant Makwana. All rights reserved.
//

import Foundation

class RecordsListViewModelImplementation: RecordsListViewModel {
    
    enum SortOption: Int, CustomStringConvertible, CaseIterable {
        case date       // 0
        case artist     // 1
        case track      // 2
        case price      // 3
        case collection // 4
        
        var description: String {
            get {
                switch self {
                case .date:
                    return "Release Date"
                case .artist:
                    return "Artist Name"
                case .track:
                    return "Track Name"
                case .price:
                    return "Price"
                case .collection:
                    return "Collection Name"
                }
            }
        }
    }
    
    private weak var view: RecordsListView?
    private let useCase: RecordsListUseCase!
    private var searchActive = false
    private var sortBy: SortOption = .date
    
    var records = [Record]()
    var filtered = [Record]()
    
    init(view: RecordsListView, useCase: RecordsListUseCase) {
        self.view = view
        self.useCase = useCase
    }
    
    private var dataSource: [Record] {
        if searchActive {
            return filtered
        } else {
            return records
        }
    }
    
    var numberOfRows: Int {
        dataSource.count
    }
    
    var sortOption: String {
        self.sortBy.description
    }
    
    var totalSortOptions: Int {
        SortOption.allCases.count
    }
    
    var cartItemsCount: Int {
        records.filter({ ($0.isSelected ) }).count
    }
    
    func viewDidLoad() {
        view?.showLoader()
        fetchRecords()
        view?.updateSortOption()
    }
    
    func fetchList() {
        fetchRecords()
    }
    
    func configure(cell: RecordsCellView, for indexPath: IndexPath) {
        let record = dataSource[indexPath.row]
        cell.configure(with: record)
    }
    
    func select(cell: RecordsCellView, for indexPath: IndexPath) {
        let feed = dataSource[indexPath.row]
        feed.selected = !feed.isSelected
        view?.updateCart()
    }
    
    func setSearch(active: Bool) {
        self.searchActive = active
    }
    
    func search(for key: String) {
        let key = key.lowercased()
        filtered = records.filter({
            if let collectionName = $0.collectionName {
                return ($0.artistName.lowercased().contains(key) ||
                    collectionName.lowercased().contains(key) ||
                    $0.trackName.lowercased().contains(key))
            }
            return false
        })
        view?.reloadTable()
    }
    
    func changeSortOption(index: Int) {
        sortBy = SortOption(rawValue: index)!
        records = sortRecords(records: records, orderBy: sortBy)
        view?.reloadTable()
        view?.updateSortOption()
    }
    
    func sortOption(at index: Int) -> String {
        return SortOption.allCases[index].description
    }
    
    func cartAction() {
        let selected = records.filter({ $0.isSelected })
        let viewController = CartViewController()
        let cartViewModel = CartViewModelImplementation(view: viewController,
                                                        records: selected)
        viewController.viewModel = cartViewModel
        view?.navigateToCart(viewController: viewController)
    }

}

// MARK:- Private
extension RecordsListViewModelImplementation {
    
    private func fetchRecords() {
        useCase.getRecords { [weak self] (results, err) in
            if let error = err {
                self?.handleError(error: error)
            } else {
                self?.handleSuccess(records: results)
            }
        }
    }
    
    private func handleSuccess(records: [Record]?) {
        if var records = records {
            // Remove duplicates by Track Name
            records = Array(Set(records))
            self.records = sortRecords(records: records, orderBy: sortBy)
        }
        view?.hideLoader()
        self.view?.reloadTable()
        self.view?.displayNoResultsView(status: self.records.isEmpty)
    }
    
    private func handleError(error: Error) {
        view?.hideLoader()
        self.view?.displayNoResultsView(status: true)
        self.view?.showAlert(title: "Error", message: error.localizedDescription)
    }
    
    private func sortRecords(records: [Record], orderBy: SortOption) -> [Record] {
        let sorted = records.sorted { (idx1, idx2) -> Bool in
            switch orderBy {
            case .artist:
                return idx1.artistName < idx2.artistName
            case .collection:
                return (idx1.collectionName ?? "") < (idx2.collectionName ?? "")
            case .date:
                return idx1.releaseDate < idx2.releaseDate
            case .price:
                // Price sort order is defined as descending
                return idx1.collectionPrice > idx2.collectionPrice
            case .track:
                return idx1.trackName < idx2.trackName
            }
        }
        return sorted
    }
    
}

