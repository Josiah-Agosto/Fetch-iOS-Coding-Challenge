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
    /// System Under Test (SUT): The instance of `MealSortingOptionsViewModel` being tested.
    var sut: MealSortingOptionsViewModel!
    
    override func setUp() {
        super.setUp()
        // Initialize the system under test with the default sorting option.
        sut = MealSortingOptionsViewModel(selectedSortingOption: .alphabeticallyAscending)
    }
    
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    /// Tests that the selected sorting option is properly initialized.
    func testSelectedSortingOptionInitialization() {
        let sortingOption: MealSortingOption = .alphabeticallyAscending
        XCTAssertEqual(sut.selectedSortingOption, sortingOption)
    }
    
    /// Tests that the sorting option can be successfully changed.
    func testChangingSortingOption() {
        let newSortingOption: MealSortingOption = .alphabeticallyDescending
        sut.selectedSortingOption = newSortingOption
        XCTAssertEqual(sut.selectedSortingOption, newSortingOption)
    }
    
    /// Tests that the meal sorting options are correctly retrieved.
    func testMealSortingOptions() {
        XCTAssertEqual(sut.sortingOptions.count, 2)
    }
    
}
