//
//  MockMealDbManager.swift
//  Fetch iOS Coding Challenge Tests
//
//  Created by Josiah Agosto on 6/24/24.
//

@testable import Fetch_iOS_Coding_Challenge
import Foundation

/// Mock implementation of `MealDbManagerProtocol` for testing purposes
class MockMealDbManager: MealDbManagerProtocol {
    // MARK: - References / Properties
    /// Decides if an error should be thrown
    var shouldReturnError = false
    /// You specify the data to return when successful.
    var sampleData: Data?
    
    func retrieveCategories(byName: String, completion: @escaping (Result<Data, Error>) -> Void) {
        let urlString = Constants.createMealDbCategoryUrlWithCategory(category: byName)
        retrieveData(from: urlString, completion: completion)
    }
    
    
    func retrieveMealDetails(byId: String, completion: @escaping (Result<Data, Error>) -> Void) {
        let urlString = Constants.createMealDbLookupUrlWithId(mealId: byId)
        retrieveData(from: urlString, completion: completion)
    }
    
    /// Retrieves meal categories by name.
    /// - Parameters:
    ///   - byName: The name of the category to retrieve.
    ///   - completion: Completion handler with result containing Data or Error.
    func retrieveData(from urlString: String, completion: @escaping (Result<Data, any Error>) -> Void) {
        if shouldReturnError {
            let error = NSError(domain: "MockError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Mock error"])
            completion(.failure(error))
        } else {
            if let data = sampleData {
                completion(.success(data))
            } else {
                let error = NSError(domain: "MockError", code: 2, userInfo: [NSLocalizedDescriptionKey: "No sample data provided"])
                completion(.failure(error))
            }
        }
    }
    
}
