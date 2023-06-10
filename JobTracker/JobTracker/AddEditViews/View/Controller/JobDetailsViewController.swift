//
//  JobDetailsViewController.swift
//  JobTracker
//
//  Created by Caroline Frey on 12/2/22.
//

import UIKit

class JobDetailsViewController: UIViewController, UpdateJobDelegate {

    // MARK: - UI Properties
    
    var dashboardVC: UIViewController
    var job: Job
    
    var deleteJobDelegate: DeleteJobDelegate? //pass from DashboardVC --> EditJobVC through this VC
    
    private var detailsStackView: DetailsStackView
    
    lazy var editJobButton: UIBarButtonItem = {
        let config = UIImage.SymbolConfiguration(textStyle: .title3)
        let icon = UIImage(systemName: "slider.horizontal.3", withConfiguration: config)
        let button = UIBarButtonItem(image: icon, style: .plain, target: self, action: #selector(editJob))
        button.tintColor = UIColor.black
        return button
    }()
    
    lazy var favoriteJobButton: UIBarButtonItem = {
        let config = UIImage.SymbolConfiguration(textStyle: .title3)
        let icon = UIImage(systemName: "heart", withConfiguration: config)
        let button = UIBarButtonItem(image: icon, style: .plain, target: self, action: #selector(favoriteJobButtonTapped))
        button.tintColor = .systemPink
        return button
    }()
    
    // MARK: - Initializers
    
    init(dashboardVC: UIViewController, job: Job) {
        self.dashboardVC = dashboardVC
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
        view.backgroundColor = UIColor.background
        navigationItem.rightBarButtonItems = [editJobButton, favoriteJobButton]
        
        if job.favorite {
            favoriteJobButton.image = UIImage(systemName: "heart.fill", withConfiguration: UIImage.SymbolConfiguration(textStyle: .title3))
        }
        
        view.addSubview(detailsStackView)
        
        configureStackView()
    }
    
    // MARK: - Functions
    
    @objc func favoriteJobButtonTapped() {
        if job.favorite {
            DataManager.favoriteJob(job: job, favorite: false)
            favoriteJobButton.image = UIImage(systemName: "heart", withConfiguration: UIImage.SymbolConfiguration(textStyle: .title3))
        } else {
            DataManager.favoriteJob(job: job, favorite: true)
            favoriteJobButton.image = UIImage(systemName: "heart.fill", withConfiguration: UIImage.SymbolConfiguration(textStyle: .title3))
        }
    }
    
    func didUpdateJob(_ job: Job) {
        detailsStackView.statusDetailView.detailLabel.text = job.status?.capitalized
        detailsStackView.statusDetailView.detail = .status
        detailsStackView.statusDetailView.setStatusBoxColor(status: JobStatus(rawValue: job.status!) ?? .open)
        detailsStackView.companyDetailView.detailLabel.text = job.company
        detailsStackView.roleDetailView.detailLabel.text = job.role
        detailsStackView.locationDetailView.detailLabel.text = job.location
        detailsStackView.linkDetailView.detailLabel.text = job.link
        detailsStackView.notesDetailView.detailLabel.text = job.notes
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy"
        detailsStackView.dateLastUpdatedView.detailLabel.text = formatter.string(from: job.dateLastUpdated)
        detailsStackView.dateAppliedDetailView.detailLabel.text = formatter.string(from: job.dateApplied ?? Date.now)
    }
    
    @objc func editJob() {
        let editJobVC = EditJobViewController(viewModel: AddEditViewModel(), dashboardVC: dashboardVC, job: job)
        editJobVC.updateJobDelegate = self
        editJobVC.deleteJobDelegate = self.deleteJobDelegate
        navigationController?.pushViewController(editJobVC, animated: true)
    }
    
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
