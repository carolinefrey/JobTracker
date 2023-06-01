//
//  LaunchView.swift
//  JobTracker
//
//  Created by Caroline Frey on 5/31/23.
//

import UIKit

protocol LoginDelegate: AnyObject {
    func loginButtonTapped()
    func createPINButtonTapped()
}

class LaunchView: UIView {
    
    // MARK: - Class Properties
    
    var loginDelegate: LoginDelegate?
    
    // MARK: - UI Properties
    
    let appIcon: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(systemName: "briefcase.circle", withConfiguration: UIImage.SymbolConfiguration(scale: .large))
        view.tintColor = UIColor(named: "LaunchScreenTextColor")
        return view
    }()
    
    let appNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Nunito-Regular", size: 26)
        label.textColor = UIColor(named: "LaunchScreenTextColor")
        label.text = "JobApp Tracker"
        return label
    }()
    
    let pinEntryField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.backgroundColor = .white
        field.keyboardType = .numberPad
        field.layer.cornerRadius = 10
        field.font = UIFont(name: "Nunito-Regular", size: 18)
        field.textColor = UIColor(named: "Color4")
        field.placeholder = "4-digit PIN"
        field.setLeftPadding(10)
        field.setRightPadding(10)
        return field
    }()
    
    lazy var loginButtonView: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor(named: "LaunchScreenTextColor"), for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    
    lazy var keyboardToolbar: UIToolbar = {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissKeyboard))
        keyboardToolbar.setItems([flexible, doneBarButton], animated: false)
        return keyboardToolbar
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(named: "Background")
        layoutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    
    @objc func login() {
        loginDelegate?.loginButtonTapped()
    }
    
    @objc func createPIN() {
        loginDelegate?.createPINButtonTapped()
    }
    
    @objc func dismissKeyboard() {
        pinEntryField.endEditing(true)
    }
    
    // MARK: - UI Setup
    
    func configureFirstLaunch() {
        pinEntryField.placeholder = "Set a 4-digit pin"
        loginButtonView.setTitle("Create PIN", for: .normal)
        loginButtonView.addTarget(self, action: #selector(createPIN), for: .touchUpInside)
    }
    
    func configureSubsequentLaunches() {
        pinEntryField.placeholder = "4-digit pin"
        loginButtonView.setTitle("Login", for: .normal)
        loginButtonView.addTarget(self, action: #selector(login), for: .touchUpInside)
    }
    
    private func layoutViews() {
        addSubview(appIcon)
        addSubview(appNameLabel)
        addSubview(pinEntryField)
        addSubview(loginButtonView)
        
        pinEntryField.inputAccessoryView = keyboardToolbar
        
        NSLayoutConstraint.activate([
            appIcon.centerXAnchor.constraint(equalTo: centerXAnchor),
            appIcon.topAnchor.constraint(equalTo: topAnchor, constant: 200),
            appIcon.heightAnchor.constraint(equalToConstant: 148),
            appIcon.widthAnchor.constraint(equalToConstant: 150),
            
            pinEntryField.topAnchor.constraint(equalTo: appIcon.bottomAnchor, constant: 20),
            pinEntryField.centerXAnchor.constraint(equalTo: centerXAnchor),
            pinEntryField.heightAnchor.constraint(equalToConstant: 50),
            pinEntryField.widthAnchor.constraint(equalToConstant: 150),
            
            loginButtonView.topAnchor.constraint(equalTo: pinEntryField.bottomAnchor, constant: 5),
            loginButtonView.centerXAnchor.constraint(equalTo: centerXAnchor),
            loginButtonView.widthAnchor.constraint(equalToConstant: 100),
            
            appNameLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            appNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
}
