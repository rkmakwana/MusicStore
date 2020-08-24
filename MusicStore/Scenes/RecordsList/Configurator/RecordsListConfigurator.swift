//
//  RecordsListConfigurator.swift
//  MusicStore
//
//  Created by Rashmikant Makwana on 24/08/20.
//  Copyright © 2020 Rashmikant Makwana. All rights reserved.
//

import Foundation

class RecordsListConfigurator {
    
    init(viewController: RecordsListViewController) {
        let useCase = RecordsListUseCaseImplementation()
        let viewModel = RecordsListViewModelImplementation(view: viewController,
                                                           useCase: useCase)
        viewController.viewModel = viewModel
    }
}
