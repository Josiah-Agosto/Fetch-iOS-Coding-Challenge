//
//  LoggerExtension.swift
//  Fetch iOS Coding Challenge
//
//  Created by Josiah Agosto on 6/24/24.
//

import Foundation
import os.log

extension Logger {
    // MARK: - References / Properties
    private static let appIdentifier = Bundle.main.bundleIdentifier ?? "com.fetch-ios-challenge"
    static let main = Logger(subsystem: appIdentifier, category: "main")
    
}
