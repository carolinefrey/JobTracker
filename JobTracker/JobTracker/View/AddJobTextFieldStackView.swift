//
//  AddJobTextFieldStackView.swift
//  JobTracker
//
//  Created by Caroline Frey on 12/1/22.
//

import UIKit

class AddJobTextFieldStackView: UIView {

    // MARK: - UI Properties
    
    var editView: Bool
    var job: Job
    
    private let textFieldStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillProportionally
        stack.spacing = 5
        stack.axis = .vertical
        return stack
    }()
    
    var companyField: AddJobTextFieldView
    var roleField: AddJobTextFieldView
    var locationField: AddJobTextFieldView
    var linkField: AddJobTextFieldView
    var notesField: AddJobTextFieldView
    
    // MARK: - Initializers
    
    init(editView: Bool, job: Job) {
        self.editView = editView
        self.job = job
        
        if !editView {
            companyField = AddJobTextFieldView(textFieldTitle: "company", textFieldHeight: 45)
            roleField = AddJobTextFieldView(textFieldTitle: "role", textFieldHeight: 45)
            locationField = AddJobTextFieldView(textFieldTitle: "location", textFieldHeight: 45)
            linkField = AddJobTextFieldView(textFieldTitle: "link", textFieldHeight: 45)
            notesField = AddJobTextFieldView(textFieldTitle: "notes", textFieldHeight: 75)
        } else {
            companyField = AddJobTextFieldView(textFieldTitle: "company", textFieldHeight: 45, prefill: job.company ?? "")
            roleField = AddJobTextFieldView(textFieldTitle: "role", textFieldHeight: 45, prefill: job.role ?? "")
            locationField = AddJobTextFieldView(textFieldTitle: "location", textFieldHeight: 45, prefill: job.location ?? "")
            linkField = AddJobTextFieldView(textFieldTitle: "link", textFieldHeight: 45, prefill: job.link ?? "")
            notesField = AddJobTextFieldView(textFieldTitle: "notes", textFieldHeight: 75, prefill: job.notes ?? "")
        }
        
        super.init(frame: .zero)
        
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI Setup
    
    private func setUpViews() {
        
        companyField.translatesAutoresizingMaskIntoConstraints = false
        roleField.translatesAutoresizingMaskIntoConstraints = false
        locationField.translatesAutoresizingMaskIntoConstraints = false
        linkField.translatesAutoresizingMaskIntoConstraints = false
        notesField.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(textFieldStackView)
        
        textFieldStackView.addArrangedSubview(companyField)
        textFieldStackView.addArrangedSubview(roleField)
        textFieldStackView.addArrangedSubview(locationField)
        textFieldStackView.addArrangedSubview(linkField)
        textFieldStackView.addArrangedSubview(notesField)
        
        NSLayoutConstraint.activate([
            textFieldStackView.topAnchor.constraint(equalTo: topAnchor),
            textFieldStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            textFieldStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            textFieldStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }

}
