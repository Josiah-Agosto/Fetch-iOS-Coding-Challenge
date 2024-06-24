//
//  MealDbManager.swift
//  Fetch iOS Coding Challenge
//
//  Created by Josiah Agosto on 6/21/24.
//

import Foundation

class MealDbManager {
    // MARK: - References / Properties
    
    public func retrieveCategories(byName: String, completion: @escaping (Result<Data, Error>) -> Void) {
        let urlString = Constants.createMealDbCategoryUrlWithCategory(category: byName)
        let categoryUrlRequest = URLRequest(url: URL(string: urlString)!)
        URLSession.shared.dataTask(with: categoryUrlRequest) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else {
                guard let data = data else {
                    let customError = NSError(domain: "", code: 01, userInfo: [NSLocalizedDescriptionKey: "The data for retrieving the category \"\(byName)\" couldn't be processed."])
                    completion(.failure(customError))
                    return
                }
                completion(.success(data))
            }
        }.resume()
    }
    
    
    public func convertImageUrlToData(imageUrl: String) {
        
    }
    
}
    
