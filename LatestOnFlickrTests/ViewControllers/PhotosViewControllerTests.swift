//
//  PhotosViewControllerTests.swift
//  LatestOnFlickrTests
//
//  Created by Antonio da Silva on 23/08/2017.
//  Copyright © 2017 TNTStudios. All rights reserved.
//

import XCTest
@testable import LatestOnFlickr

class PhotosViewControllerTests: XCTestCase {
    
    var sut: PhotosViewController!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "PhotosViewController") as! PhotosViewController
        _ = sut.view
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_PhotosViewController_OnViewDidLoad_Instanteate_TableView() {
        XCTAssertNotNil(sut.tableView)
    }
    
    func test_LoadingView_Sets_TableViewDataSource() {
        XCTAssertTrue(sut.tableView.dataSource is PhotosDataProvider)
    }
    
    func test_LoadingView_Sets_TableViewDelegate() {
        XCTAssertTrue(sut.tableView.delegate is PhotosDataProvider)
    }
    
    // 1
    func test_ViewWillAppear_GotCalled() {
        let api = MockAPI()
        sut.api = api
        sut.beginAppearanceTransition(true, animated: true)
        sut.endAppearanceTransition()
        
        XCTAssertTrue(api.apiGotCalled)
    }
    
//    // 2
//    func test_ViewWillAppear_FillsDataProvider() {
//        let api = MockAPI()
//        sut.api = api
//        sut.beginAppearanceTransition(true, animated: true)
//        sut.endAppearanceTransition()
//        
//        XCTAssertTrue(api.apiGotCalled)
//    }
    
}


// 2
extension PhotosViewControllerTests {
    
    class MockAPI: APIClient {
        
        var apiGotCalled = false
        
        override func loadPage(_ pageNum: Int, completion: @escaping (Photos?, Error?) -> Void) {
            apiGotCalled = true
        }
    }
}
