//
//  JSONParserHelper.swift
//  LatestOnFlickr
//
//  Created by Antonio da Silva on 22/08/2017.
//  Copyright © 2017 TNTStudios. All rights reserved.
//

import Foundation

struct JSONParserHelper {
    
    private init() {}
    
    static func parsePhotos(_ dict : [String : AnyObject]) -> [Photo] {
        
        var photos = [Photo]()
        
        guard let dictPhotos = dict["photo"] as? [[String: AnyObject]] else {
            return photos
        }
        
        for dict in dictPhotos {
            photos.append(Photo(dict: dict))
        }
        
        return photos
    }
    
    static func parseString(_ str: AnyObject?) -> String {
        guard let str = str as? String else {
            return ""
        }
        return str
    }
}
