//
//  MealDetailViewModelProtocol.swift
//  Fetch iOS Coding Challenge
//
//  Created by Josiah Agosto on 6/24/24.
//

import Foundation
import UIKit

protocol MealDetailViewModelProtocol {
    var meal: Meal { get }
    var thumbnailImage: UIImage? { get }
    func retrieveMealDetails(byId: String)
    func loadImage()
}
