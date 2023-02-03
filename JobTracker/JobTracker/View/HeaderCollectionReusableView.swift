//
//  HeaderCollectionReusableView.swift
//  JobTracker
//
//  Created by Caroline Frey on 1/9/23.
//

import UIKit

protocol HeaderCollectionReusableViewDelegate: AnyObject {
    func tapAddNewJobButton()
}

protocol FilterByFavoritesDelegate: AnyObject {
    func tapFilterButton(button: UIButton)
}

class HeaderCollectionReusableView: UICollectionReusableView {
    
    // MARK: - UI Properties
    
    static let identifier = "HeaderCollectionReusableView"
    
    weak var newJobDelegate: HeaderCollectionReusableViewDelegate?
    weak var filterByFavoritesDelegate: FilterByFavoritesDelegate?
    
    lazy var addNewJobButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular, scale: .large)
        let buttonSymbol = UIImage(systemName: "plus", withConfiguration: largeConfig)
        button.setImage(buttonSymbol, for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(addNewJob), for: .touchUpInside)
        return button
    }()
    
    lazy var filterByFavoritesButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular, scale: .large)
        let buttonSymbol = UIImage(systemName: "heart", withConfiguration: largeConfig)
        button.setImage(buttonSymbol, for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(filterbyFavorites), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Selector Functions
    
    @objc func addNewJob(_ sender: UIButton) {
        newJobDelegate?.tapAddNewJobButton()
    }
    
    @objc func filterbyFavorites(_ sender: UIButton) {
        filterByFavoritesDelegate?.tapFilterButton(button: sender)
    }
    
    // MARK: - UI Setup

    public func configure() {
        addSubview(filterByFavoritesButton)
        addSubview(addNewJobButton)
        
        NSLayoutConstraint.activate([
            filterByFavoritesButton.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            filterByFavoritesButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            addNewJobButton.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            addNewJobButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
        ])
    }
}
