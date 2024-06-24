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
    var sut: HomeViewModel!
    var sutHelper: MockMealDbManager = MockMealDbManager()
    
    override func setUp() {
        super.setUp()
        sut = HomeViewModel(mealDbManager: sutHelper)
    }
    
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    
    func testDessertsInitialization() {
        XCTAssertTrue(sut.desserts.isEmpty)
    }
    
    
    func testSearchedDessertsInitialization() {
        XCTAssertTrue(sut.searchedDesserts.isEmpty)
    }
    
    
    func testRetrieveMealCategoriesNilUponInitialization() {
        XCTAssertNil(sut.retrievingMealCategoriesError)
    }
    
    
    func testEmptyMealSearchResultsInitialization() {
        XCTAssertFalse(sut.emptyMealSearchResults)
    }
    
    
    func testSortingOptionInitialization() {
        let sampleSortOptionResult: MealSortingOption = .alphabeticallyAscending
        XCTAssertEqual(sut.sortingOption, sampleSortOptionResult)
    }
    
    
    func testFilteringEmptyDessertText() {
        sut.filterDesserts(by: "")
        XCTAssertFalse(sut.emptyMealSearchResults)
        XCTAssertTrue(sut.searchedDesserts.isEmpty)
    }
    
    
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
    
    
    func testSortMealsAlphabetically_Ascending() {
        let meals = [
            Meal(mealId: "2", name: "Cheesecake", thumbnail: nil),
            Meal(mealId: "1", name: "Chocolate Cake")
        ]
        let sortedMeals = sut.sortMealsAlphabetically(meals: meals, type: .alphabeticallyAscending)
        XCTAssertEqual(sortedMeals.first?.name, "Cheesecake")
        XCTAssertEqual(sortedMeals.last?.name, "Chocolate Cake")
    }
    
    
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
