//
//  RecordsListTableCellMock.swift
//  MusicStoreTests
//
//  Created by Rashmikant Makwana on 26/08/20.
//  Copyright © 2020 Rashmikant Makwana. All rights reserved.
//

import Foundation
@testable import MusicStore

class RecordsListTableCellMock: RecordsCellView {

    var record: Record!
    var selectionDisabled = false
    
    func configure(with record: Record) {
        self.record = record
    }
    
    func hideSelection() {
        selectionDisabled = true
    }
}
