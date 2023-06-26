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
        return cell
    }()
    
    let jobTitleLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont(name: "Nunito-SemiBold", size: 16)
        title.adjustsFontSizeToFitWidth = true
        title.lineBreakMode = .byTruncatingTail
        title.numberOfLines = 1
        return title
    }()
    
    let companyLabel: UILabel = {
        let company = UILabel()
        company.translatesAutoresizingMaskIntoConstraints = false
        company.font = UIFont(name: "Nunito-SemiBold", size: 12)
        company.textColor = UIColor.black
        return company
    }()
    
    let locationLabel: UILabel = {
        let location = UILabel()
        location.translatesAutoresizingMaskIntoConstraints = false
        location.font = UIFont(name: "Nunito-Regular", size: 12)
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
        companyLabel.text = result.company
        locationLabel.text = result.location
    }
    
    // MARK: - UI Setup

    private func configureViews() {
        addSubview(backgroundCell)
        addSubview(jobTitleLabel)
        addSubview(companyLabel)
        addSubview(locationLabel)
        
        NSLayoutConstraint.activate([
            backgroundCell.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundCell.topAnchor.constraint(equalTo: topAnchor),
            backgroundCell.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundCell.bottomAnchor.constraint(equalTo: bottomAnchor),
        
            jobTitleLabel.leadingAnchor.constraint(equalTo: backgroundCell.leadingAnchor, constant: 10),
            jobTitleLabel.topAnchor.constraint(equalTo: backgroundCell.topAnchor, constant: 5),
            jobTitleLabel.heightAnchor.constraint(equalToConstant: 25),
            
            companyLabel.leadingAnchor.constraint(equalTo: backgroundCell.leadingAnchor, constant: 10),
            companyLabel.topAnchor.constraint(equalTo: jobTitleLabel.bottomAnchor),

            locationLabel.leadingAnchor.constraint(equalTo: backgroundCell.leadingAnchor, constant: 10),
            locationLabel.topAnchor.constraint(equalTo: companyLabel.bottomAnchor),
        ])
    }
}
