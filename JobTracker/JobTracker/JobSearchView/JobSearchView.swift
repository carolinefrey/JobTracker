//
//  JobSearchView.swift
//  JobTracker
//
//  Created by Caroline Frey on 6/16/23.
//

import UIKit

class JobSearchView: UIView {

    // MARK: - UI Properties
    
    let title: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont(name: "Nunito-SemiBold", size: 26)
        title.textColor = UIColor.black
        title.text = "Search jobs"
        return title
    }()
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = "Search"
        searchBar.sizeToFit()
        searchBar.isTranslucent = true
        searchBar.autocapitalizationType = .none
        return searchBar
    }()
    
    let resultsTableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .background
        table.clipsToBounds = true
        table.layer.cornerRadius = 10
        table.rowHeight = 90
        return table
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .background
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup

    private func setUpViews() {
        addSubview(title)
        addSubview(searchBar)
        addSubview(resultsTableView)
        resultsTableView.tableHeaderView = searchBar
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            title.heightAnchor.constraint(equalToConstant: 30),
            
            resultsTableView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 10),
            resultsTableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            resultsTableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            resultsTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
