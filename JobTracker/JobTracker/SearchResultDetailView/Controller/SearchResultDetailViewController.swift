//
//  SearchResultDetailViewController.swift
//  JobTracker
//
//  Created by Caroline Frey on 6/26/23.
//

import UIKit

class SearchResultDetailViewController: UIViewController {

    // MARK: - UI Properties
    
    private var contentView: SearchResultDetailView!
    
    let job: SingleJob
    
    // MARK: - Initializers
    
    init(job: SingleJob) {
        self.job = job
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.background
        
        contentView = SearchResultDetailView(job: job)
        view = contentView
    }
    
    // MARK: - Functions
    
}
