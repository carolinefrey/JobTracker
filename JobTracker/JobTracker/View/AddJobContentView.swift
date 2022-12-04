//
//  AddJobContentView.swift
//  JobTracker
//
//  Created by Caroline Frey on 11/30/22.
//

import UIKit

class AddJobContentView: UIView {

    // MARK: - UI Properties
    
    var viewTitle: String

    let title: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont(name: "Nunito-SemiBold", size: 26)
        title.textColor = UIColor(named: "Color4")
        //title.text = "Add a new job"
        return title
    }()
    
    let selectStatusView: SelectJobStatusView = {
        let view = SelectJobStatusView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let textFieldStackView: AddJobTextFieldStackView = {
        let stack = AddJobTextFieldStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // MARK: - Initializers

    init(viewTitle: String) {
        self.viewTitle = viewTitle
        super.init(frame: .zero)
        
        backgroundColor = UIColor(named: "Background")
        
        title.text = viewTitle
        
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI Setup

    private func setUpViews() {
        
        addSubview(title)
        addSubview(selectStatusView)
        addSubview(textFieldStackView)
        
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
            textFieldStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
