//
//  SearchResultDetailView.swift
//  JobTracker
//
//  Created by Caroline Frey on 6/26/23.
//

import UIKit

class SearchResultDetailView: UIView {
    
    // MARK: - UI Properties
    
    let job: SingleJob
    
    let jobTitleLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont(name: "Nunito-SemiBold", size: 24)
        title.adjustsFontSizeToFitWidth = true
        title.lineBreakMode = .byTruncatingTail
        title.numberOfLines = 1
        return title
    }()
    
    let companyLabel: UILabel = {
        let company = UILabel()
        company.translatesAutoresizingMaskIntoConstraints = false
        company.font = UIFont(name: "Nunito-SemiBold", size: 18)
        company.textColor = UIColor.black
        return company
    }()
    
    let locationLabel: UILabel = {
        let location = UILabel()
        location.translatesAutoresizingMaskIntoConstraints = false
        location.font = UIFont(name: "Nunito-Regular", size: 14)
        return location
    }()
    
    let descriptionLabel: UILabel = {
        let description = UILabel()
        description.translatesAutoresizingMaskIntoConstraints = false
        description.font = UIFont(name: "Nunito-Regular", size: 14)
        description.lineBreakMode = .byWordWrapping
        description.numberOfLines = 0
        return description
    }()
    
    let urlLabel: UILabel = {
        let url = UILabel()
        url.translatesAutoresizingMaskIntoConstraints = false
        url.font = UIFont(name: "Nunito-Regular", size: 12)
        return url
    }()
    
    // MARK: - Initializers
    
    init(job: SingleJob) {
        self.job = job
        super.init(frame: .zero)
        
        backgroundColor = UIColor.background
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup

    private func configureViews() {
        jobTitleLabel.text = job.role
        companyLabel.text = job.company
        locationLabel.text = job.location
        descriptionLabel.text = job.description
        urlLabel.text = job.link
        
        configureURLLabel()
        
        addSubview(jobTitleLabel)
        addSubview(companyLabel)
        addSubview(locationLabel)
        addSubview(descriptionLabel)
        addSubview(urlLabel)
                
        NSLayoutConstraint.activate([
            jobTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            jobTitleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            
            companyLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            companyLabel.topAnchor.constraint(equalTo: jobTitleLabel.bottomAnchor, constant: 10),
            
            locationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            locationLabel.topAnchor.constraint(equalTo: companyLabel.bottomAnchor, constant: 10),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            descriptionLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            urlLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            urlLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            urlLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
        ])
    }
    
    // MARK: - Functions
    
    private func configureURLLabel() {
        let tapAction = UITapGestureRecognizer(target: self, action: #selector(configureURL(_:)))
        urlLabel.isUserInteractionEnabled = true
        urlLabel.addGestureRecognizer(tapAction)
    }
    
    @objc func configureURL(_ sender: UITapGestureRecognizer) {
        let webURL = URL(string: job.link)!
        let application = UIApplication.shared
        application.open(webURL)
    }
}
