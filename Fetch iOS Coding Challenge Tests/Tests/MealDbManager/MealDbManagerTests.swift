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
    private var sut: MockMealDbManager!
    
    override func setUp() {
        super.setUp()
        sut = MockMealDbManager()
    }
    
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    
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
