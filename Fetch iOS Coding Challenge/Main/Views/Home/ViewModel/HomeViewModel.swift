//
//  HomeViewModel.swift
//  Fetch iOS Coding Challenge
//
//  Created by Josiah Agosto on 6/21/24.
//

import Foundation
import Combine
import os.log

class HomeViewModel: ObservableObject {
    // MARK: - References / Properties
    @Published public var desserts: [Meal] = []
    @Published public var searchedDesserts: [Meal] = []
    @Published public var retrievingMealCategoriesError: Error? = nil
    @Published public var emptyMealSearchResults: Bool = false
    @Published public var sortingOption: MealSortingOption = .alphabeticallyAscending
    
    public func filterDesserts(by searchText: String) {
        if searchText.isEmpty {
            DispatchQueue.main.async {
                self.emptyMealSearchResults = false
                self.searchedDesserts = []
            }
        } else {
            DispatchQueue.main.async {
                self.searchedDesserts = self.desserts.filter { $0.name?.lowercased().contains(searchText.lowercased()) ?? false }
                if self.searchedDesserts.isEmpty {
                    self.emptyMealSearchResults = true
                }
            }
        }
    }
    
    
    public func retrieveDessertMeals(sortingOption: MealSortingOption) {
        MealDbManager().retrieveCategories(byName: "Dessert") { result in
            switch result {
                case .success(let mealDbData):
                    do {
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
    
    
    public func sortMealsAlphabetically(meals: [Meal], type: MealSortingOption) -> [Meal] {
        if type == .alphabeticallyAscending {
            return meals.sorted { $0.name ?? "" < $1.name ?? "" }
        } else {
            return meals.sorted { $0.name ?? "" > $1.name ?? "" }
        }
    }
    
    
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
