//
//  PhotoCell.swift
//  LatestOnFlickr
//
//  Created by Antonio da Silva on 24/08/2017.
//  Copyright © 2017 TNTStudios. All rights reserved.
//

import UIKit
import Kingfisher

class PhotoCell: UITableViewCell {
    
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var photoImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configCell(with photo: Photo) {
        userNameLabel.text = photo.ownerName
        let url = URL(string: photo.urlMedium)
        photoImageView.kf.setImage(with: url)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
