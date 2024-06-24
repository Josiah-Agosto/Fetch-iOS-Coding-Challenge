//
//  PopoverViewModelTests.swift
//  Fetch iOS Coding Challenge Tests
//
//  Created by Josiah Agosto on 6/24/24.
//

@testable import Fetch_iOS_Coding_Challenge
import XCTest
import Foundation

class PopoverViewModelTests: XCTestCase {
    // MARK: - References / Properties
    var sut: MealSortingOptionsViewModel!
    
    override func setUp() {
        super.setUp()
        sut = MealSortingOptionsViewModel(selectedSortingOption: .alphabeticallyAscending)
    }
    
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    
    func testSelectedSortingOptionInitialization() {
        let sortingOption: MealSortingOption = .alphabeticallyAscending
        XCTAssertEqual(sut.selectedSortingOption, sortingOption)
    }
    
    
    func testChangingSortingOption() {
        let newSortingOption: MealSortingOption = .alphabeticallyDescending
        sut.selectedSortingOption = newSortingOption
        XCTAssertEqual(sut.selectedSortingOption, newSortingOption)
    }
    
    
    func testMealSortingOptions() {
        XCTAssertEqual(sut.sortingOptions.count, 2)
    }
    
}
