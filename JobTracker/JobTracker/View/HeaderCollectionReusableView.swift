//
//  HeaderCollectionReusableView.swift
//  JobTracker
//
//  Created by Caroline Frey on 1/9/23.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
    
    // MARK: - UI Properties
    
    static let identifier = "HeaderCollectionReusableView"
    
    lazy var addNewJobButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular, scale: .large)
        let buttonSymbol = UIImage(systemName: "plus", withConfiguration: largeConfig)
        button.setImage(buttonSymbol, for: .normal)
        button.tintColor = .black
        return button
    }()
    
    // MARK: - UI Setup

    public func configure() {
        addSubview(addNewJobButton)
        
        NSLayoutConstraint.activate([
            addNewJobButton.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            addNewJobButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
        ])
    }
}
