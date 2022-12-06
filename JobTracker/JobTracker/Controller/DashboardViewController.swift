//
//  DashboardViewController.swift
//  JobTracker
//
//  Created by Caroline Frey on 11/23/22.
//

import UIKit

class DashboardViewController: UIViewController {
        
    // MARK: - UI Properties
    
    private var contentView: DashboardContentView!
    
    private var statusCounts: [String: Int] = [:]
    
    private var savedJobs = [Job]()
        
    lazy var addNewJobButton: UIBarButtonItem = {
        let config = UIImage.SymbolConfiguration(textStyle: .title3)
        let icon = UIImage(systemName: "plus", withConfiguration: config)
        let button = UIBarButtonItem(image: icon, style: .plain, target: self, action: #selector(addNewJob))
        button.tintColor = UIColor(named: "Color4")
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .blue
        navigationItem.rightBarButtonItem = addNewJobButton

        contentView = DashboardContentView()
        view = contentView
        
        contentView.collectionView.dataSource = self
        contentView.collectionView.delegate = self
        
        updateJobStatusCounts()
        
        fetchJobs()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchJobs()
        contentView.collectionView.reloadData()
    }

    // MARK: - Functions
    
    @objc func addNewJob(_ sender: UIBarButtonItem) {
        let emptyJob = Job()
        let addNewJobVC = AddEditJobViewController(editView: false, title: "Add a new job", job: emptyJob)
        navigationController?.pushViewController(addNewJobVC, animated: true)
    }
    
    private func updateJobStatusCounts() {
        for status in savedJobs {
            statusCounts[status.status ?? "open", default: 0] += 1
        }

        contentView.statusBoxes.openStatusBox.countLabel.text = "\(statusCounts["open"] ?? 0)"
        contentView.statusBoxes.appliedStatusBox.countLabel.text = "\(statusCounts["applied"] ?? 0)"
        contentView.statusBoxes.interviewStatusBox.countLabel.text = "\(statusCounts["interview"] ?? 0)"
        contentView.statusBoxes.closedStatusBox.countLabel.text = "\(statusCounts["closed"] ?? 0)"
    }
    
    private func fetchJobs() {
        DataManager.fetchJobs { [weak self] jobs in
            if let jobs = jobs {
                savedJobs = jobs
                
                DispatchQueue.main.async { [weak self] in
                    self?.contentView.collectionView.reloadData()
                }
            }
        }
    }
}

// MARK: - UICollectionViewDataSource

extension DashboardViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return savedJobs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DashboardCollectionViewCell.dashboardCollectionViewCellIdentifier, for: indexPath) as! DashboardCollectionViewCell
        cell.configure(company: savedJobs[indexPath.row].company ?? "N/A", location: savedJobs[indexPath.row].location ?? "N/A", status: savedJobs[indexPath.row].status ?? "open")
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension DashboardViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = JobDetailsViewController(job: savedJobs[indexPath.row]) //add parameters to pass in job info
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

