//
//  JSONParserHelperTest.swift
//  LatestOnFlickrTests
//
//  Created by Antonio da Silva on 22/08/2017.
//  Copyright © 2017 TNTStudios. All rights reserved.
//

import XCTest
@testable import LatestOnFlickr

class JSONParserHelperTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_ParsePhotos_From_Dict_Returns_ArryaOfPhotos() {
        let dictPhotos = JSONLoader.loadJSONFrom(file: "photo_array", usingClass: self)
        
        guard let dictPh = dictPhotos else {
            XCTFail("a photos.json file is needed to proceed with this test.")
            return
        }
        
        let photos = JSONParserHelper.parsePhotos(dictPh)
        XCTAssertFalse(photos.isEmpty)
    }
    
    
    
}
