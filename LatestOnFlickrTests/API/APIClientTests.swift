//
//  APIClientTests.swift
//  LatestOnFlickrTests
//
//  Created by Antonio da Silva on 15/08/2017.
//  Copyright © 2017 TNTStudios. All rights reserved.
//

import XCTest
@testable import LatestOnFlickr

class APIClientTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // 1
    func test_apiClient_Uses_Proper_Flickr_URL() {
        
        let sut = APIClient()
        
        let mockURLSession = MockURLSession.init(data: nil, urlResponse: nil, error: nil)
        sut.session = mockURLSession
        let page = 1
        
        let completion = {(photos: Photos?, error: Error?) in }
        sut.loadPage(page, completion: completion)
        
        guard let url = mockURLSession.url else {
            XCTFail(); return
        }
        
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
        XCTAssertEqual(urlComponents?.host, "api.flickr.com")
        
        XCTAssertEqual(urlComponents?.path, "/services/rest")
        
        let jsonItem = URLQueryItem.init(name: "format", value: "json")
        let apiKeyItem = URLQueryItem.init(name: "api_key", value: Constants.flickr_user_api_key)
        let methodItem = URLQueryItem.init(name: "method", value: Constants.flickr_service_getRecent)
        let noJsonCallbackItem = URLQueryItem.init(name: "nojsoncallback", value: "1")
        let extrasItem = URLQueryItem.init(name: "extras", value: "url_m,url_o,owner_name,views,date_taken")
        let pageItem = URLQueryItem.init(name: "page", value: "\(page)")
        
        XCTAssertTrue(urlComponents?.queryItems?.contains(jsonItem) ?? false)
        XCTAssertTrue(urlComponents?.queryItems?.contains(apiKeyItem) ?? false)
        XCTAssertTrue(urlComponents?.queryItems?.contains(methodItem) ?? false)
        XCTAssertTrue(urlComponents?.queryItems?.contains(noJsonCallbackItem) ?? false)
        XCTAssertTrue(urlComponents?.queryItems?.contains(extrasItem) ?? false)
        XCTAssertTrue(urlComponents?.queryItems?.contains(pageItem) ?? false)
        
        // https://api.flickr.com/services/rest/?
        // format=json&
        // nojsoncallback=1&
        // api_key=e642c34c6ac8532ef77a7ec1c221babc
        // &method=flickr.photos.getRecent&
        // extras=url_m,url_o,owner_name,views,date_taken
        // &page=2
        // &per_page=30
        
    }
    
    // 2
    func test_LoadPageReturnsPhotosModel() {
        
        let sut = APIClient()
        let jsonData = returnsJsonPayload().data(using: .utf8)
        
        let mockUrlSession = MockURLSession.init(data: jsonData, urlResponse: nil, error: nil)
        sut.session = mockUrlSession
        let photosExpectation = expectation(description: "Photos")
        var catchedPhotos: Photos? = nil
        sut.loadPage(1) { (photos, error) in
            catchedPhotos = photos
            photosExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1) { (error) in
            XCTAssertEqual(catchedPhotos?.page, 1)
        }
    }
    
    // 3
    func test_WhenLoadsPageWithInvalidJson_ReturnsError() {
        
        let sut = APIClient()
        let mockUrlSession = MockURLSession.init(data: Data(), urlResponse: nil, error: nil)
        
        sut.session = mockUrlSession
        
        let errorExpectation = expectation(description: "Error")
        var catchedError: Error? = nil
        sut.loadPage(1) { (photos, error) in
            catchedError = error
            errorExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1) { (error) in
            XCTAssertNotNil(catchedError)
        }
    }
    
    // 4
    func test_WhenLoadsPageWithDataNil_ReturnsError() {
        
        let sut = APIClient()
        let mockUrlSession = MockURLSession(data: nil, urlResponse: nil, error: nil)
        
        sut.session = mockUrlSession
        let errorExpectation = expectation(description: "Error")
        var catchedError: Error? = nil
        sut.loadPage(1) { (photos, error) in
            catchedError = error
            errorExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1) { (error) in
            XCTAssertNotNil(catchedError)
        }
    }
    
    // 5
    func test_LoadPageWhenResponseHasError_ReturnsError() {
        
        let sut = APIClient()
        let error = NSError(domain: "SomeError", code: 1234, userInfo: nil)
        let jsonData = returnsJsonPayload().data(using: .utf8)
        let mockUrlSession = MockURLSession(data: jsonData, urlResponse: nil, error: error)
        
        sut.session = mockUrlSession
        let errorExpectation = expectation(description: "Error")
        var catchedError: Error? = nil
        sut.loadPage(1) { (photos, error) in
            catchedError = error
            errorExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1) { (error) in
            XCTAssertNotNil(catchedError)
        }
    }
    
}

extension APIClientTests {
    
    class MockURLSession : SessionProtocol {
        var url: URL?
        private let dataTask: MockTask
        
        init(data: Data?, urlResponse: URLResponse?, error: Error?) {
            dataTask = MockTask.init(data: data, urlResponse: urlResponse, error: error)
        }
        
        func dataTask(
            with url: URL,
            completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            self.url = url
            dataTask.completionHandler = completionHandler
            return dataTask
        }
    }
    
    class MockTask: URLSessionDataTask {
        private let data: Data?
        private let urlResponse: URLResponse?
        private let responseError: Error?
        
        typealias completionHandler = (Data?, URLResponse?, Error?) -> Void
        
        var completionHandler: completionHandler?
        
        init(data: Data?, urlResponse: URLResponse?, error: Error?) {
            self.data = data
            self.urlResponse = urlResponse
            self.responseError = error
        }
        
        override func resume() {
            DispatchQueue.main.async {
                self.completionHandler?(self.data, self.urlResponse, self.responseError)
            }
        }
    }
    
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
