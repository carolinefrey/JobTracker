//
//  JobSearchView.swift
//  JobTracker
//
//  Created by Caroline Frey on 6/16/23.
//

import UIKit

class JobSearchView: UIView {

    // MARK: - UI Properties
    
    let title: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont(name: "Nunito-SemiBold", size: 26)
        title.textColor = UIColor.black
        title.text = "Search jobs"
        return title
    }()
    
    let textFieldView: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.backgroundColor = .white
        field.returnKeyType = .done
        field.layer.cornerRadius = 10
        field.font = UIFont(name: "Nunito-Regular", size: 14)
        field.textColor = UIColor.black
        field.setLeftPadding(10)
        field.setRightPadding(10)
        return field
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = UIColor.background
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup

    private func setUpViews() {
        addSubview(title)
        addSubview(textFieldView)
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            title.heightAnchor.constraint(equalToConstant: 30),
            
            textFieldView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 20),
            textFieldView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            textFieldView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            textFieldView.heightAnchor.constraint(equalToConstant: 45),
        ])
    }
}
