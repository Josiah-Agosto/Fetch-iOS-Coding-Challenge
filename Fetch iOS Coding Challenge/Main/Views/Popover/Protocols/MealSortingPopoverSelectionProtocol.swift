//
//  MealSortingPopoverSelectionProtocol.swift
//  Fetch iOS Coding Challenge
//
//  Created by Josiah Agosto on 6/24/24.
//

import Foundation

/// Used in `MealSortingPopoverViewController` to send the selected option.
protocol MealSortingPopoverSelectionProtocol: AnyObject {
    func sortingOptionSelected(_ option: MealSortingOption)
}
