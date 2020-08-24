//
//  RecordsListViewModelImplementation.swift
//  MusicStore
//
//  Created by Rashmikant Makwana on 24/08/20.
//  Copyright © 2020 Rashmikant Makwana. All rights reserved.
//

import Foundation

class RecordsListViewModelImplementation: RecordsListViewModel {
    
    private weak var view: RecordsListView?
    private let useCase: RecordsListUseCase!
    
    var records = [Record]()
    
    init(view: RecordsListView, useCase: RecordsListUseCase) {
        self.view = view
        self.useCase = useCase
    }
    
    var numberOfRows: Int {
        records.count
    }
    
    func viewDidLoad() {
        view?.showLoader()
        fetchRecords()
    }
    
    func fetchList() {
        fetchRecords()
    }
    
    func configure(cell: RecordsCellView, for indexPath: IndexPath) {
        let feed = records[indexPath.row]
        cell.configure(with: feed)
    }
    
    func select(cell: RecordsCellView, for indexPath: IndexPath) {
        var feed = records[indexPath.row]
        feed.selected = !feed.isSelected
        records.remove(at: indexPath.row)
        records.insert(feed, at: indexPath.row)
        
        cell.selectionChanged(isSelected: feed.isSelected)
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
        if let records = records {
            self.records = records
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
    
}

