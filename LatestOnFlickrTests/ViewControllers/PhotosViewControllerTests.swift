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
        sut = nil
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
    
    func test_LoadPage_ShouldBeCalledOnce_When_OnViewDidLoad() {
        let api = MockAPIClient()
        sut.api = api
        sut.viewDidLoad()
        
        XCTAssertEqual(api.apiGotCalledOnce, 1, "on viewDidLoad APIClient must be called once.")
    }
    
    func test_LoadPage_When_PhotosNotEmpty_SetAdapter() {
        
        let photo = [
            Photo(urlMedium: "", ownerName: "")
        ]
        
        let api = MockAPIClient()
        api.photo = Photos(page: 1, perpage: 30, photo: photo)
        sut.api = api
        sut.viewDidLoad()
        
        let dataProvider = (sut.dataProvider as! PhotosDataProvider)
        XCTAssertEqual(dataProvider.photos.count, photo.count,
                       "dataProvider must have the at least \(photo.count) photo(s)")
    }

}


// 2
extension PhotosViewControllerTests {
    
    class MockAPIClient: APIClient {
        
        var photo: Photos?
        var apiGotCalledOnce = 0
        
        override func loadPage(_ pageNum: Int, completion: @escaping (Photos?, Error?) -> Void) {
            apiGotCalledOnce += 1
            completion(photo, nil)
        }
    }
    
}
