//
//  Photo.swift
//  LatestOnFlickr
//
//  Created by Antonio da Silva on 18/08/2017.
//  Copyright © 2017 TNTStudios. All rights reserved.
//

import Foundation

struct Photo : Equatable {
    
    let urlMedium: String
    let ownerName: String
    
    init(urlMedium: String, ownerName: String) {
        self.urlMedium = urlMedium
        self.ownerName = ownerName
    }
    
    init (dict: [String: AnyObject]) {
        self.urlMedium = JSONParserHelper.parseString(dict["url_m"])
        self.ownerName = JSONParserHelper.parseString(dict["ownername"])
    }
    
}

extension Photo {
    static func ==(lhs: Photo, rhs: Photo) -> Bool {
        if lhs.urlMedium != rhs.urlMedium {
            return false
        }
        if lhs.ownerName != rhs.ownerName {
            return false
        }
        return true
    }
}
