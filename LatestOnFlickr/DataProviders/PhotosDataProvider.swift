//
//  PhotosDataProvider.swift
//  LatestOnFlickr
//
//  Created by Antonio da Silva on 23/08/2017.
//  Copyright © 2017 TNTStudios. All rights reserved.
//

import Foundation
import UIKit

class PhotosDataProvider: NSObject, UITableViewDataSource {
    
    var photos: [Photo] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as? PhotoCell else {
            return UITableViewCell()
        }
        cell.configCell(with: photos[indexPath.row])
        return cell
    }
    
}
