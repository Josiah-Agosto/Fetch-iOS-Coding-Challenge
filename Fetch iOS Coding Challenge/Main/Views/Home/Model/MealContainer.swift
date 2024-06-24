//
//  MealContainer.swift
//  Fetch iOS Coding Challenge
//
//  Created by Josiah Agosto on 6/23/24.
//

import Foundation

/// Represents the actual format the JSON comes in from MealDB.
struct MealContainer: Decodable {
    /// Contains all meals.
    let meals: [Meal]
}
