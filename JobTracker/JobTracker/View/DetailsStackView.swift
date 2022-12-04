//
//  DetailsStackView.swift
//  JobTracker
//
//  Created by Caroline Frey on 12/2/22.
//

import UIKit

class DetailsStackView: UIView {

    // MARK: - UI Properties
    
    var job: Job
    
    private let detailsStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .equalSpacing
        //stack.spacing = 5
        stack.axis = .vertical
        return stack
    }()
    
    private var statusDetailView: SingleDetailView
    private var companyDetailView: SingleDetailView
    private var roleDetailView: SingleDetailView
    private var locationDetailView: SingleDetailView
    private var linkDetailView: SingleDetailView    
    private var notesDetailView: SingleDetailView

    // MARK: - Initializers
    
    init(job: Job) {
        self.job = job
        
        statusDetailView = SingleDetailView(job: job, detail: .status)
        companyDetailView = SingleDetailView(job: job, detail: .company)
        roleDetailView = SingleDetailView(job: job, detail: .role)
        locationDetailView = SingleDetailView(job: job, detail: .location)
        linkDetailView = SingleDetailView(job: job, detail: .link)
        notesDetailView = SingleDetailView(job: job, detail: .notes)
        
        super.init(frame: .zero)
        
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup

    private func setUpViews() {

        addSubview(detailsStackView)
        detailsStackView.addArrangedSubview(statusDetailView)
        detailsStackView.addArrangedSubview(companyDetailView)
        detailsStackView.addArrangedSubview(roleDetailView)
        detailsStackView.addArrangedSubview(locationDetailView)
        detailsStackView.addArrangedSubview(linkDetailView)
        detailsStackView.addArrangedSubview(notesDetailView)
        
        NSLayoutConstraint.activate([
            detailsStackView.topAnchor.constraint(equalTo: topAnchor),
            detailsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            detailsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            detailsStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
        ])
    }
    // MARK: - UI Setup

}
