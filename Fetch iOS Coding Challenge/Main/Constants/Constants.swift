//
//  Constants.swift
//  Fetch iOS Coding Challenge
//
//  Created by Josiah Agosto on 6/21/24.
//

import Foundation

/// Contains constants related to Meal DB URLs.
struct Constants {
    /// Creates a Meal DB category URL with the given category name.
    /// - Parameter category: The category name to create the URL with.
    /// - Returns: The constructed URL as a string.
    static func createMealDbCategoryUrlWithCategory(category: String) -> String {
        return "https://themealdb.com/api/json/v1/1/filter.php?c=" + category
    }
    
    /// Creates a Meal DB lookup URL with the given meal ID.
    /// - Parameter mealId: The ID of the meal to create the lookup URL with.
    /// - Returns: The constructed URL as a string.
    static func createMealDbLookupUrlWithId(mealId: String) -> String {
        return "https://themealdb.com/api/json/v1/1/lookup.php?i=" + mealId
    }
    
}
