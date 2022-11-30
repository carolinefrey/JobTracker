//
//  AddNewJobViewController.swift
//  JobTracker
//
//  Created by Caroline Frey on 11/29/22.
//

import UIKit

class AddJobViewController: UIViewController {
    
    // MARK: - UI Properties
    
    private var contentView: AddJobContentView!
    
    lazy var saveJobButton: UIBarButtonItem = {
        let config = UIImage.SymbolConfiguration(textStyle: .title3)
        let icon = UIImage(systemName: "checkmark", withConfiguration: config)
        let button = UIBarButtonItem(image: icon, style: .plain, target: self, action: #selector(saveJob))
        button.tintColor = UIColor(named: "Color4")
        return button
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = saveJobButton
        contentView = AddJobContentView()
        view = contentView
    }
    
    // MARK: - Functions
    
    @objc func saveJob() {
        //TODO: - Implement save function here
        navigationController?.popViewController(animated: true)
    }
}
