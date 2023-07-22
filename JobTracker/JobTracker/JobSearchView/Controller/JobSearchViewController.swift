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
        contentView.locationField.delegate = self
    }
}

// MARK: - UITableViewDataSource

extension JobSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.backgroundView = contentView.noResultsLabel
        if searchResults.count > 0 {
            contentView.noResultsLabel.text = ""
        }
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = SearchResultDetailViewController(job: searchResults[indexPath.row])
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

// MARK: - UISearchBarDelegate

extension JobSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        
        let searchTerm = searchBar.text ?? ""
        let location = contentView.locationField.text ?? ""
        
        searchJobs(searchTerm: searchTerm, location: location) { [weak self] jobResults, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
            DispatchQueue.main.async {
                if let jobResults = jobResults, jobResults.count > 0 {
                    self?.searchResults = jobResults
                    self?.contentView.resultsTableView.reloadData()
                } else {
                    self?.contentView.noResultsLabel.text = "No jobs available."
                    self?.contentView.resultsTableView.reloadData()
                    print("No jobs found")
                }
            }
        }
    }
}

// MARK: - UITextFieldDelegate

extension JobSearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        
        let searchTerm = contentView.searchBar.text ?? ""
        print("searchTerm = \(searchTerm)")
        let location = contentView.locationField.text ?? ""
        
        searchJobs(searchTerm: "", location: location) { [weak self] jobResults, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
            DispatchQueue.main.async {
                if let jobResults = jobResults, jobResults.count > 0 {
                    self?.searchResults = jobResults
                    self?.contentView.resultsTableView.reloadData()
                } else {
                    self?.contentView.noResultsLabel.text = "No jobs available."
                    self?.contentView.resultsTableView.reloadData()
                    print("No jobs found")
                }
            }
        }
        return false
    }
}
