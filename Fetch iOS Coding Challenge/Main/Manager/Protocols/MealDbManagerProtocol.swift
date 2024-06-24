//
//  MealDbManagerProtocol.swift
//  Fetch iOS Coding Challenge
//
//  Created by Josiah Agosto on 6/24/24.
//

import Foundation

protocol MealDbManagerProtocol: AnyObject {
    func retrieveCategories(byName: String, completion: @escaping (Result<Data, Error>) -> Void)
}
