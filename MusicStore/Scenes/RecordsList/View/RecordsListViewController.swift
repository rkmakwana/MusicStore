//
//  RecordsListViewController.swift
//  MusicStore
//
//  Created by Rashmikant Makwana on 24/08/20.
//  Copyright © 2020 Rashmikant Makwana. All rights reserved.
//

import UIKit

class RecordsListViewController: UIViewController, RecordsListView {
    
    var viewModel: RecordsListViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        
        viewModel.viewDidLoad()
    }

}
