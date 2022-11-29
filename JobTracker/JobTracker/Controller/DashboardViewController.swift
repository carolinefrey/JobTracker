//
//  DashboardViewController.swift
//  JobTracker
//
//  Created by Caroline Frey on 11/23/22.
//

import UIKit

class DashboardViewController: UIViewController {
    
    // MARK: - Class Properties
    
    private let viewModel: DashboardViewModel
    
    init(viewModel: DashboardViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI Properties

    private var contentView: ContentView!
    
    // MARK: - Lifecycle

    override func loadView() {
        super.loadView()
        view.backgroundColor = .blue
        
        contentView = ContentView()
        view = contentView
    }
    
    // MARK: - UICollectionViewDelegate
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        viewModel.handleSelection(indexPath: indexPath)
//    }
    
    // MARK: - UICollectionDataSource

}

