//
//  ImageCacheProtocol.swift
//  Fetch iOS Coding Challenge
//
//  Created by Josiah Agosto on 6/24/24.
//

import UIKit

protocol ImageCacheProtocol: AnyObject {
    func loadImage(url: String) async -> UIImage
}
