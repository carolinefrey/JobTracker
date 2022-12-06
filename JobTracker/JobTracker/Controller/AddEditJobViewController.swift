//
//  AddEditNewJobViewController.swift
//  JobTracker
//
//  Created by Caroline Frey on 11/29/22.
//

import UIKit

class AddEditJobViewController: UIViewController {
    
    // MARK: - UI Properties
    
    var editView: Bool
    var vcTitle: String
    var job: Job
    
    private var contentView: AddJobContentView
    
    private var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isScrollEnabled = true
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()
    
    lazy var saveJobButton: UIBarButtonItem = {
        let config = UIImage.SymbolConfiguration(textStyle: .title3)
        let icon = UIImage(systemName: "square.and.arrow.down", withConfiguration: config)
        let button = UIBarButtonItem(image: icon, style: .plain, target: self, action: #selector(saveJob))
        button.tintColor = UIColor(named: "Color4")
        button.isEnabled = false //disable until user enters company name
        return button
    }()
    
    // MARK: - Initializer
    
    init(editView: Bool, title: String, job: Job) {
        self.editView = editView
        self.vcTitle = title
        self.job = job
        contentView = AddJobContentView(editView: editView, viewTitle: title, job: job)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = saveJobButton
        view.backgroundColor = UIColor(named: "Background")
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        configureScrollView()
        
        setTextViewDelegates()
        
        // Disable save button until user enters Company name
        if contentView.textFieldStackView.companyField.textFieldView.text != "" {
            saveJobButton.isEnabled = true
            let config = UIImage.SymbolConfiguration(textStyle: .title3)
            saveJobButton.image = UIImage(systemName: "square.and.arrow.down.fill", withConfiguration: config)
        }
        
        contentView.textFieldStackView.companyField.textFieldView.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
    }
    
    // MARK: - Functions
    
    private func configureScrollView() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.contentSize = CGSize(width: view.frame.size.width, height: contentView.bounds.height+900)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalTo: view.heightAnchor),
        ])
    }
    
    @objc func saveJob() {
        if editView == true {
            DataManager.updateJob(job: job, company: contentView.textFieldStackView.companyField.textFieldView.text ?? "none", role: contentView.textFieldStackView.roleField.textFieldView.text ?? "none", location: contentView.textFieldStackView.locationField.textFieldView.text ?? "none", status: contentView.selectStatusView.status.rawValue, link: contentView.textFieldStackView.linkField.textFieldView.text ?? "none", notes: contentView.textFieldStackView.notesField.textFieldView.text ?? "none")
        } else {
            DataManager.addJob(company: contentView.textFieldStackView.companyField.textFieldView.text ?? "none", role: contentView.textFieldStackView.roleField.textFieldView.text ?? "none", location: contentView.textFieldStackView.locationField.textFieldView.text ?? "none", status: contentView.selectStatusView.status, link: contentView.textFieldStackView.linkField.textFieldView.text ?? "none", notes: contentView.textFieldStackView.notesField.textFieldView.text ?? "none")
        }
        navigationController?.popViewController(animated: true)
    }
    
    @objc func textFieldChanged(sender: UITextField) {
        if contentView.textFieldStackView.companyField.textFieldView.text != "" {
            saveJobButton.isEnabled = true
            let config = UIImage.SymbolConfiguration(textStyle: .title3)
            saveJobButton.image = UIImage(systemName: "square.and.arrow.down.fill", withConfiguration: config)
        } else {
            saveJobButton.isEnabled = false
            let config = UIImage.SymbolConfiguration(textStyle: .title3)
            saveJobButton.image = UIImage(systemName: "square.and.arrow.down", withConfiguration: config)
        }
    }
    
    private func setTextViewDelegates() {
        contentView.textFieldStackView.companyField.textFieldView.delegate = self
        contentView.textFieldStackView.roleField.textFieldView.delegate = self
        contentView.textFieldStackView.locationField.textFieldView.delegate = self
        contentView.textFieldStackView.linkField.textFieldView.delegate = self
        contentView.textFieldStackView.notesField.textFieldView.delegate = self
    }
}

// MARK: - UITextFieldDelegate

extension AddEditJobViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
