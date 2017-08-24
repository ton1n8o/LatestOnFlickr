//
//  PhotoTests.swift
//  LatestOnFlickrTests
//
//  Created by Antonio da Silva on 22/08/2017.
//  Copyright © 2017 TNTStudios. All rights reserved.
//

import XCTest
@testable import LatestOnFlickr

class PhotoTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_Init_With_Dict_Set_AllProperties() {
        
        let dictPhoto = JSONLoader.loadJSONFrom(file: "photo", usingClass: self)
        
        guard let dict = dictPhoto else {
            XCTFail("a photo.json file is needed to proceed with this test.")
            return
        }
        
        let photo = Photo(dict: dict)
        
        XCTAssertEqual(photo.urlMedium, "https://farm5.staticflickr.com/4438/35891687574_08ee950eef.jpg")
        XCTAssertEqual(photo.ownerName, "VirtualFtness")
    }
    
    func test_Init_Set_All_Properties() {
        let photo = Photo(urlMedium: "url", ownerName: "Foo")
        
        XCTAssertEqual(photo.urlMedium, "url")
        XCTAssertEqual(photo.ownerName, "Foo")
    }
    
    //10
    func test_When_URLMedium_Different_AreNotEqual() {
        let photoA = Photo(urlMedium: "URL", ownerName: "")
        let photoB = Photo(urlMedium: "", ownerName: "")
        
        XCTAssertNotEqual(photoA, photoB)
    }
    
    func test_When_OwnerName_Different_AreNotEqual() {
        let photoA = Photo(urlMedium: "", ownerName: "Foo")
        let photoB = Photo(urlMedium: "", ownerName: "Bar")
        
        XCTAssertNotEqual(photoA, photoB)
    }
}
