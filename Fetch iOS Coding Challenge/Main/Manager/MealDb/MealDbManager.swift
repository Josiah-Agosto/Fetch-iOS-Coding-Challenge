//
//  MealDbManager.swift
//  Fetch iOS Coding Challenge
//
//  Created by Josiah Agosto on 6/21/24.
//

import Foundation
import os.log

/// Manager class responsible for handling Meal DB API interactions.
class MealDbManager {
    /// Retrieves meal categories from Meal DB based on the given category name.
    /// - Parameters:
    ///   - byName: The name of the category to retrieve.
    ///   - completion: Completion handler returning a Result containing either the retrieved data or an error.
    public func retrieveCategories(byName: String, completion: @escaping (Result<Data, Error>) -> Void) {
        let urlString = Constants.createMealDbCategoryUrlWithCategory(category: byName)
        let categoryUrlRequest = URLRequest(url: URL(string: urlString)!)
        URLSession.shared.dataTask(with: categoryUrlRequest) { data, response, error in
            if let error = error {
                Logger.main.error("Error encountered attempting to retrieve meal categories from MealDB, with errors: \(error): \(error.localizedDescription)")
                completion(.failure(error))
            } else {
                guard let data = data else {
                    let customError = NSError(domain: "", code: 01, userInfo: [NSLocalizedDescriptionKey: "The data for retrieving the category \"\(byName)\" couldn't be processed."])
                    Logger.main.error("Error encountered attempting to parse meal categories data from MealDB, with errors: \(customError): \(customError.localizedDescription)")
                    completion(.failure(customError))
                    return
                }
                completion(.success(data))
            }
        }.resume()
    }
    
}
