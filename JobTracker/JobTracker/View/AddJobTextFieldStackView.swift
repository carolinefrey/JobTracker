//
//  AddJobTextFieldStackView.swift
//  JobTracker
//
//  Created by Caroline Frey on 12/1/22.
//

import UIKit

class AddJobTextFieldStackView: UIView {

    // MARK: - UI Properties
    
    private let textFieldStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillProportionally
        stack.spacing = 5
        stack.axis = .vertical
        return stack
    }()
    
    let companyField: AddJobTextFieldView = {
        let company = AddJobTextFieldView(textFieldTitle: "company")
        company.translatesAutoresizingMaskIntoConstraints = false
        return company
    }()
    
    let roleField: AddJobTextFieldView = {
        let company = AddJobTextFieldView(textFieldTitle: "role")
        company.translatesAutoresizingMaskIntoConstraints = false
        return company
    }()
    
    let teamField: AddJobTextFieldView = {
        let company = AddJobTextFieldView(textFieldTitle: "team")
        company.translatesAutoresizingMaskIntoConstraints = false
        return company
    }()
    
    let locationField: AddJobTextFieldView = {
        let company = AddJobTextFieldView(textFieldTitle: "location")
        company.translatesAutoresizingMaskIntoConstraints = false
        return company
    }()
    
    let linkField: AddJobTextFieldView = {
        let company = AddJobTextFieldView(textFieldTitle: "link")
        company.translatesAutoresizingMaskIntoConstraints = false
        return company
    }()
    
    let notesField: AddJobTextFieldView = {
        let company = AddJobTextFieldView(textFieldTitle: "notes")
        company.translatesAutoresizingMaskIntoConstraints = false
        return company
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI Setup
    
    private func setUpViews() {
        
        addSubview(textFieldStackView)
        
        textFieldStackView.addArrangedSubview(companyField)
        textFieldStackView.addArrangedSubview(roleField)
        textFieldStackView.addArrangedSubview(teamField)
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
