//
//  PhotosDataProviderTests.swift
//  LatestOnFlickrTests
//
//  Created by Antonio da Silva on 24/08/2017.
//  Copyright © 2017 TNTStudios. All rights reserved.
//

import XCTest
@testable import LatestOnFlickr

class PhotosDataProviderTests: XCTestCase {
    
    var sut: PhotosDataProvider!
    var tableView: UITableView!
    
    // 7
    var controller: PhotosViewController!
    
    override func setUp() {
        super.setUp()

        // 7
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        controller = storyboard.instantiateViewController(withIdentifier: "PhotosViewController") as! PhotosViewController
        _ = controller.view

        sut = PhotosDataProvider()
        tableView = controller.tableView
        tableView.dataSource = sut
        
//        sut = PhotosDataProvider()
//        tableView = UITableView()
//        tableView.dataSource = sut
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // 1
    func test_Number_of_Sections_is_One() {
        let numberOfSection = tableView.numberOfSections
        XCTAssertEqual(numberOfSection, 1)
    }
    
    // 2
    func test_Has_Empty_Photos_Array() {
        XCTAssertTrue(sut.photos.isEmpty)
    }
    
    // 3
    func test_Number_of_Rows_is_Equal_TheNumber_Of_PhotosArray() {
        sut.photos.append(Photo(urlMedium: "Foo", ownerName: "Boo"))
        tableView.reloadData()
        
        let numberOfRows = tableView.numberOfRows(inSection: 0)
        XCTAssertEqual(numberOfRows, 1)
    }
    
    // 4
    func test_CellForRow_Returns_PhotoCell() {
        tableView.register(MockPhotoCell.self, forCellReuseIdentifier: "PhotoCell")
        sut.photos.append(Photo(urlMedium: "", ownerName: "Boo"))
        tableView.reloadData()
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0))
        XCTAssertTrue(cell is PhotoCell)
    }
    
    // 6
    func test_CellForRow_DequeuesCellFromTableView() {
        let mockTableView = MockTableView()
        mockTableView.dataSource = sut
        mockTableView.register(MockPhotoCell.self, forCellReuseIdentifier: "PhotoCell")
        
        sut.photos.append(Photo(urlMedium: "my url", ownerName: "Boo"))
        mockTableView.reloadData()
        
        _ = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0))
        
        XCTAssertEqual(mockTableView.cellGotDequeuedOnce, 1)
    }
    
    // 9
    func test_CellForRow_Calls_ConfigCell() {
        let mockTableView = MockTableView()
        mockTableView.dataSource = sut
        mockTableView.register(MockPhotoCell.self, forCellReuseIdentifier: "PhotoCell")
        let photo = Photo(urlMedium: "", ownerName: "Boo")
        sut.photos.append(photo)
        mockTableView.reloadData()
        
        let cell = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! MockPhotoCell
        
        // 10 REPLACE
        XCTAssertEqual(cell.configCellGotCalledOnce, 1)
        
        // 10 WITH
        XCTAssertEqual(cell.catchedPhoto, photo) // equatable
    }
}

// 5
extension PhotosDataProviderTests {
    class MockTableView: UITableView {
        var cellGotDequeuedOnce = 0
        override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
            cellGotDequeuedOnce += 1
            return super.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        }
    }
    
    // 8
    class MockPhotoCell: PhotoCell {
        // 10 REMOVE
        var configCellGotCalledOnce = 0
        // 10 ADD
        var catchedPhoto: Photo?
        override func configCell(with photo: Photo) {
            // 10 REMOVE
            configCellGotCalledOnce += 1
            // 10 ADD
            catchedPhoto = photo
        }
    }
}
