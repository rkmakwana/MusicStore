//
//  RecordsListViewController.swift
//  MusicStore
//
//  Created by Rashmikant Makwana on 24/08/20.
//  Copyright © 2020 Rashmikant Makwana. All rights reserved.
//

import UIKit

class RecordsListViewController: UIViewController {
    
    var viewModel: RecordsListViewModel!
    
    let tableView = UITableView()
    var noResultsView: UIView!
    var footer: UIView!
    var pickerContainer: UIView!
    
    var sortByLbl: UILabel!
    var loader: UIActivityIndicatorView!
    var safeArea: UILayoutGuide!
    var searchController: UISearchController!
    
    let cellIdentifier = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewModel.viewDidLoad()
    }
    
    @objc func retry(_ sender: Any?) {
        viewModel.fetchList()
    }
    
    @objc func changeSortOption(_ sender: Any?) {
        pickerContainer.isHidden = false
    }

    @objc func dismissPicker() {
        pickerContainer.isHidden = true
    }
}

//MARK:- UISearchControl update
extension RecordsListViewController: UISearchResultsUpdating, UISearchControllerDelegate {
    
    func didPresentSearchController(_ searchController: UISearchController) {
        viewModel.setSearch(active: true)
        reloadTable()
        footer.isHidden = true
    }
    
    func didDismissSearchController(_ searchController: UISearchController) {
        viewModel.setSearch(active: false)
        reloadTable()
        footer.isHidden = false
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let key = searchController.searchBar.text {
            viewModel.search(for: key.trimmingCharacters(in: .whitespaces))
        }
    }
    
}

// MARK:- UITableView Datasource and Delegate
extension RecordsListViewController: UITableViewDataSource, UITableViewDelegate {
    
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
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RecordsTableViewCell
        viewModel.select(cell: cell, for: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadRows(at: [indexPath], with: .fade)
    }
    
}

// MARK:- Sort order
extension RecordsListViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.totalSortOptions
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.sortOption(at: row)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        viewModel.changeSortOption(index: row)
        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    }

}

// MARK:- FeedsView
extension RecordsListViewController: RecordsListView {
    
    func reloadTable() {
        tableView.reloadData()
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay",
                                      style: .default,
                                      handler: nil))
        self.present(alert, animated: true)
    }
    
    func showLoader() {
        loader.startAnimating()
    }
    
    func hideLoader() {
        loader.stopAnimating()
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
    
    func updateSortOption() {
        sortByLbl.text = "Sorted by: \(viewModel.sortOption)"
    }
}
