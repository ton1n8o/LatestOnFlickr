//
//  PhotosViewController.swift
//  LatestOnFlickr
//
//  Created by Antonio da Silva on 23/08/2017.
//  Copyright © 2017 TNTStudios. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var dataProvider: (UITableViewDelegate & UITableViewDataSource)!
    
    lazy var api = APIClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = dataProvider
        tableView.delegate = dataProvider
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        api.loadPage(1) { (photo, error) in
            if let photosDataProvider = self.dataProvider as? PhotosDataProvider {
                photosDataProvider.photos = photo?.photo ?? [Photo]()
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
