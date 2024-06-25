//
//  MealDbManager.swift
//  Fetch iOS Coding Challenge
//
//  Created by Josiah Agosto on 6/21/24.
//

import Foundation
import os.log

/// Manager class responsible for handling Meal DB API interactions.
final class MealDbManager: MealDbManagerProtocol {
    // MARK: - Public Methods
    /// Retrieves meal categories from Meal DB based on the given category name.
    /// This method constructs a URL string for the given category name and performs a network request to retrieve the meal categories.
    /// - Parameters:
    ///   - byName: The name of the category to retrieve.
    ///   - completion: Completion handler returning a Result containing either the retrieved data or an error.
    public func retrieveCategories(byName: String, completion: @escaping (Result<Data, Error>) -> Void) {
        let urlString = Constants.createMealDbCategoryUrlWithCategory(category: byName)
        retrieveData(from: urlString, completion: completion)
    }
    
    /// Retrieves meal details from Meal DB based on the given meal ID.
    /// This method constructs a URL string for the given meal ID and performs a network request to retrieve the meal details.
    /// - Parameters:
    ///   - byId: The ID of the meal to retrieve.
    ///   - completion: Completion handler returning a Result containing either the retrieved data or an error.
    public func retrieveMealDetails(byId: String, completion: @escaping (Result<Data, Error>) -> Void) {
        let urlString = Constants.createMealDbLookupUrlWithId(mealId: byId)
        retrieveData(from: urlString, completion: completion)
    }
    
    /// Performs a network request to fetch data from the given URL string.
    /// This method handles the common logic for making a network request, handling errors, and returning the result.
    /// - Parameters:
    ///   - urlString: The URL string to fetch data from.
    ///   - completion: Completion handler returning a Result containing either the retrieved data or an error.
    public func retrieveData(from urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            let urlError = NSError(domain: "", code: 02, userInfo: [NSLocalizedDescriptionKey: "Invalid URL string: \(urlString)"])
            completion(.failure(urlError))
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                Logger.main.error("Error encountered during network request, with errors: \(error): \(error.localizedDescription)")
                completion(.failure(error))
            } else {
                guard let data = data else {
                    let customError = NSError(domain: "", code: 01, userInfo: [NSLocalizedDescriptionKey: "The data couldn't be processed for URL: \(urlString)"])
                    Logger.main.error("Error encountered attempting to parse data, with errors: \(customError): \(customError.localizedDescription)")
                    completion(.failure(customError))
                    return
                }
                completion(.success(data))
            }
        }.resume()
    }
    
}
