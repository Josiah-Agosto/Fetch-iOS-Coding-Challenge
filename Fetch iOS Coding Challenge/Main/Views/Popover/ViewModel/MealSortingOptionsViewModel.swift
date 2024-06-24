//
//  MealSortingOptionsViewModel.swift
//  Fetch iOS Coding Challenge
//
//  Created by Josiah Agosto on 6/24/24.
//

import Foundation
import Combine

class MealSortingOptionsViewModel {
    
    @Published var selectedSortingOption: MealSortingOption = .alphabeticallyAscending
    
    var sortingOptions: [MealSortingOption] {
        return MealSortingOption.allCases
    }
    
}
