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
    /// System Under Test (SUT): The instance of `MockImageCache` being tested.
    var sut: MockImageCache!
    
    override func setUp() {
        super.setUp()
        sut = MockImageCache()
    }
    
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    /// Tests that a new image is cached successfully.
    func testNewImageCached() async {
        let imageUrlString = "https://example.com/image.jpg"
        let image = await sut.loadImage(url: imageUrlString)
        XCTAssertEqual(image, UIImage(systemName: "checkmark"))
    }
    
    /// Tests that an invalid URL returns the expected error image.
    func testInvalidUrl() async {
        let imageUrlString = ""
        let image = await sut.loadImage(url: imageUrlString)
        XCTAssertEqual(image, UIImage(systemName: "exclamationmark.triangle.fill"))
    }
    
}
