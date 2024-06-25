//
//  HomeViewModel.swift
//  Fetch iOS Coding Challenge
//
//  Created by Josiah Agosto on 6/21/24.
//

import Foundation
import Combine
import os.log

/// View model for managing and processing meal data related to categories(desserts).
<<<<<<< HEAD
class HomeViewModel: ObservableObject {
    // MARK: - References / Properties
    /// Published property holding the list of all desserts.
    @Published public var desserts: [Meal] = []
    /// Published property holding the list of desserts filtered by search text.
    @Published public var searchedDesserts: [Meal] = []
    /// Published property indicating whether there was an error retrieving meal categories.
    @Published public var retrievingMealCategoriesError: Error? = nil
    /// Published property indicating if there are no results found for the current search.
    @Published public var emptyMealSearchResults: Bool = false
    /// Published property holding the current sorting option for desserts.
    @Published public var sortingOption: MealSortingOption = .alphabeticallyAscending
=======
class HomeViewModel: HomeViewModelProtocol {
    // MARK: - References / Properties
    /// Published property holding the list of all desserts.
    @Published public var desserts: [Meal] = []
    public var dessertsPublisher: Published<[Meal]>.Publisher { $desserts }
    /// Published property holding the list of desserts filtered by search text.
    @Published public var searchedDesserts: [Meal] = []
    public var searchedDessertsPublisher: Published<[Meal]>.Publisher { $searchedDesserts }
    /// Published property indicating whether there was an error retrieving meal categories.
    @Published public var retrievingMealCategoriesError: Error? = nil
    public var retrievingMealCategoriesErrorPublisher: Published<(any Error)?>.Publisher { $retrievingMealCategoriesError }
    /// Published property indicating if there are no results found for the current search.
    @Published public var emptyMealSearchResults: Bool = false
    public var emptyMealSearchResultsPublisher: Published<Bool>.Publisher { $emptyMealSearchResults }
    /// Published property holding the current sorting option for desserts.
    @Published public var sortingOption: MealSortingOption = .alphabeticallyAscending
    public var sortingOptionPublisher: Published<MealSortingOption>.Publisher { $sortingOption }
    /// The MealDbManager to use.
    private let mealDbManager: MealDbManagerProtocol
    
    /// Create an instance with a specified MealDbManager.
    /// - Parameter mealDbManager: The MealDbManager instance to use.
    init(mealDbManager: MealDbManagerProtocol) {
        self.mealDbManager = mealDbManager
    }
>>>>>>> 2b70d0b826369b5c56aa7824c502a6f31d3513d5
    
    // MARK: - Public Methods
    /// Filters desserts based on the provided search text.
    /// - Parameter searchText: The text to filter desserts by.
    public func filterDesserts(by searchText: String) {
        if searchText.isEmpty {
            DispatchQueue.main.async {
                self.emptyMealSearchResults = false
                self.searchedDesserts = []
            }
        } else {
            DispatchQueue.main.async {
                self.searchedDesserts = self.desserts.filter { $0.name?.lowercased().contains(searchText.lowercased()) ?? false }
<<<<<<< HEAD
                // If the search turned up no results.
                if self.searchedDesserts.isEmpty {
=======
            }
            // If the search turned up no results.
            if self.searchedDesserts.isEmpty {
                DispatchQueue.main.async {
>>>>>>> 2b70d0b826369b5c56aa7824c502a6f31d3513d5
                    self.emptyMealSearchResults = true
                }
            }
        }
    }
    
    /// Retrieves dessert meals from MealDB based on the specified sorting option.
    /// - Parameter sortingOption: The sorting option for desserts.
    public func retrieveDessertMeals(sortingOption: MealSortingOption) {
<<<<<<< HEAD
        MealDbManager().retrieveCategories(byName: "Dessert") { result in
=======
        mealDbManager.retrieveCategories(byName: "Dessert") { result in
>>>>>>> 2b70d0b826369b5c56aa7824c502a6f31d3513d5
            switch result {
                case .success(let mealDbData):
                    do {
                        // Decodes the Meal array, filters out unwanted meals and alphabetizes the meals in preparation for displaying.
                        let meals = try JSONDecoder().decode(MealContainer.self, from: mealDbData)
                        let filteredMeals = self.filterNilValues(meals: meals.meals)
                        let alphabetizedMeals = self.sortMealsAlphabetically(meals: filteredMeals, type: sortingOption)
                        DispatchQueue.main.async {
                            self.desserts = alphabetizedMeals
                        }
                    } catch let decodingError {
                        self.retrievingMealCategoriesError = decodingError
                        Logger.main.error("Error retrieving category, a decoding error occurred, with errors: \(decodingError): \(decodingError.localizedDescription)")
                    }
                case .failure(let error):
                    self.retrievingMealCategoriesError = error
                    Logger.main.error("Error retrieving category, \"Dessert\", with errors: \(error): \(error.localizedDescription)")
            }
        }
    }
    
    /// Sorts meals alphabetically based on the specified sorting option.
    /// - Parameters:
    ///   - meals: The array of meals to be sorted.
    ///   - type: The sorting option (ascending or descending).
    /// - Returns: An array of meals sorted alphabetically.
    public func sortMealsAlphabetically(meals: [Meal], type: MealSortingOption) -> [Meal] {
        if type == .alphabeticallyAscending {
            return meals.sorted { $0.name ?? "" < $1.name ?? "" }
        } else {
            return meals.sorted { $0.name ?? "" > $1.name ?? "" }
        }
    }
    
    /// Filters out meals with nil or empty values for meal ID or name.
    /// - Parameter meals: The array of meals to be filtered.
    /// - Returns: An array of meals with non-nil and non-empty values for meal ID and name.
    public func filterNilValues(meals: [Meal]) -> [Meal] {
        let filteredMeals = meals.filter { meal in
            guard let id = meal.mealId, !id.isEmpty,
                  let name = meal.name, !name.isEmpty
            else { return false }
            return true
        }
        return filteredMeals
    }
    
}
