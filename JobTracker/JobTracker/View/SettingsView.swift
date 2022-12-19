//
//  SettingsView.swift
//  JobTracker
//
//  Created by Caroline Frey on 12/9/22.
//

import UIKit

class SettingsView: UIView {
    
    // MARK: - UserDefaults
    
    let defaults = UserDefaults.standard
    
    // MARK: - UI Properties
    
    private let screenTitle: UILabel = {
        let screenTitle = UILabel()
        screenTitle.translatesAutoresizingMaskIntoConstraints = false
        screenTitle.font = UIFont(name: "Nunito-SemiBold", size: 36)
        screenTitle.textColor = UIColor(named: "Color4")
        screenTitle.text = "Settings"
        screenTitle.textAlignment = .left
        return screenTitle
    }()
    
    lazy var saveSettingsButton: UIButton = {
        let config = UIImage.SymbolConfiguration(pointSize: 28)
        let icon = UIImage(systemName: "square.and.arrow.down", withConfiguration: config)
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(icon, for: .normal)
        button.tintColor = UIColor(named: "Color4")
        return button
    }()

    private let nameTitle: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont(name: "Nunito-Regular", size: 18)
        title.textColor = UIColor(named: "Color4")
        title.textAlignment = .left
        title.text = "Enter your name:"
        return title
    }()
    
    let textFieldView: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.backgroundColor = .white
        field.returnKeyType = .done
        field.layer.cornerRadius = 10
        field.font = UIFont(name: "Nunit-Regular", size: 18)
        field.textColor = UIColor(named: "Color4")
        field.setLeftPadding(10)
        field.setRightPadding(10)
        return field
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        backgroundColor = UIColor(named: "Background")
        textFieldView.text = defaults.string(forKey: "name")
        
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup

    private func setUpViews() {
        addSubview(screenTitle)
        addSubview(saveSettingsButton)
        addSubview(nameTitle)
        addSubview(textFieldView)
        
        NSLayoutConstraint.activate([
            screenTitle.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            screenTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            screenTitle.heightAnchor.constraint(equalToConstant: 40),
            
            saveSettingsButton.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            saveSettingsButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            nameTitle.topAnchor.constraint(equalTo: screenTitle.bottomAnchor, constant: 20),
            nameTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            textFieldView.topAnchor.constraint(equalTo: nameTitle.bottomAnchor, constant: 5),
            textFieldView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            textFieldView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            textFieldView.heightAnchor.constraint(equalToConstant: 45),
        ])
    }
}
