//
//  Meal.swift
//  Fetch iOS Coding Challenge
//
//  Created by Josiah Agosto on 6/21/24.
//

import Foundation

struct Meal: Decodable {
    let mealId: String?
    let name: String?
    let thumbnail: String?
    let area: String?
    let category: String?
    let instructions: String?
    let source: String?
    let youtubeLink: String?
    var ingredientsMeasure: [String: String]?
    
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
    
    private func decodeIngredientsMeasure(container: KeyedDecodingContainer<CodingKeys>) throws -> [String: String]? {
        var result = [String: String]()
        let keys = container.allKeys.filter { $0.stringValue.hasPrefix("strIngredient") }
        for key in keys {
            let ingredientNumber = key.stringValue.replacingOccurrences(of: "strIngredient", with: "")
            guard let measureKey = CodingKeys(rawValue: "strMeasure" + ingredientNumber) else {
                continue
            }
            if let ingredient = try container.decodeIfPresent(String.self, forKey: key),
               let measure = try container.decodeIfPresent(String.self, forKey: measureKey) {
                result[ingredient] = measure
            }
        }
        return result.isEmpty ? nil : result
    }
    
}
