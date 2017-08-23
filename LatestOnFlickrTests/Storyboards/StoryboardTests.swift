//
//  StoryboardTests.swift
//  LatestOnFlickrTests
//
//  Created by Antonio da Silva on 23/08/2017.
//  Copyright © 2017 TNTStudios. All rights reserved.
//

import XCTest
@testable import LatestOnFlickr

class StoryboardTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_Main_Storyboard_has_PhotosViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let viewController = storyboard.instantiateViewController(withIdentifier: "PhotosViewController")
        
        XCTAssertTrue(viewController is PhotosViewController)
    }
    
}
