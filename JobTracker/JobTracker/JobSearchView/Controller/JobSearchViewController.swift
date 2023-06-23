//
//  JobSearchViewController.swift
//  JobTracker
//
//  Created by Caroline Frey on 6/15/23.
//

import UIKit

class JobSearchViewController: UIViewController {
    
    // MARK: - UI Properties
    
    private var contentView = JobSearchView()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = contentView
        setDelegates()
//        configure()
    }
    
    // MARK: - Functions
    
    private func setDelegates() {
        contentView.resultsTableView.register(SearchResultTableViewCell.self, forCellReuseIdentifier: SearchResultTableViewCell.searchResultTableViewCellIdentifier)
        contentView.resultsTableView.delegate = self
        contentView.resultsTableView.dataSource = self
        
        contentView.searchBar.delegate = self
    }
    
//    private func configure() {
//
//    }
}

// MARK: - UITableViewDataSource

extension JobSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultTableViewCell.searchResultTableViewCellIdentifier) as! SearchResultTableViewCell
        
        return cell
    }
    
    
}

// MARK: - UITableViewDelegate

extension JobSearchViewController: UITableViewDelegate {
    
}

// MARK: - UISearchBarDelegate

extension JobSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)

        // capture text
        
        // make API call
    }
}
