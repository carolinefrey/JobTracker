//
//  AddJobTextFieldStackView.swift
//  JobTracker
//
//  Created by Caroline Frey on 12/1/22.
//

import UIKit

class TextFieldStackView: UIView {
    
    // MARK: - UI Properties
    
    private let textFieldStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillProportionally
        stack.spacing = 15
        stack.axis = .vertical
        return stack
    }()
    
    var companyField: TextFieldView
    var roleField: TextFieldView
    var locationField: TextFieldView
    var linkField: TextFieldView
    var notesField: NotesFieldView
    var dateAppliedField: DateFieldView
    
    // MARK: - Initializers
    
    init() {
        companyField = TextFieldView(textFieldTitle: "company", textFieldHeight: 45, autoCap: true)
        roleField = TextFieldView(textFieldTitle: "role", textFieldHeight: 45, autoCap: true)
        locationField = TextFieldView(textFieldTitle: "location", textFieldHeight: 45, autoCap: true)
        linkField = TextFieldView(textFieldTitle: "link", textFieldHeight: 45, autoCap: false)
        notesField = NotesFieldView()
        dateAppliedField = DateFieldView()

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
        dateAppliedField.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(textFieldStackView)
        
        textFieldStackView.addArrangedSubview(companyField)
        textFieldStackView.addArrangedSubview(roleField)
        textFieldStackView.addArrangedSubview(locationField)
        textFieldStackView.addArrangedSubview(linkField)
        textFieldStackView.addArrangedSubview(notesField)
        textFieldStackView.addArrangedSubview(dateAppliedField)
        
        NSLayoutConstraint.activate([
            textFieldStackView.topAnchor.constraint(equalTo: topAnchor),
            textFieldStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            textFieldStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            textFieldStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            companyField.heightAnchor.constraint(equalToConstant: 65),
            roleField.heightAnchor.constraint(equalToConstant: 65),
            locationField.heightAnchor.constraint(equalToConstant: 65),
            linkField.heightAnchor.constraint(equalToConstant: 65),
            notesField.heightAnchor.constraint(equalToConstant: 95),
            dateAppliedField.heightAnchor.constraint(equalToConstant: 95)
        ])
    }
    
}
