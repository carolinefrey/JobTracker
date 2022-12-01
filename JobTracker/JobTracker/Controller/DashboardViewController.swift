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
    
    var statusCounts: [String: Int] = [:]
        
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        contentView.collectionView.reloadData()
    }

    // MARK: - Functions
    
    @objc func addNewJob() {
        let addNewJobVC = AddJobViewController()
        navigationController?.pushViewController(addNewJobVC, animated: true)
    }
    
    func updateJobStatusCounts() {
        for status in jobs {
            statusCounts[status.status.rawValue, default: 0] += 1
        }

        contentView.statusBoxes.openStatusBox.countLabel.text = "\(statusCounts["open"] ?? 0)"
        contentView.statusBoxes.appliedStatusBox.countLabel.text = "\(statusCounts["applied"] ?? 0)"
        contentView.statusBoxes.interviewStatusBox.countLabel.text = "\(statusCounts["interview"] ?? 0)"
        contentView.statusBoxes.closedStatusBox.countLabel.text = "\(statusCounts["closed"] ?? 0)"
    }
}

// MARK: - UICollectionViewDataSource

extension DashboardViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return jobs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DashboardCollectionViewCell.dashboardCollectionViewCellIdentifier, for: indexPath) as! DashboardCollectionViewCell
        cell.configure(company: jobs[indexPath.row].company, location: jobs[indexPath.row].location, status: jobs[indexPath.row].status)
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension DashboardViewController: UICollectionViewDelegate {
    
}

