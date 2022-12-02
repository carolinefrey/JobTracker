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
        let company = AddJobTextFieldView(textFieldTitle: "company", textFieldHeight: 45)
        company.translatesAutoresizingMaskIntoConstraints = false
        return company
    }()
    
    let roleField: AddJobTextFieldView = {
        let role = AddJobTextFieldView(textFieldTitle: "role", textFieldHeight: 45)
        role.translatesAutoresizingMaskIntoConstraints = false
        return role
    }()
    
    let teamField: AddJobTextFieldView = {
        let team = AddJobTextFieldView(textFieldTitle: "team", textFieldHeight: 45)
        team.translatesAutoresizingMaskIntoConstraints = false
        return team
    }()
    
    let locationField: AddJobTextFieldView = {
        let location = AddJobTextFieldView(textFieldTitle: "location", textFieldHeight: 45)
        location.translatesAutoresizingMaskIntoConstraints = false
        return location
    }()
    
    let linkField: AddJobTextFieldView = {
        let link = AddJobTextFieldView(textFieldTitle: "link", textFieldHeight: 45)
        link.translatesAutoresizingMaskIntoConstraints = false
        return link
    }()
    
    let notesField: AddJobTextFieldView = {
        let notes = AddJobTextFieldView(textFieldTitle: "notes", textFieldHeight: 75)
        notes.translatesAutoresizingMaskIntoConstraints = false
        return notes
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
