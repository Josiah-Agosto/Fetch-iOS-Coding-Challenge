//
//  ImageCacheTests.swift
//  Fetch iOS Coding Challenge Tests
//
//  Created by Josiah Agosto on 6/24/24.
//

import XCTest
import UIKit

class ImageCacheTests: XCTestCase {
    // MARK: - References / Properties
    var sut: MockImageCache!
    
    override func setUp() {
        super.setUp()
        sut = MockImageCache()
    }
    
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    
    func testNewImageCached() async {
        let imageUrlString = "https://example.com/image.jpg"
        let image = await sut.loadImage(url: imageUrlString)
        XCTAssertEqual(image, UIImage(systemName: "checkmark"))
    }
    
    
    func testInvalidUrl() async {
        let imageUrlString = ""
        let image = await sut.loadImage(url: imageUrlString)
        XCTAssertEqual(image, UIImage(systemName: "exclamationmark.triangle.fill"))
    }
    
}
