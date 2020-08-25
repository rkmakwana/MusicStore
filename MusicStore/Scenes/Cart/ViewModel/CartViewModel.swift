//
//  CartViewModel.swift
//  MusicStore
//
//  Created by Rashmikant Makwana on 26/08/20.
//  Copyright © 2020 Rashmikant Makwana. All rights reserved.
//

import Foundation

protocol CartViewModel {
    var numberOfRows: Int { get }
    func viewDidLoad()
    func configure(cell: RecordsCellView, for indexPath: IndexPath)
}
