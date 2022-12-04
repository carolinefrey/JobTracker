//
//  JobDetailsViewController.swift
//  JobTracker
//
//  Created by Caroline Frey on 12/2/22.
//

import UIKit

enum Detail: String {
    case status, company, role, location, link, notes
}

class JobDetailsViewController: UIViewController {
    
    // MARK: - UI Properties
    
    var job: Job

    private var detailsStackView: DetailsStackView
    
    // MARK: - Initializers
    
    init(job: Job) {
        self.job = job
        
        detailsStackView = DetailsStackView(job: job)

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Background")
        
        view.addSubview(detailsStackView)
        
        configureStackView()
    }
    
    // MARK: - Functions
    
    private func configureStackView () {
        detailsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            detailsStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            detailsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detailsStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
