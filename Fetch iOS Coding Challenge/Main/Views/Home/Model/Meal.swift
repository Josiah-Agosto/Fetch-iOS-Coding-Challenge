//
//  Meal.swift
//  Fetch iOS Coding Challenge
//
//  Created by Josiah Agosto on 6/21/24.
//

import Foundation

/// Represents a meal model fetched from MealDB.
struct Meal: Decodable {
    // MARK: - References / Properties
    /// The unique identifier for the meal.
    let mealId: String?
    /// The name of the meal.
    let name: String?
    /// The URL string for the thumbnail image of the meal.
    let thumbnail: String?
    /// The area or region where the meal originates from.
    let area: String?
    /// The category or type of the meal.
    let category: String?
    /// The instructions to prepare the meal.
    let instructions: String?
    /// The source of the meal recipe.
    let source: String?
    /// The YouTube link for a video recipe of the meal.
    let youtubeLink: String?
    /// Dictionary containing ingredients and their respective measures for the meal.
    var ingredientsMeasure: [String: String]?
    
    // MARK: - Coding Keys
    /// Coding keys to map JSON keys to struct properties.
    enum CodingKeys: String, CodingKey {
        case mealId = "idMeal"
        case name = "strMeal"
        case thumbnail = "strMealThumb"
        case area = "strArea"
        case category = "strCategory"
        case instructions = "strInstructions"
        case source = "strSource"
        case youtubeLink = "strYoutube"
    }
    
    // MARK: - Initialization
    /// Initializes a meal object from decoder.
    /// - Parameter decoder: The decoder to read data from.
    /// - Throws: An error if decoding fails.
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        mealId = try container.decode(String.self, forKey: .mealId)
        name = try container.decode(String.self, forKey: .name)
        thumbnail = try container.decodeIfPresent(String.self, forKey: .thumbnail)
        area = try container.decodeIfPresent(String.self, forKey: .area)
        category = try container.decodeIfPresent(String.self, forKey: .category)
        instructions = try container.decodeIfPresent(String.self, forKey: .instructions)
        source = try container.decodeIfPresent(String.self, forKey: .source)
        youtubeLink = try container.decodeIfPresent(String.self, forKey: .youtubeLink)
        ingredientsMeasure = try decodeIngredientsMeasure(container: container)
    }
    
    /// Initializes a meal with specified properties.
    /// - Parameters:
    ///   - mealId: The unique identifier for the meal.
    ///   - name: The name of the meal.
    ///   - thumbnail: The URL string for the thumbnail image of the meal.
    ///   - area: The area or region where the meal originates from.
    ///   - category: The category or type of the meal.
    ///   - instructions: The instructions to prepare the meal.
    ///   - source: The source of the meal recipe.
    ///   - youtubeLink: The YouTube link for a video recipe of the meal.
    ///   - ingredientsMeasure: Dictionary containing ingredients and their respective measures for the meal.
    init(mealId: String? = nil, name: String? = nil, thumbnail: String? = nil, area: String? = nil, category: String? = nil, instructions: String? = nil, source: String? = nil, youtubeLink: String? = nil, ingredientsMeasure: [String : String]? = nil) {
        self.mealId = mealId
        self.name = name
        self.thumbnail = thumbnail
        self.area = area
        self.category = category
        self.instructions = instructions
        self.source = source
        self.youtubeLink = youtubeLink
        self.ingredientsMeasure = ingredientsMeasure
    }
    
    // MARK: - Private Methods
    /// Decodes ingredients and their respective measures from the decoder container.
    /// - Parameter container: The keyed decoding container.
    /// - Returns: A dictionary of ingredients and their measures, or nil if empty.
    private func decodeIngredientsMeasure(container: KeyedDecodingContainer<CodingKeys>) throws -> [String: String]? {
        var result = [String: String]()
        // Retrieves only the ingredients properties by filtering based on a prefix.
        let keys = container.allKeys.filter { $0.stringValue.hasPrefix("strIngredient") }
        for key in keys {
            // Gets the number from the ingredient represented, ex: "1" from strIngredient1.
            let ingredientNumber = key.stringValue.replacingOccurrences(of: "strIngredient", with: "")
            // After retrieving the number from the ingredient, fetch the measure property based on the same number.
            guard let measureKey = CodingKeys(rawValue: "strMeasure" + ingredientNumber) else {
                continue
            }
            // Check if able to find same ingredient and measure step.
            if let ingredient = try container.decodeIfPresent(String.self, forKey: key),
               let measure = try container.decodeIfPresent(String.self, forKey: measureKey) {
                // Add matching ingredient and measure to temporary array.
                result[ingredient] = measure
            }
        }
        return result.isEmpty ? nil : result
    }
    
}
