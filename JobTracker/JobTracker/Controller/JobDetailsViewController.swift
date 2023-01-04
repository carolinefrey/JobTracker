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

class JobDetailsViewController: UIViewController, UpdateJobDelegate {

    // MARK: - UI Properties
    
    var job: Job
    
    private var detailsStackView: DetailsStackView
    
    lazy var editJobButton: UIBarButtonItem = {
        let config = UIImage.SymbolConfiguration(textStyle: .title3)
        let icon = UIImage(systemName: "slider.horizontal.3", withConfiguration: config)
        let button = UIBarButtonItem(image: icon, style: .plain, target: self, action: #selector(editJob))
        button.tintColor = UIColor(named: "Color4")
        return button
    }()
    
//    lazy var favoriteButton: UIBarButtonItem = {
//        let config = UIImage.SymbolConfiguration(textStyle: .title3)
//        let icon = UIImage(systemName: "heart", withConfiguration: config)
//        let button = UIBarButtonItem(image: icon, style: .plain, target: self, action: #selector(favoriteJob))
//        button.tintColor = UIColor(named: "FavoriteButtonColor")
//        return button
//    }()
    
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
        navigationItem.rightBarButtonItems = [editJobButton]
        
        view.addSubview(detailsStackView)
        
        configureStackView()
    }
    
    // MARK: - Functions
    
    func didUpdateJob(job: Job) {
        detailsStackView.statusDetailView.detailLabel.text = job.status?.capitalized
        detailsStackView.statusDetailView.detail = .status
        detailsStackView.statusDetailView.setStatusBoxColor(status: JobStatus(rawValue: job.status!) ?? .open)
        detailsStackView.companyDetailView.detailLabel.text = job.company
        detailsStackView.roleDetailView.detailLabel.text = job.role
        detailsStackView.locationDetailView.detailLabel.text = job.location
        detailsStackView.linkDetailView.detailLabel.text = job.link
        detailsStackView.notesDetailView.detailLabel.text = job.notes
    }
    
    @objc func editJob() {
        let editJobVC = EditJobViewController(job: job)
        editJobVC.delegate = self
        navigationController?.pushViewController(editJobVC, animated: true)
    }
    
//    @objc func favoriteJob() {
//        //TODO: - Implement favorite jobs
//    }
    
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
