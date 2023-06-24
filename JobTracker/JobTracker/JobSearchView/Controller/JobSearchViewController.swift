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
    
    var searchResults: [SingleJob] = []
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = contentView
        
        setDelegates()
    }
    
    // MARK: - Functions
    
    private func setDelegates() {
        contentView.resultsTableView.register(SearchResultTableViewCell.self, forCellReuseIdentifier: SearchResultTableViewCell.searchResultTableViewCellIdentifier)
        contentView.resultsTableView.delegate = self
        contentView.resultsTableView.dataSource = self
        
        contentView.searchBar.delegate = self

    }
}

// MARK: - UITableViewDataSource

extension JobSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultTableViewCell.searchResultTableViewCellIdentifier) as! SearchResultTableViewCell
        let currentResult = searchResults[indexPath.row]
        cell.setFetchedResults(result: currentResult)
        
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
        
        let searchTerm = searchBar.text ?? ""
        
        searchJobs(searchTerm: searchTerm) { jobResults, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
            DispatchQueue.main.async {
                if let jobResults = jobResults {
                    self.searchResults = jobResults
                    self.contentView.resultsTableView.reloadData()
                } else {
                    print("Jobs not found")
                }
            }
        }
    }
}
