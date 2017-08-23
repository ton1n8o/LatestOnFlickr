//
//  APIClient.swift
//  LatestOnFlickr
//
//  Created by Antonio da Silva on 15/08/2017.
//  Copyright © 2017 TNTStudios. All rights reserved.
//

import Foundation

enum WebServiceError: Error {
    case dataEmptyError
    case responseError
}

class APIClient {
    
    lazy var session: SessionProtocol = URLSession.shared
    
    func loadPage(_ pageNum: Int, completion: @escaping (_ photos: Photos?, _ error: Error?) -> Void) {
        
        // REFACTORING HERE
//        var flickrUrl = Constants.flickr_services_endpoint + "?format=json"
//        flickrUrl += "&api_key=\(Constants.flickr_user_api_key)"
//        flickrUrl += "&method=\(Constants.flickr_service_getRecent)"
//        flickrUrl += "&nojsoncallback=1"
//        flickrUrl += "&extras=url_m,url_o,owner_name,views,date_taken"
//        flickrUrl += "&page=\(pageNum)"
        
        guard let url = (URL(string: buildBaseUrl(withPage: pageNum))) else {
            fatalError()
        }
        
        session.dataTask(with: url) { (data, urlResponse, error) in
            
            guard error == nil else {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, WebServiceError.dataEmptyError)
                return
            }
            
            do {
                let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject]
                var photos: Photos? = nil
                
                if let photosDict = dict?["photos"] as? [String: AnyObject] {
                    photos = Photos(usingDict: photosDict)
                }
                
                completion(photos, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
        
    }
}

extension APIClient {
    func buildBaseUrl(withPage: Int) -> String {
        var flickrUrl = Constants.flickr_services_endpoint + "?format=json"
        flickrUrl += "&api_key=\(Constants.flickr_user_api_key)"
        flickrUrl += "&method=\(Constants.flickr_service_getRecent)"
        flickrUrl += "&nojsoncallback=1"
        flickrUrl += "&extras=url_m,url_o,owner_name,views,date_taken"
        flickrUrl += "&page=\(withPage)"
        return flickrUrl
    }
}

protocol SessionProtocol {
    func dataTask(
        with url: URL,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: SessionProtocol {
    
}

