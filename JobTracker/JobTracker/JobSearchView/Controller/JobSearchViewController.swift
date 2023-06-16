//
//  JobSearchViewController.swift
//  JobTracker
//
//  Created by Caroline Frey on 6/15/23.
//

import UIKit

class JobSearchViewController: UIViewController {
    
    // MARK: - UI Properties
    
    private var contentView = JobSearchView()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = contentView
        
        configure()
    }
    
    // MARK: - Functions
    
    private func configure() {
        
    }
}
