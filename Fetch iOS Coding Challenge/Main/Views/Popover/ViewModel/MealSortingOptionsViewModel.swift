//
//  MealSortingOptionsViewModel.swift
//  Fetch iOS Coding Challenge
//
//  Created by Josiah Agosto on 6/24/24.
//

import Foundation
import Combine

/// ViewModel responsible for managing meal sorting options.
class MealSortingOptionsViewModel {
    /// Published property for the currently selected sorting option.
    @Published var selectedSortingOption: MealSortingOption = .alphabeticallyAscending
    /// Computed property returning all available meal sorting options.
    var sortingOptions: [MealSortingOption] {
        return MealSortingOption.allCases
    }
    
}
