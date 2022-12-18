//
//  AddNewJobViewController.swift
//  JobTracker
//
//  Created by Caroline Frey on 11/29/22.
//

import UIKit

class AddJobViewController: UIViewController {
    
    // MARK: - UI Properties
    
    private var contentView = AddJobContentView()
    
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
    
//    lazy var favoriteButton: UIBarButtonItem = {
//        let config = UIImage.SymbolConfiguration(textStyle: .title3)
//        let icon = UIImage(systemName: "heart", withConfiguration: config)
//        let button = UIBarButtonItem(image: icon, style: .plain, target: self, action: #selector(favoriteJob))
//        button.tintColor = UIColor(named: "FavoriteButtonColor")
//        return button
//    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItems = [saveJobButton]
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
        DataManager.addJob(company: contentView.textFieldStackView.companyField.textFieldView.text ?? "none", role: contentView.textFieldStackView.roleField.textFieldView.text ?? "none", location: contentView.textFieldStackView.locationField.textFieldView.text ?? "none", status: contentView.selectStatusView.status, link: contentView.textFieldStackView.linkField.textFieldView.text ?? "none", notes: contentView.textFieldStackView.notesField.notesFieldView.text ?? "none")
        navigationController?.popViewController(animated: true)
    }
    
//    @objc func favoriteJob() {
//        //TODO: - Implement favorite jobs
//    }
    
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
        contentView.textFieldStackView.notesField.notesFieldView.delegate = self
    }
}

// MARK: - UITextFieldDelegate

extension AddJobViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

// MARK: - UITextViewDelegate

extension AddJobViewController: UITextViewDelegate {
    
}
