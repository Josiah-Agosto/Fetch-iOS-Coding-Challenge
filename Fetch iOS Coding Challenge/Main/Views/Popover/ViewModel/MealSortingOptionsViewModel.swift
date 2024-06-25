//
//  MealSortingOptionsViewModel.swift
//  Fetch iOS Coding Challenge
//
//  Created by Josiah Agosto on 6/24/24.
//

import Foundation
import Combine

/// ViewModel responsible for managing meal sorting options.
<<<<<<< HEAD
class MealSortingOptionsViewModel {
    /// Published property for the currently selected sorting option.
    @Published var selectedSortingOption: MealSortingOption = .alphabeticallyAscending
    /// Computed property returning all available meal sorting options.
    var sortingOptions: [MealSortingOption] {
        return MealSortingOption.allCases
    }
    
=======
class MealSortingOptionsViewModel: MealSortingOptionsViewModelProtocol {
    // MARK: - References / Properties
    /// The currently selected sorting option for meals.
    @Published public var selectedSortingOption: MealSortingOption
    /// Publisher for observing changes to the selected sorting option.
    public var selectedSortingOptionPublisher: Published<MealSortingOption>.Publisher { $selectedSortingOption }
    /// List of all available meal sorting options.
    public var sortingOptions: [MealSortingOption] {
        return MealSortingOption.allCases
    }
    
    init(selectedSortingOption: MealSortingOption = .alphabeticallyAscending) {
        self.selectedSortingOption = selectedSortingOption
    }
    
>>>>>>> 2b70d0b826369b5c56aa7824c502a6f31d3513d5
}
