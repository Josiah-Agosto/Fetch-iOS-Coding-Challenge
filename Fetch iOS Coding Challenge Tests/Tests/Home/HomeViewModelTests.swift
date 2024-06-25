//
//  HomeViewModelTests.swift
//  Fetch iOS Coding Challenge Tests
//
//  Created by Josiah Agosto on 6/24/24.
//

@testable import Fetch_iOS_Coding_Challenge
import XCTest
import Foundation

class HomeViewModelTests: XCTestCase {
    // MARK: - References / Properties
    /// System Under Test (SUT): The instance of `HomeViewModel` being tested.
    var sut: HomeViewModel!
    /// Mock instance of `MealDbManager` used to simulate data retrieval.
    var sutHelper: MockMealDbManager = MockMealDbManager()
    
    override func setUp() {
        super.setUp()
        sut = HomeViewModel(mealDbManager: sutHelper)
    }
    
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    /// Tests that the desserts list is initialized as empty.
    func testDessertsInitialization() {
        XCTAssertTrue(sut.desserts.isEmpty)
    }
    
    /// Tests that the searched desserts list is initialized as empty.
    func testSearchedDessertsInitialization() {
        XCTAssertTrue(sut.searchedDesserts.isEmpty)
    }
    
    /// Tests that the meal categories error is nil upon initialization.
    func testRetrieveMealCategoriesNilUponInitialization() {
        XCTAssertNil(sut.retrievingMealCategoriesError)
    }
    
    /// Tests that the empty meal search results flag is false upon initialization.
    func testEmptyMealSearchResultsInitialization() {
        XCTAssertFalse(sut.emptyMealSearchResults)
    }
    
    /// Tests that the sorting option is properly initialized.
    func testSortingOptionInitialization() {
        let sampleSortOptionResult: MealSortingOption = .alphabeticallyAscending
        XCTAssertEqual(sut.sortingOption, sampleSortOptionResult)
    }
    
    /// Tests filtering desserts with an empty search text.
    func testFilteringEmptyDessertText() {
        sut.filterDesserts(by: "")
        XCTAssertFalse(sut.emptyMealSearchResults)
        XCTAssertTrue(sut.searchedDesserts.isEmpty)
    }
    
    /// Tests filtering desserts by a search text that does not match any desserts.
    func testFilterDessertsBySearchText() {
        sut.desserts = [
            Meal(mealId: "123", name: "Apple Pie", thumbnail: "https://test.com"),
            Meal(mealId: "456", name: "Blueberry Pie", thumbnail: "https://test.com"),
            Meal(mealId: "789", name: "Ice Cream", thumbnail: "https://test.com")
        ]
        let expectation = XCTestExpectation(description: "Filter desserts expectation")
        sut.filterDesserts(by: "Z")
        DispatchQueue.main.async {
            XCTAssertEqual(self.sut.desserts.count, 3)
            XCTAssertTrue(self.sut.searchedDesserts.isEmpty)
            XCTAssertTrue(self.sut.emptyMealSearchResults)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
    
    /// Tests retrieving dessert meals successfully.
    func testRetrieveDessertMeals_Success() {
        sutHelper.sampleData = """
        {
            "meals": [
                {
                    "idMeal": "1",
                    "strMeal": "Chocolate Cake"
                },
                {
                    "idMeal": "2",
                    "strMeal": "Cheesecake"
                }
            ]
        }
        """.data(using: .utf8)
        let expectation = XCTestExpectation(description: "Retrieve desserts expectation")
        sut.retrieveDessertMeals(sortingOption: .alphabeticallyAscending)
        DispatchQueue.main.async {
            XCTAssertEqual(self.sut.desserts.count, 2)
            XCTAssertEqual(self.sut.desserts.first?.name, "Cheesecake")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
    
    /// Tests sorting meals alphabetically in ascending order.
    func testSortMealsAlphabetically_Ascending() {
        let meals = [
            Meal(mealId: "2", name: "Cheesecake", thumbnail: nil),
            Meal(mealId: "1", name: "Chocolate Cake")
        ]
        let sortedMeals = sut.sortMealsAlphabetically(meals: meals, type: .alphabeticallyAscending)
        XCTAssertEqual(sortedMeals.first?.name, "Cheesecake")
        XCTAssertEqual(sortedMeals.last?.name, "Chocolate Cake")
    }
    
    /// Tests filtering out meals with nil values.
    func testFilterNilValues() {
        let meals = [
            Meal(mealId: "1", name: "Chocolate Cake"),
            Meal(mealId: "2", name: nil, thumbnail: nil),
            Meal(mealId: nil, name: "Cheesecake")
        ]
        let filteredMeals = sut.filterNilValues(meals: meals)
        XCTAssertEqual(filteredMeals.count, 1)
        XCTAssertEqual(filteredMeals.first?.name, "Chocolate Cake")
    }

}
