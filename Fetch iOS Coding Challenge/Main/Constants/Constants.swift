//
//  Constants.swift
//  Fetch iOS Coding Challenge
//
//  Created by Josiah Agosto on 6/21/24.
//

import Foundation

struct Constants {
    // MARK: - Meal DB URLs
    static func createMealDbCategoryUrlWithCategory(category: String) -> String {
        return "https://themealdb.com/api/json/v1/1/filter.php?c=" + category
    }
    
    
    static func createMealDbLookupUrlWithId(mealId: Int) -> String {
        return "https://themealdb.com/api/json/v1/1/lookup.php?i=" + String(mealId)
    }
    
}
