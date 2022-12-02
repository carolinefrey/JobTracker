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
    
    lazy var textFieldDelegate = self
    
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
        
        contentView.textFieldStackView.companyField.textFieldView.delegate = self
        contentView.textFieldStackView.roleField.textFieldView.delegate = self
        contentView.textFieldStackView.teamField.textFieldView.delegate = self
        contentView.textFieldStackView.locationField.textFieldView.delegate = self
        contentView.textFieldStackView.linkField.textFieldView.delegate = self
        contentView.textFieldStackView.notesField.textFieldView.delegate = self
    }
    
    // MARK: - Functions
    
    @objc func saveJob() {
        
        let newJobStatus = contentView.selectStatusView.status
        
        let newJob = SingleJob(status: newJobStatus, company: contentView.textFieldStackView.companyField.textFieldView.text ?? "none", role: contentView.textFieldStackView.roleField.textFieldView.text ?? "none", location: contentView.textFieldStackView.locationField.textFieldView.text ?? "none")
        jobs.append(newJob)
        
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UITextFieldDelegate

extension AddJobViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
