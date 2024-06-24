//
//  LoggerExtension.swift
//  Fetch iOS Coding Challenge
//
//  Created by Josiah Agosto on 6/24/24.
//

import Foundation
import os.log

/// Extension to Logger to define a main logger for the app.
extension Logger {
    
    /// Bundle identifier to use as subsystem for logging.
    private static let appIdentifier = Bundle.main.bundleIdentifier ?? "com.fetch-ios-challenge"
    /// Singleton instance of the main logger.
    static let main = Logger(subsystem: appIdentifier, category: "main")
    
}
