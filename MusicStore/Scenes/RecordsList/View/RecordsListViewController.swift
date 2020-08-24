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
    var loader: UIActivityIndicatorView!
    var safeArea: UILayoutGuide!
    
    // No storyboard or xib used, loadView creates the required UI for this scene
    override func loadView() {
        super.loadView()
        
        viewModel = RecordsListViewModelImplementation(view: self,
                                                       useCase: RecordsListUseCaseImplementation())
        
        view.backgroundColor = .white
        safeArea = view.layoutMarginsGuide
        
        navigationBarAppearance()
        setupTableView()
        setupNoFeedsView()
        setupLoader()
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewModel.viewDidLoad()
    }
    
    @objc func retry(_ sender: Any?) {
        viewModel.fetchList()
    }

}

// MARK:- Create UI
extension RecordsListViewController {
    
    func navigationBarAppearance() {
        self.title = "My Music"
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.backgroundColor = .systemGreen
            navigationController?.navigationBar.standardAppearance = navBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        } else {
            navigationController?.navigationBar.barTintColor = .systemGreen
            navigationController?.navigationBar.tintColor = .white
            navigationController?.navigationBar.isTranslucent = false
            navigationItem.title = title
        }
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        
        tableView.register(RecordsTableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func setupLoader() {
        if #available(iOS 13.0, *) {
            loader = UIActivityIndicatorView(style: .large)
        } else {
            loader = UIActivityIndicatorView(style: .gray)
        }
        loader.center = self.view.center
        loader.hidesWhenStopped = true
        view.addSubview(loader)
    }
    
    func setupNoFeedsView() {
        let container = UIView()
        view.addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        var constraints = [
            container.topAnchor.constraint(equalTo: safeArea.topAnchor),
            container.leftAnchor.constraint(equalTo: view.leftAnchor),
            container.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            container.rightAnchor.constraint(equalTo: view.rightAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "noResults")
        container.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        constraints = [
            imageView.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.5),
            imageView.centerYAnchor.constraint(equalTo: container.centerYAnchor, constant: -60),
            imageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            imageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20)
        ]
        NSLayoutConstraint.activate(constraints)
        
        let label = UILabel()
        label.text = "No results found"
        label.font = UIFont.boldSystemFont(ofSize: 26)
        label.textColor = .systemPink
        container.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        constraints = [
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            label.centerXAnchor.constraint(equalTo: imageView.centerXAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 80, height: 46))
        button.setTitle("Try again", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.showsTouchWhenHighlighted = true
        button.addTarget(self, action: #selector(retry(_:)), for: .touchDownRepeat)
        container.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        constraints = [
            button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            button.centerXAnchor.constraint(equalTo: label.centerXAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        
        
        noResultsView = container
        noResultsView.isHidden = true
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RecordsTableViewCell
        viewModel.configure(cell: cell, for: indexPath)
        return cell
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
}
