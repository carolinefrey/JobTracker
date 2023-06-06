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
        screenTitle.textColor = UIColor.black
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
        button.tintColor = UIColor.black
        return button
    }()

    private let nameTitleView: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont(name: "Nunito-Regular", size: 18)
        title.textColor = UIColor.black
        title.textAlignment = .left
        title.text = "Enter your name (optional):"
        return title
    }()
    
    let nameTextFieldView: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.backgroundColor = .white
        field.returnKeyType = .done
        field.layer.cornerRadius = 10
        field.font = UIFont(name: "Nunito-Regular", size: 18)
        field.textColor = UIColor.black
        field.setLeftPadding(10)
        field.setRightPadding(10)
        return field
    }()
    
    private let pinTitleView: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont(name: "Nunito-Regular", size: 18)
        title.textColor = UIColor.black
        title.textAlignment = .left
        title.text = "4-digit pin:"
        return title
    }()
    
    let pinTextFieldView: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.backgroundColor = .white
        field.keyboardType = .numberPad
        field.layer.cornerRadius = 10
        field.font = UIFont(name: "Nunito-Regular", size: 18)
        field.textColor = UIColor.black
        field.setLeftPadding(10)
        field.setRightPadding(10)
        return field
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        backgroundColor = UIColor.background
        nameTextFieldView.text = defaults.string(forKey: "name")
        pinTextFieldView.text = "\(defaults.integer(forKey: "pin"))"
        pinTextFieldView.delegate = self

        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup

    private func setUpViews() {
        addSubview(screenTitle)
        addSubview(saveSettingsButton)
        addSubview(pinTitleView)
        addSubview(pinTextFieldView)
        addSubview(nameTitleView)
        addSubview(nameTextFieldView)
        
        NSLayoutConstraint.activate([
            screenTitle.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            screenTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            screenTitle.heightAnchor.constraint(equalToConstant: 40),
            
            saveSettingsButton.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            saveSettingsButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            pinTitleView.topAnchor.constraint(equalTo: screenTitle.bottomAnchor, constant: 20),
            pinTitleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            pinTextFieldView.topAnchor.constraint(equalTo: pinTitleView.bottomAnchor, constant: 5),
            pinTextFieldView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            pinTextFieldView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            pinTextFieldView.heightAnchor.constraint(equalToConstant: 45),
            
            nameTitleView.topAnchor.constraint(equalTo: pinTextFieldView.bottomAnchor, constant: 20),
            nameTitleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            nameTextFieldView.topAnchor.constraint(equalTo: nameTitleView.bottomAnchor, constant: 5),
            nameTextFieldView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nameTextFieldView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            nameTextFieldView.heightAnchor.constraint(equalToConstant: 45),
        ])
    }
}

extension SettingsView: UITextFieldDelegate {
    //limit pin field to 4 characters
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        return updatedText.count <= 4
    }
}

