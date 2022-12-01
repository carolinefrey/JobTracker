//
//  AddJobTextFieldView.swift
//  JobTracker
//
//  Created by Caroline Frey on 12/1/22.
//

import UIKit

class AddJobTextFieldView: UIView {
    
    // MARK: - UI Properties

    var textFieldTitle: String
    
    private let titleView: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont(name: "Nunito-Light", size: 12)
        title.textColor = UIColor(named: "Color4")
        title.textAlignment = .left
        return title
    }()
    
    let textFieldView: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.backgroundColor = .white
        return field
    }()
    
    // MARK: - Initializers
    
    init(textFieldTitle: String) {
        self.textFieldTitle = textFieldTitle
        titleView.text = textFieldTitle
    
        super.init(frame: .zero)

        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI Setup
    
    private func setUpViews() {
        
        addSubview(titleView)
        addSubview(textFieldView)
        
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: topAnchor),
            titleView.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            textFieldView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 5),
            textFieldView.leadingAnchor.constraint(equalTo: leadingAnchor),
            textFieldView.trailingAnchor.constraint(equalTo: trailingAnchor),
            textFieldView.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
}
