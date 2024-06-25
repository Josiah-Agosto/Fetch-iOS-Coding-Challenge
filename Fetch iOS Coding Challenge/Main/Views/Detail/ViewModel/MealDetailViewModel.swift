//
//  MealDetailViewModel.swift
//  Fetch iOS Coding Challenge
//
//  Created by Josiah Agosto on 6/24/24.
//

import SwiftUI
import os.log

/// View model for managing and providing details of a meal.
class MealDetailViewModel: ObservableObject {
    // MARK: - References / Properties
    /// Published property holding the meal details.
    @Published var meal: Meal
    /// Published property holding the thumbnail image of the meal.
    @Published var thumbnailImage: UIImage = UIImage(systemName: "exclamationmark.triangle.fill")!
    /// The MealDbManager to use.
    private let mealDbManager: MealDbManagerProtocol
    
    // MARK: - Initialization
    /// Initializes the view model with a meal object.
    /// - Parameter meal: The meal object to display details for.
    /// - Parameter mealDbManager: The MealDbManager to use.
    init(meal: Meal, mealDbManager: MealDbManagerProtocol) {
        self.meal = meal
        self.mealDbManager = mealDbManager
        retrieveMealDetails(byId: meal.mealId ?? "")
        loadImage()
    }
    
    // MARK: - Public Methods
    /// Retrieves meal details from a database.
    /// - Parameter byId: The ID of the meal to retrieve.
    public func retrieveMealDetails(byId: String) {
        mealDbManager.retrieveMealDetails(byId: byId) { result in
            switch result {
            case .success(let mealDetailData):
                do {
                    let mealContainer = try JSONDecoder().decode(MealContainer.self, from: mealDetailData)
                    guard let firstMeal = mealContainer.meals.first else {
                        Logger().error("Failed to retrieve the first meal item for id: \(byId)")
                        return
                    }
                    DispatchQueue.main.async {
                        self.meal = firstMeal
                    }
                } catch let error {
                    Logger().error("Failed to decode meal data for id: \(byId), error: \(error.localizedDescription)")
                }
            case .failure(let error):
                Logger().error("Failed to retrieve meal details for id: \(byId), error: \(error.localizedDescription)")
            }
        }
    }
    
    /// Loads the thumbnail image for the meal asynchronously.
    public func loadImage() {
        Task {
            let image = await ImageCache.shared.loadImage(url: meal.thumbnail ?? "")
            DispatchQueue.main.async {
                self.thumbnailImage = image
            }
        }
    }
    
}
