//
//  RecordsListTests.swift
//  MusicStoreTests
//
//  Created by Rashmikant Makwana on 26/08/20.
//  Copyright © 2020 Rashmikant Makwana. All rights reserved.
//

import XCTest
@testable import MusicStore

class RecordsListTests: XCTestCase {
    
    let viewMock = RecordsListViewMock()
    let useCaseMock = RecordsListUseCaseMock()
    let tableCellMock = RecordsListTableCellMock()
    var viewModel: RecordsListViewModelImplementation!
    
    // MARK: - Set up
    override func setUp() {
        super.setUp()
        viewModel = RecordsListViewModelImplementation(view: viewMock,
                                                       useCase: useCaseMock)
    }
    
    // MARK: - Tests
    
    func test_viewDidLoad_fetches_records_and_refreshes_list() {
        // Given
        let expectedRecordsCount = 6
        let recordsToBeFetched = Record.createRecordsList(numberOfItems: expectedRecordsCount)
        useCaseMock.resultsToReturn = recordsToBeFetched
        
        // When
        viewModel.viewDidLoad()
        
        // Then
        XCTAssertTrue(viewMock.tableReloaded, "TableView not reloaded after data fetched")
    }
    
    func test_viewDidLoad_fetches_records_and_stops_loader() {
        // Given
        let expectedRecordsCount = 6
        let recordsToBeFetched = Record.createRecordsList(numberOfItems: expectedRecordsCount)
        useCaseMock.resultsToReturn = recordsToBeFetched
        
        // When
        viewModel.viewDidLoad()
        
        // Then
        XCTAssertFalse(viewMock.loaderVisible, "Loader is not hidden on list refresh")
    }
    
    func test_no_results_view_shown_on_empty_results() {
        // Given
        useCaseMock.resultsToReturn = nil
        
        // When
        viewModel.fetchList()
        
        // Then
        XCTAssertTrue(viewMock.noResultsViewVisible, "No results view not shown on empty results")
    }
    
    func test_no_results_view_hidden_when_results_available() {
        // Given
        let expectedRecordsCount = 6
        let recordsToBeFetched = Record.createRecordsList(numberOfItems: expectedRecordsCount)
        useCaseMock.resultsToReturn = recordsToBeFetched
        
        // When
        viewModel.fetchList()
        
        // Then
        XCTAssertFalse(viewMock.noResultsViewVisible, "No results view not hidden when results available")
    }
    
    func test_error_message_displayed_on_error() {
        //Given
        let errorDescription = "Internet connection appers to be offline"
        let error = CustomError(str: errorDescription)
        useCaseMock.errorToReturn = error
        
        // When
        viewModel.fetchList()
        // Then
        XCTAssertEqual(viewMock.errorMessageDisplayed, errorDescription, "Error message is not as expected")
    }
    
    func test_configuration_table_view_cell() {
        //Given
        let expectedRecordsCount = 6
        let recordsToBeDisplayed = Record.createRecordsList(numberOfItems: expectedRecordsCount)
        viewModel.records = recordsToBeDisplayed
        let recordToBeTested = recordsToBeDisplayed[4]
        
        // When
        viewModel.configure(cell: tableCellMock, for: IndexPath(row: 4, section: 0))
        
        // Then
        XCTAssertEqual(tableCellMock.record, recordToBeTested, "Cell does not display details of expected record")
    }
    
    func test_selected_record_state_saved() {
        // Given
        let recordsToBeDisplayed = Record.createRecordsList(numberOfItems: 10)
        viewModel.records = recordsToBeDisplayed
        let selectionAtIndex = 3
        
        // When
        viewModel.select(cell: tableCellMock, for: IndexPath(row: selectionAtIndex, section: 0))
        
        // Then
        let selectedFeed = viewModel.records[selectionAtIndex]
        XCTAssertTrue(selectedFeed.isSelected, "Selection not reflected on expected record")
    }
    
    func test_sort_option_sets_expected_option() {
        // Given
        let optionDesc = "Track Name"
        
        // When
        // SortOption(2) -> Track Name
        viewModel.changeSortOption(index: 2)
        
        // Then
        XCTAssertEqual(optionDesc, viewModel.sortOption, "Sort option not set as expected")
    }
    
    func test_search_records_works_for_track_name() {
        // Given
        let recordsToBeDisplayed = Record.createRecordsList(numberOfItems: 10)
        viewModel.records = recordsToBeDisplayed
        let searchKeyword = recordsToBeDisplayed[6].trackName
        
        // When
        viewModel.search(for: searchKeyword)
        
        // Then
        let firstSearchResult = viewModel.filtered.first
        XCTAssertEqual(firstSearchResult?.trackName, searchKeyword, "Search by track name not working as expected")
    }
}
