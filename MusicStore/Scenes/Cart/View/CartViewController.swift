//
//  CartViewController.swift
//  MusicStore
//
//  Created by Rashmikant Makwana on 26/08/20.
//  Copyright © 2020 Rashmikant Makwana. All rights reserved.
//

import UIKit

class CartViewController: UIViewController, CartView {
    
    var viewModel: CartViewModel!
    
    let tableView = UITableView()
    var noResultsView: UIView!
    var safeArea: UILayoutGuide!
    
    let cellIdentifier = "cell"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewModel.viewDidLoad()
    }
    
    func reloadTable() {
        tableView.reloadData()
    }
    
    func displayNoResultsView(status: Bool) {
        // If true, show no results view and hide table view, otherwise inverse
        if status {
            noResultsView.isHidden = false
            tableView.isHidden = true
        } else {
            noResultsView.isHidden = true
            tableView.isHidden = false
        }
    }
}

// MARK:- UITableView Datasource and Delegate
extension CartViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RecordsTableViewCell
        viewModel.configure(cell: cell, for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
