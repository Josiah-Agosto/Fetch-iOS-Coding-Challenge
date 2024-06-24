//
//  HomeViewModelProtocol.swift
//  Fetch iOS Coding Challenge
//
//  Created by Josiah Agosto on 6/24/24.
//

import Foundation
import Combine

protocol HomeViewModelProtocol: ObservableObject {
    var desserts: [Meal] { get set }
    var searchedDesserts: [Meal] { get set }
    var retrievingMealCategoriesError: Error? { get set }
    var emptyMealSearchResults: Bool { get set }
    var sortingOption: MealSortingOption { get set }
    var dessertsPublisher: Published<[Meal]>.Publisher { get }
    var searchedDessertsPublisher: Published<[Meal]>.Publisher { get }
    var retrievingMealCategoriesErrorPublisher: Published<Error?>.Publisher { get }
    var emptyMealSearchResultsPublisher: Published<Bool>.Publisher { get }
    var sortingOptionPublisher: Published<MealSortingOption>.Publisher { get }
    func filterDesserts(by searchText: String)
    func retrieveDessertMeals(sortingOption: MealSortingOption)
    func sortMealsAlphabetically(meals: [Meal], type: MealSortingOption) -> [Meal]
    func filterNilValues(meals: [Meal]) -> [Meal]
}
