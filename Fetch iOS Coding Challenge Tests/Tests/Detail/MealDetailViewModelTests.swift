//
//  MealDetailViewModelTests.swift
//  Fetch iOS Coding Challenge Tests
//
//  Created by Josiah Agosto on 6/25/24.
//

@testable import Fetch_iOS_Coding_Challenge
import XCTest

class MealDetailViewModelTests: XCTestCase {
    // MARK: - References / Properties
    var sut: MealDetailViewModel!
    
    override func setUp() {
        super.setUp()
        let meal = Meal(mealId: "123", name: "Test Meal", thumbnail: "https://example.com/test_image.jpg", area: "Test Area")
        sut = MealDetailViewModel(meal: meal, mealDbManager: MockMealDbManager())
    }
    
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    
    func testRetrieveMealDetails() {
        let expectation = expectation(description: "Retrieve meal details.")
        DispatchQueue.main.async {
            self.sut.retrieveMealDetails(byId: self.sut.meal.mealId ?? "")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(sut.meal.name, "Test Meal")
        XCTAssertEqual(sut.meal.area, "Test Area")
    }

    
    func testMealDetailViewModelInitialization() {
        XCTAssertEqual(sut.meal.name, "Test Meal")
        XCTAssertEqual(sut.meal.area, "Test Area")
    }
    
    
    func testMealDetailViewModelErrorHandling() {
        let invalidMealId = "nonExistentMealId"
        let expectation = expectation(description: "Retrieve meal details with error.")
        DispatchQueue.main.async {
            self.sut.retrieveMealDetails(byId: invalidMealId)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(sut.meal.name, "Test Meal")
        XCTAssertEqual(sut.meal.area, "Test Area")
    }
    
}
