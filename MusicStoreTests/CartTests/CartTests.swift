//
//  CartTests.swift
//  MusicStoreTests
//
//  Created by Rashmikant Makwana on 26/08/20.
//  Copyright © 2020 Rashmikant Makwana. All rights reserved.
//

import XCTest
@testable import MusicStore

class CartTests: XCTestCase {

    let viewMock = CartViewMock()
    let tableCellMock = RecordsListTableCellMock()
    var viewModel: CartViewModelImplementation!
    
    // MARK: - Set up
    override func setUp() {
        super.setUp()
        
    }
    
    func test_empty_records_show_no_results_view() {
        // Given
        let records = [Record]()
        viewModel = CartViewModelImplementation(view: viewMock,
                                                records: records)
        
        // When
        viewModel.viewDidLoad()
        
        //Then
        XCTAssertTrue(viewMock.displayingNoResultsView, "Empty cart view not displayed when no items in cart")
        XCTAssertTrue(viewMock.tableReloaded, "Table not reloaded when view loaded")
    }
    
    func test_no_results_view_hidden_when_records_in_cart() {
        // Given
        let expectedRecordsCount = 2
        let recordsInCart = Record.createRecordsList(numberOfItems: expectedRecordsCount)
        viewModel = CartViewModelImplementation(view: viewMock,
                                                records: recordsInCart)
        
        // When
        viewModel.viewDidLoad()
        
        //Then
        XCTAssertFalse(viewMock.displayingNoResultsView, "Empty cart not hidden when items available in cart")
    }

}
