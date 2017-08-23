//
//  Photos.swift
//  LatestOnFlickr
//
//  Created by Antonio da Silva on 15/08/2017.
//  Copyright © 2017 TNTStudios. All rights reserved.
//

import Foundation

struct Photos {
    
    let page: Int
    let perpage: Int
    let photo: [Photo]
    
    init(usingDict dict: [String: AnyObject]) {
        self.page = dict["page"] as! Int
        self.perpage = dict["perpage"] as! Int
        self.photo = JSONParserHelper.parsePhotos(dict)
    }
    
}
