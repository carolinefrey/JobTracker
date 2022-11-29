//
//  DashboardViewController.swift
//  JobTracker
//
//  Created by Caroline Frey on 11/23/22.
//

import UIKit

class DashboardViewController: UIViewController {
        
    // MARK: - UI Properties
    
    private var contentView: ContentView!
    
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
        
        contentView = ContentView()
        view = contentView
        
        navigationItem.rightBarButtonItem = addNewJobButton
        
        updateJobStatusCounts()
    }

    // MARK: - Functions
    
    @objc func addNewJob() {
        let addNewJobVC = AddNewJobViewController()
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
    
    // MARK: - UICollectionViewDelegate
    
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        viewModel.handleSelection(indexPath: indexPath)
    //    }
    
    // MARK: - UICollectionDataSource
    
    
}

