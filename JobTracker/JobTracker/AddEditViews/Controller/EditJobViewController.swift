//
//  EditJobViewController.swift
//  JobTracker
//
//  Created by Caroline Frey on 12/6/22.
//

import UIKit

protocol UpdateJobDelegate: AnyObject {
    func didUpdateJob(_ job: Job)
}

protocol DeleteJobDelegate: AnyObject {
    func didDeleteJob(_ job: Job)
}

class EditJobViewController: UIViewController, UITextViewDelegate {
    
    var dashboardVC: UIViewController
    var updateJobDelegate: UpdateJobDelegate?
    var deleteJobDelegate: DeleteJobDelegate?
    
    // MARK: - UI Properties
    
    var job: Job
    
    private var contentView: EditJobContentView
        
    private var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isScrollEnabled = true
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()
    
    lazy var updateJobButton: UIBarButtonItem = {
        let config = UIImage.SymbolConfiguration(textStyle: .title3)
        let icon = UIImage(systemName: "square.and.arrow.down", withConfiguration: config)
        let button = UIBarButtonItem(image: icon, style: .plain, target: self, action: #selector(updateJob))
        button.tintColor = UIColor.black
        button.isEnabled = false //disable until user enters company name
        return button
    }()
    
    // MARK: - Initializer
    
    init(dashboardVC: UIViewController, job: Job) {
        self.dashboardVC = dashboardVC
        self.job = job
        contentView = EditJobContentView(job: job)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.background
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        configureScrollView()
        
        navigationItem.rightBarButtonItems = [updateJobButton]
        
        setTextViewDelegates()
        configureSaveButton()
        configureTargets()
    }
    
    // MARK: - Functions
    
    private func setTextViewDelegates() {
        contentView.textFieldStackView.companyField.textFieldView.delegate = self
        contentView.textFieldStackView.roleField.textFieldView.delegate = self
        contentView.textFieldStackView.locationField.textFieldView.delegate = self
        contentView.textFieldStackView.linkField.textFieldView.delegate = self
        contentView.textFieldStackView.notesField.notesFieldView.delegate = self
        contentView.textFieldStackView.notesField.editJobFieldDelegate = self
    }
    
    private func configureSaveButton() {
        // Disable save button until user enters Company name
        if contentView.textFieldStackView.companyField.textFieldView.text != "" {
            updateJobButton.isEnabled = true
            let config = UIImage.SymbolConfiguration(textStyle: .title3)
            updateJobButton.image = UIImage(systemName: "square.and.arrow.down.fill", withConfiguration: config)
        }
    }
    
    private func configureTargets() {
        contentView.textFieldStackView.companyField.textFieldView.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        contentView.deleteJobButton.addTarget(self, action: #selector(deleteJob), for: .touchUpInside)
    }
    
    private func configureScrollView() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentSize = CGSize(width: view.frame.size.width, height: contentView.bounds.height+950)
        
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
    
    @objc func updateJob() {
        DataManager.updateJob(job: job, company: contentView.textFieldStackView.companyField.textFieldView.text ?? "none",
                              role: contentView.textFieldStackView.roleField.textFieldView.text ?? "none",
                              location: contentView.textFieldStackView.locationField.textFieldView.text ?? "none",
                              status: contentView.selectStatusView.status.rawValue,
                              link: contentView.textFieldStackView.linkField.textFieldView.text ?? "none",
                              notes: contentView.textFieldStackView.notesField.notesFieldView.text ?? "none",
                              dateLastUpdated: Date.now,
                              dateApplied: contentView.textFieldStackView.dateAppliedField.dateAppliedField.date)
        updateJobDelegate?.didUpdateJob(job)
        navigationController?.popViewController(animated: true)
    }

    @objc func deleteJob() {
        DataManager.deleteJob(item: job)
        deleteJobDelegate?.didDeleteJob(job)
        navigationController?.popToViewController(dashboardVC, animated: true)
    }
    
    @objc func textFieldChanged(_ sender: UITextField) {
        if contentView.textFieldStackView.companyField.textFieldView.text != "" {
            updateJobButton.isEnabled = true
            updateJobButton.image = UIImage(systemName: "square.and.arrow.down.fill", withConfiguration: UIImage.SymbolConfiguration(textStyle: .title3))
        } else {
            updateJobButton.isEnabled = false
            updateJobButton.image = UIImage(systemName: "square.and.arrow.down", withConfiguration: UIImage.SymbolConfiguration(textStyle: .title3))
        }
    }
}

// MARK: - UITextFieldDelegate

extension EditJobViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

// MARK: - NotesFieldEditJobViewDelegate

extension EditJobViewController: NotesFieldEditJobViewDelegate {
    func tapDoneButtonFromEditView() {
        self.view.endEditing(true)
    }
}
