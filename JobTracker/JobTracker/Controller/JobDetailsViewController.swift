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
    
    lazy var editJobButton: UIBarButtonItem = {
        let config = UIImage.SymbolConfiguration(textStyle: .title3)
        let icon = UIImage(systemName: "slider.horizontal.3", withConfiguration: config)
        let button = UIBarButtonItem(image: icon, style: .plain, target: self, action: #selector(editJob))
        button.tintColor = UIColor(named: "Color4")
        return button
    }()
    
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
        navigationItem.rightBarButtonItem = editJobButton
        
        view.addSubview(detailsStackView)
        
        configureStackView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        view.backgroundColor = UIColor(named: "Background")
        navigationItem.rightBarButtonItem = editJobButton
        
        view.addSubview(detailsStackView)
        
        configureStackView()
    }
    
    // MARK: - Functions
    
    @objc func editJob() {
        let editJobVC = AddEditJobViewController(editView: true, title: "Edit job", job: job)
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
