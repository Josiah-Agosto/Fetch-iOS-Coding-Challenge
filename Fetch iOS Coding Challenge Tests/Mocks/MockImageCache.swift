//
//  MockImageCache.swift
//  Fetch iOS Coding Challenge Tests
//
//  Created by Josiah Agosto on 6/24/24.
//

@testable import Fetch_iOS_Coding_Challenge
import UIKit

/// Mock implementation of `ImageCache` for testing purposes.
class MockImageCache: ImageCacheProtocol {
    // MARK: - References / Properties
    /// Contains all mock references to the URL and UIImage.
    private var imageCache = [String: UIImage]()
    
    // MARK: - Public Methods
    /// Mock function to load an image from the given URL and cache it.
    /// - Parameter url: The URL string of the image to load.
    /// - Returns: The loaded image or a default image if loading fails.
    func loadImage(url: String) async -> UIImage {
        // Checks if URL is empty to then provide a default image.
        guard !url.isEmpty else { return UIImage(systemName: "exclamationmark.triangle.fill")! }
        // Checks if image URL has already been used.
        if let cachedImage = imageCache[url] {
            return cachedImage
        }
        // If a new url just set a default checkmark image for all.
        let mockImage = UIImage(systemName: "checkmark")!
        imageCache[url] = mockImage
        return mockImage
    }
    
}
