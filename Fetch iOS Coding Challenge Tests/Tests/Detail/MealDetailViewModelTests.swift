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
    /// System Under Test (SUT): The instance of MealDetailViewModel being tested.
    var sut: MealDetailViewModel!
    
    override func setUp() {
        super.setUp()
        // Mock meal data for testing.
        let meal = Meal(mealId: "123", name: "Test Meal", thumbnail: "https://example.com/test_image.jpg", area: "Test Area")
        sut = MealDetailViewModel(meal: meal, mealDbManager: MockMealDbManager())
    }
    
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    /// Tests the retrieval of meal details.
    func testRetrieveMealDetails() {
        let expectation = self.expectation(description: "Retrieve meal details.")
        DispatchQueue.main.async {
            self.sut.retrieveMealDetails(byId: self.sut.meal.mealId ?? "")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(sut.meal.name, "Test Meal")
        XCTAssertEqual(sut.meal.area, "Test Area")
    }
    
    /// Tests the initial state of MealDetailViewModel.
    func testMealDetailViewModelInitialization() {
        // Verify that the initial state is set correctly.
        XCTAssertEqual(sut.meal.name, "Test Meal")
        XCTAssertEqual(sut.meal.area, "Test Area")
    }
    
    /// Tests error handling during meal details retrieval.
    func testMealDetailViewModelErrorHandling() {
        let invalidMealId = "nonExistentMealId"
        let expectation = self.expectation(description: "Retrieve meal details with error.")
        DispatchQueue.main.async {
            self.sut.retrieveMealDetails(byId: invalidMealId)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        // Verify that the meal details remain unchanged upon error.
        XCTAssertEqual(sut.meal.name, "Test Meal")
        XCTAssertEqual(sut.meal.area, "Test Area")
    }
    
}
