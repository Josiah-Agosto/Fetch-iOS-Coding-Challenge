//
//  MealSortingOption.swift
//  Fetch iOS Coding Challenge
//
//  Created by Josiah Agosto on 6/24/24.
//

import Foundation

/// Holds possible sorting options for meals.
enum MealSortingOption: String, CaseIterable {
    /// Will sort the meals A-Z.
    case alphabeticallyAscending = "Alphabetically Ascending"
    /// Will sort the meals Z-A.
    case alphabeticallyDescending = "Alphabetically Descending"
    /// The raw value of the option.
    var displayName: String {
        return rawValue
    }
    
}
