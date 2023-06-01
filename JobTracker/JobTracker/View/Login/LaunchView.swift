//
//  LaunchView.swift
//  JobTracker
//
//  Created by Caroline Frey on 5/31/23.
//

import UIKit

class LaunchView: UIView {
    
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
    
    let loginButtonView: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: "LaunchScreenTextColor")
        button.setTitle("Login", for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    
    let signUpButtonView: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor(named: "LaunchScreenTextColor"), for: .normal)
        button.setTitle("Create account", for: .normal)
        return button
    }()

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(named: "Background")
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    
    // MARK: - UI Setup
    
    private func setUpViews() {
        addSubview(appIcon)
        addSubview(appNameLabel)
        addSubview(loginButtonView)
        addSubview(signUpButtonView)
                        
        NSLayoutConstraint.activate([
            appIcon.centerXAnchor.constraint(equalTo: centerXAnchor),
            appIcon.centerYAnchor.constraint(equalTo: centerYAnchor),
            appIcon.heightAnchor.constraint(equalToConstant: 148),
            appIcon.widthAnchor.constraint(equalToConstant: 150),
            
            loginButtonView.topAnchor.constraint(equalTo: appIcon.bottomAnchor, constant: 20),
            loginButtonView.centerXAnchor.constraint(equalTo: centerXAnchor),
            loginButtonView.widthAnchor.constraint(equalToConstant: 70),
            
            signUpButtonView.topAnchor.constraint(equalTo: loginButtonView.bottomAnchor, constant: 5),
            signUpButtonView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            appNameLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            appNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
}
