//
//  SearchResultTableViewCell.swift
//  JobTracker
//
//  Created by Caroline Frey on 6/23/23.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {

    static let searchResultTableViewCellIdentifier = "SearchResultTableViewCell"
    
    // MARK: - UI Properties
    
    let backgroundCell: UIView = {
        let cell = UIView()
        cell.translatesAutoresizingMaskIntoConstraints = false
        cell.backgroundColor = .background
        cell.clipsToBounds = true
        cell.layer.cornerRadius = 10
        return cell
    }()
    
    let jobTitleLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "Job Title"
        title.font = .boldSystemFont(ofSize: 18)
        return title
    }()
    
    let locationLabel: UILabel = {
        let location = UILabel()
        location.translatesAutoresizingMaskIntoConstraints = false
        location.text = "Job location"
        location.font = .systemFont(ofSize: 14)
        return location
    }()
  
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Functions
    
    func setFetchedResults(result: SingleJob) {
        jobTitleLabel.text = result.role
        locationLabel.text = result.location
    }
    
    // MARK: - UI Setup

    private func configureViews() {
        addSubview(backgroundCell)
        addSubview(jobTitleLabel)
        addSubview(locationLabel)
        
        NSLayoutConstraint.activate([
            backgroundCell.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundCell.topAnchor.constraint(equalTo: topAnchor),
            backgroundCell.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundCell.bottomAnchor.constraint(equalTo: bottomAnchor),
        
            jobTitleLabel.leadingAnchor.constraint(equalTo: backgroundCell.leadingAnchor, constant: 10),
            jobTitleLabel.topAnchor.constraint(equalTo: backgroundCell.topAnchor, constant: 5),
            jobTitleLabel.heightAnchor.constraint(equalToConstant: 50),
            
            locationLabel.leadingAnchor.constraint(equalTo: jobTitleLabel.trailingAnchor, constant: 5),
            locationLabel.centerYAnchor.constraint(equalTo: jobTitleLabel.centerYAnchor),
            
//            jobDescriptionLabel.leadingAnchor.constraint(equalTo: backgroundCell.leadingAnchor, constant: 10),
//            jobDescriptionLabel.topAnchor.constraint(equalTo: jobTitleLabel.bottomAnchor),
//            jobDescriptionLabel.trailingAnchor.constraint(equalTo: backgroundCell.trailingAnchor, constant: -10),
//            jobDescriptionLabel.bottomAnchor.constraint(equalTo: backgroundCell.bottomAnchor),
        ])
    }
}
