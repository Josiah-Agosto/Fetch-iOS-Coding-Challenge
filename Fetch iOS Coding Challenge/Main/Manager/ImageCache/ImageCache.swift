//
//  ImageCache.swift
//  Fetch iOS Coding Challenge
//
//  Created by Josiah Agosto on 6/23/24.
//

import UIKit

/// Singleton class responsible for caching images fetched from URLs.
final class ImageCache: ImageCacheProtocol {
    // MARK: - References / Properties
    /// Shared singleton instance of ImageCache.
    static let shared = ImageCache()
    /// NSCache instance to store cached images.
    private let imageCache = NSCache<NSString, UIImage>()
    
    /// Private initializer to prevent outside initialization.
    private init() { }
    
    // MARK: - Public Methods
    /// Asynchronously loads an image from the given URL and caches it.
    /// - Parameter url: The URL string of the image to load.
    /// - Returns: The loaded image or a default image if loading fails.
    func loadImage(url: String) async -> UIImage {
        // Checks if URL is empty to then provide a default image.
        guard !url.isEmpty else { return UIImage(systemName: "exclamationmark.triangle.fill")! }
        let imageCacheKey = url as NSString
        // Checks if image URL has already been used.
        if let cachedImage = imageCache.object(forKey: imageCacheKey) {
            return cachedImage
        }
        do {
            guard let url = URL(string: url) else {
                throw URLError(.badURL)
            }
            let (data, response) = try await URLSession.shared.data(from: url)
            // Checks if response is 200.
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw NSError(domain: "HTTPErrorDomain", code: (response as? HTTPURLResponse)?.statusCode ?? 0, userInfo: nil)
            }
            // Creates new image and then adds it to the cache.
            guard let image = UIImage(data: data) else {
                throw NSError(domain: "UIImageErrorDomain", code: 0, userInfo: nil)
            }
            self.imageCache.setObject(image, forKey: imageCacheKey)
            return image
        } catch {
            return UIImage(systemName: "exclamationmark.triangle.fill")!
        }
    }
    
}
