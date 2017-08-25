//
//  PhotoCellTests.swift
//  LatestOnFlickrTests
//
//  Created by Antonio da Silva on 25/08/2017.
//  Copyright © 2017 TNTStudios. All rights reserved.
//

import XCTest
@testable import LatestOnFlickr

class PhotoCellTests: XCTestCase {

    var sut: PhotoCell!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "PhotosViewController") as! PhotosViewController
        _ = controller.view
        
        let tableView = controller.tableView
        let dataSource = FakeDataSource()
        tableView?.dataSource = dataSource
        sut = tableView?.dequeueReusableCell(withIdentifier: "PhotoCell", for: IndexPath(row: 0, section: 0)) as! PhotoCell
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_HasUIComponents() {
        
        XCTAssertNotNil(sut.userNameLabel)
        XCTAssertNotNil(sut.photoImageView)
    }
    
    func test_ConfigCell_SetsUIElements() {
        sut.configCell(with: Photo(urlMedium: "", ownerName: "Foo"))
        
        XCTAssertEqual(sut.userNameLabel.text, "Foo")
//        XCTAssertNotNil(sut.photoImageView.image)
    }
    
}

// 1
extension PhotoCellTests {
    class FakeDataSource: NSObject, UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            return UITableViewCell()
        }
    }
}

