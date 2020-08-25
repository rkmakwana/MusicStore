//
//  RecordsListUILayout.swift
//  MusicStore
//
//  Created by Rashmikant Makwana on 25/08/20.
//  Copyright © 2020 Rashmikant Makwana. All rights reserved.
//

import Foundation
import UIKit

// MARK:- Create UI
extension RecordsListViewController {
    
    // No storyboard or xib used, keeping the view controller lean.
    // Creating the UI and binding it using loadView() in this file seperately.
    
    
    override func loadView() {
        super.loadView()
        
        viewModel = RecordsListViewModelImplementation(view: self,
                                                       useCase: RecordsListUseCaseImplementation())
        
        view.backgroundColor = .white
        safeArea = view.layoutMarginsGuide
        
        navigationBarAppearance()
        setupFooter()
        setupTableView()
        setupSearchControl()
        setupNoFeedsView()
        setupLoader()
        setupPickerView()
    }
    
    func navigationBarAppearance() {
        self.title = AppConstants.title
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
        navigationController?.navigationBar.tintColor = .white
        
        cartNavBarButtonItem = UIBarButtonItem(title: "Cart",
                                               style: .plain,
                                               target: self,
                                               action: #selector(cartBtnAction(_:)))
        cartNavBarButtonItem.tintColor = .white
        cartNavBarButtonItem.title = "Cart"
        navigationItem.rightBarButtonItem = cartNavBarButtonItem
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: footer.topAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        
        tableView.register(RecordsTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
        // Bring footer in front so the navigation bar hides on scroll
        view.bringSubviewToFront(footer)
    }
    
    func setupFooter() {
        footer = UIView()
        footer.backgroundColor = .opaqueSeparator
        view.addSubview(footer)
        footer.translatesAutoresizingMaskIntoConstraints = false
        var constraints = [
            footer.leftAnchor.constraint(equalTo: view.leftAnchor),
            footer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            footer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            footer.heightAnchor.constraint(equalToConstant: 42)
        ]
        NSLayoutConstraint.activate(constraints)
        
        sortByLbl = UILabel()
        footer.addSubview(sortByLbl)
        sortByLbl.font = .boldSystemFont(ofSize: 13)
        sortByLbl.translatesAutoresizingMaskIntoConstraints = false
        constraints = [
            sortByLbl.leftAnchor.constraint(equalTo: footer.leftAnchor, constant: 12),
            sortByLbl.centerYAnchor.constraint(equalTo: footer.centerYAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        
        let changeBtn = UIButton()
        changeBtn.setTitle("Change", for: .normal)
        changeBtn.titleLabel?.font = .boldSystemFont(ofSize: 13)
        changeBtn.setTitleColor(.systemBlue, for: .normal)
        changeBtn.addTarget(self, action: #selector(changeSortOption(_:)), for: .touchUpInside)
        footer.addSubview(changeBtn)
        changeBtn.translatesAutoresizingMaskIntoConstraints = false
        constraints = [
            changeBtn.trailingAnchor.constraint(equalTo: footer.trailingAnchor, constant: -12),
            changeBtn.centerYAnchor.constraint(equalTo: footer.centerYAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
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
    
    func setupSearchControl() {
        searchController = UISearchController()
        searchController.searchBar.searchBarStyle = .prominent
        searchController.searchBar.tintColor = .white
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
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
        imageView.image = UIImage(named: ImageNames.noRecords)
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
        button.addTarget(self, action: #selector(retry(_:)), for: .touchUpInside)
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
    
    func setupPickerView() {
        let container = UIView()
        view.addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        container.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        container.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        container.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.backgroundColor = .systemGroupedBackground
        picker.delegate = self
        picker.dataSource = self

        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                    target: self,
                                    action: nil)
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done,
                                  target: self,
                                  action: #selector(dismissPicker))
        let toolbar = UIToolbar(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 44.0)))
        toolbar.barStyle = .default
        toolbar.isTranslucent = false
        toolbar.items = [space, doneBtn]
        
        container.addSubview(toolbar)
        container.addSubview(picker)
        
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        picker.translatesAutoresizingMaskIntoConstraints = false
        
        var constraints = [
            toolbar.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            toolbar.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            toolbar.topAnchor.constraint(equalTo: container.topAnchor)
        ]
        NSLayoutConstraint.activate(constraints)

        constraints = [
            picker.topAnchor.constraint(equalTo: toolbar.bottomAnchor),
            picker.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            picker.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            picker.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        
        pickerContainer = container
        pickerContainer.isHidden = true
    }
    
}
