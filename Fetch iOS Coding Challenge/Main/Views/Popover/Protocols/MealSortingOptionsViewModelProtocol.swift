//
//  MealSortingOptionsViewModelProtocol.swift
//  Fetch iOS Coding Challenge
//
//  Created by Josiah Agosto on 6/24/24.
//

import Foundation
import Combine

/// Used in the `MealSortingViewModel` to keep track of and update the sort option.
protocol MealSortingOptionsViewModelProtocol: ObservableObject {
    /// Used for the currently selected sorting option.
    var selectedSortingOption: MealSortingOption { get set }
    /// Published property for the currently selected sorting option.
    var selectedSortingOptionPublisher: Published<MealSortingOption>.Publisher { get }
    /// Computed property returning all available meal sorting options.
    var sortingOptions: [MealSortingOption] { get }
}
