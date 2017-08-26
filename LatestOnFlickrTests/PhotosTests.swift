//
//  PhotosTests.swift
//  LatestOnFlickrTests
//
//  Created by Antonio da Silva on 18/08/2017.
//  Copyright © 2017 TNTStudios. All rights reserved.
//

import XCTest
@testable import LatestOnFlickr

class PhotosTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_InitGivenAndJSONDictionary_ReturnsPhotosModel_ProperlySet() {
        let data = returnsJsonPayload().data(using: .utf8)!
        
        let dict = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: AnyObject]
        
        let dictPhotos = dict["photos"] as! [String : AnyObject]
        let photos = Photos(usingDict: dictPhotos)
        
        XCTAssertEqual(photos.page, 1)
        XCTAssertEqual(photos.perpage, 30)
        XCTAssertEqual(photos.photo.count, 1)
        
    }
    
    func test_Init_Set_AllProperties() {
        let photos = Photos(page: 1, perpage: 30, photo: [Photo]())
        
        XCTAssertEqual(photos.page, 1)
        XCTAssertEqual(photos.perpage, 30)
        XCTAssertTrue(photos.photo.isEmpty)
    }
    
}

extension PhotosTests {
    
    func returnsJsonPayload() -> String {
        return "{" +
            "   \"photos\":{" +
            "      \"page\":1," +
            "      \"pages\":34," +
            "      \"perpage\":30," +
            "      \"total\":1000," +
            "      \"photo\":[" +
            "         {" +
            "            \"id\":\"35785078814\"," +
            "            \"owner\":\"149689227@N03\"," +
            "            \"secret\":\"946905eb0f\"," +
            "            \"server\":\"4369\"," +
            "            \"farm\":5," +
            "            \"title\":\"Ashley Miami Trip_588.jpg\"," +
            "            \"ispublic\":1," +
            "            \"isfriend\":0," +
            "            \"isfamily\":0," +
            "            \"datetaken\":\"2017-08-13 19:57:47\"," +
            "            \"datetakengranularity\":\"0\"," +
            "            \"datetakenunknown\":\"0\"," +
            "            \"ownername\":\"amurrell84\"," +
            "            \"views\":\"0\"," +
            "            \"url_m\":\"https://farm5.staticflickr.com/4369/35785078814_946905eb0f.jpg\"," +
            "            \"height_m\":\"500\"," +
            "            \"width_m\":\"333\"" +
            "         }" +
            "      ]" +
            "   }" +
        "}"
    }
}
