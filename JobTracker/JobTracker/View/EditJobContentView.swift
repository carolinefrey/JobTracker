//
//  EditJobContentView.swift
//  JobTracker
//
//  Created by Caroline Frey on 12/6/22.
//

import UIKit

class EditJobContentView: UIView {

    // MARK: - UI Properties

    var job: Job
    
    let title: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont(name: "Nunito-SemiBold", size: 26)
        title.textColor = UIColor(named: "Color4")
        title.text = "Edit job"
        return title
    }()
    
    let selectStatusView: SelectJobStatusView
    
    let textFieldStackView: TextFieldStackView
    
    lazy var deleteJobButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.role = .destructive
        button.setTitle("Delete job", for: .normal)
        return button
    }()
    
    // MARK: - Initializers

    init(job: Job) {
        self.job = job
        textFieldStackView = TextFieldStackView()
        selectStatusView = SelectJobStatusView(status: JobStatus(rawValue: job.status ?? "open") ?? .open)
        textFieldStackView.companyField.textFieldView.text = job.company
        textFieldStackView.roleField.textFieldView.text = job.role
        textFieldStackView.locationField.textFieldView.text = job.location
        textFieldStackView.linkField.textFieldView.text = job.link
        textFieldStackView.notesField.notesFieldView.text = job.notes
        
        super.init(frame: .zero)
        
        backgroundColor = UIColor(named: "Background")
        
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI Setup

    private func setUpViews() {
        textFieldStackView.translatesAutoresizingMaskIntoConstraints = false
        selectStatusView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(title)
        addSubview(selectStatusView)
        addSubview(textFieldStackView)
        addSubview(deleteJobButton)
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            title.heightAnchor.constraint(equalToConstant: 30),
            
            selectStatusView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 24),
            selectStatusView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            selectStatusView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            selectStatusView.heightAnchor.constraint(equalToConstant: 55),
            
            textFieldStackView.topAnchor.constraint(equalTo: selectStatusView.bottomAnchor, constant: 30),
            textFieldStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            textFieldStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            deleteJobButton.topAnchor.constraint(equalTo: textFieldStackView.bottomAnchor, constant: 20),
            deleteJobButton.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
}
