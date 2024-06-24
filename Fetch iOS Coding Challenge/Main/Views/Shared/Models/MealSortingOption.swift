//
//  MealSortingOption.swift
//  Fetch iOS Coding Challenge
//
//  Created by Josiah Agosto on 6/24/24.
//

import Foundation

enum MealSortingOption: String, CaseIterable {
    case alphabeticallyAscending = "Alphabetically Ascending"
    case alphabeticallyDescending = "Alphabetically Descending"
    
    var displayName: String {
        return rawValue
    }
}
