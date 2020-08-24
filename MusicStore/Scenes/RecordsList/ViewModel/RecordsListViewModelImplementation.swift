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
    
    init(view: RecordsListView, useCase: RecordsListUseCase) {
        self.view = view
        self.useCase = useCase
    }
    
    func viewDidLoad() {
        print("viewDidLoad")
    }
    
}
