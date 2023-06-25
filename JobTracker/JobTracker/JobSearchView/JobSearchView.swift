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
    
    let locationField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.backgroundColor = .white
        field.returnKeyType = .done
        field.layer.cornerRadius = 10
        field.font = UIFont(name: "Nunito-Regular", size: 14)
        field.textColor = UIColor.black
        field.placeholder = "Location (default: London)"
        field.setLeftPadding(10)
        field.setRightPadding(10)
        return field
    }()
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = UISearchBar.Style.minimal
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
        table.rowHeight = 70
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
        addSubview(locationField)
        addSubview(searchBar)
        addSubview(resultsTableView)
        
        resultsTableView.tableHeaderView = searchBar
        searchBar.frame = CGRect(x: 0.0, y: 0.0, width: 200.0, height: 50.0)
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            title.heightAnchor.constraint(equalToConstant: 30),
            
            locationField.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 10),
            locationField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            locationField.heightAnchor.constraint(equalToConstant: 35),
            locationField.widthAnchor.constraint(equalTo: resultsTableView.widthAnchor),
            
            resultsTableView.topAnchor.constraint(equalTo: locationField.bottomAnchor, constant: 10),
            resultsTableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            resultsTableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            resultsTableView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.70),
        ])
    }
}
