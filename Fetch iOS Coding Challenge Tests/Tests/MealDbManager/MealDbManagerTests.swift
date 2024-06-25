//
//  MealDbManagerTests.swift
//  Fetch iOS Coding Challenge Tests
//
//  Created by Josiah Agosto on 6/24/24.
//

import XCTest
import Foundation

class MealDbManagerTests: XCTestCase {
    // MARK: - References / Properties
    /// System Under Test (SUT): The instance of `MockMealDbManager` being tested.
    private var sut: MockMealDbManager!
    
    override func setUp() {
        super.setUp()
        sut = MockMealDbManager()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    /// Tests that meal categories are retrieved successfully.
    func testSuccessfulCategoryRetrieval() {
        let incomingData = """
        {
            "meals": [
                {
                    "idMeal": "12345",
                    "strMeal": "Test Meal",
                    "strMealThumb": "https://example.com/meal.jpg"
                }
            ]
        }
        """.data(using: .utf8)
        sut.sampleData = incomingData
        sut.retrieveCategories(byName: "Dessert") { result in
            switch result {
                case .success(let outputData):
                    XCTAssertEqual(outputData, incomingData)
                case .failure(let error):
                    XCTAssertNil(error)
            }
        }
    }
    
    /// Tests that meal category retrieval fails with an error.
    func testFailedCategoryRetrieval() {
        let incomingData = """
        {
            "meals": [
                {
                    "idMeal": "12345",
                    "strMeal": "Test Meal",
                    "strMealThumb": "https://example.com/meal.jpg"
                }
            ]
        }
        """.data(using: .utf8)
        sut.sampleData = incomingData
        sut.shouldReturnError = true
        sut.retrieveCategories(byName: "Dessert") { result in
            switch result {
                case .success(let outputData):
                    XCTAssertEqual(outputData, incomingData)
                case .failure(let error):
                    XCTAssertNotNil(error)
            }
        }
    }
    
}
