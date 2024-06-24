//
//  ImageCache.swift
//  Fetch iOS Coding Challenge
//
//  Created by Josiah Agosto on 6/23/24.
//

import UIKit

class ImageCache {
    // MARK: - References / Properties
    static let shared = ImageCache()
    private let imageCache = NSCache<NSString, UIImage>()
    private init() { }
    
    func loadImage(url: String) async -> UIImage {
        guard !url.isEmpty else { return UIImage(systemName: "exclamationmark.triangle.fill")! }
        let imageCacheKey = url as NSString
        if let cachedImage = imageCache.object(forKey: imageCacheKey) {
            return cachedImage
        }
        do {
            guard let url = URL(string: url) else {
                throw URLError(.badURL)
            }
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw NSError(domain: "HTTPErrorDomain", code: (response as? HTTPURLResponse)?.statusCode ?? 0, userInfo: nil)
            }
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
