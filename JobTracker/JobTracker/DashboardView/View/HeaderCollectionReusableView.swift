//
//  HeaderCollectionReusableView.swift
//  JobTracker
//
//  Created by Caroline Frey on 1/9/23.
//

import UIKit

protocol HeaderCollectionReusableViewDelegate: AnyObject {
    func tapAddNewJobButton()
    func tapDeleteTasksButton()
    func tapFavoritesFilterButton(button: UIButton)
    func tapDoneButton()
    func batchDeleteJobs()
}

class HeaderCollectionReusableView: UICollectionReusableView {
    
    // MARK: - Class Properties

    static let identifier = "HeaderCollectionReusableView"
    
    weak var headerCollectionViewDelegate: HeaderCollectionReusableViewDelegate?
    
    // MARK: - UI Properties
    
    var menu = UIMenu()
    
    lazy var filterByFavoritesButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "view favorites"
        config.buttonSize = .small
        config.image = UIImage(systemName: "heart")
        config.imagePlacement = .leading
        config.imagePadding = 5
        config.baseBackgroundColor = UIColor(named: "FavoriteButtonColor")
        config.baseForegroundColor = .black
        
        let button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(filterbyFavorites), for: .touchUpInside)
        return button
    }()
    
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
    
    lazy var headerMenuButton: UIButton = {
        let icon = UIImage(systemName: "ellipsis.circle", withConfiguration: UIImage.SymbolConfiguration(textStyle: .title1))
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(icon, for: .normal)
        button.showsMenuAsPrimaryAction = true
        button.tintColor = .black
        return button
    }()
    
    lazy var doneButtonView: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Done", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var batchDeleteJobsButtonView: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular, scale: .large)
        let buttonSymbol = UIImage(systemName: "trash", withConfiguration: largeConfig)
        button.setImage(buttonSymbol, for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(batchDeleteJobsButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Selector Functions
    
    @objc func addNewJob(_ sender: UIButton) {
        headerCollectionViewDelegate?.tapAddNewJobButton()
    }
    
    @objc func editJobs() {
        headerCollectionViewDelegate?.tapDeleteTasksButton()
    }
    
    @objc func filterbyFavorites(_ sender: UIButton) {
        headerCollectionViewDelegate?.tapFavoritesFilterButton(button: sender)
    }
    
    @objc func doneButtonTapped() {
        headerCollectionViewDelegate?.tapDoneButton()
    }
    
    @objc func batchDeleteJobsButtonTapped() {
        headerCollectionViewDelegate?.batchDeleteJobs()
    }
    
    // MARK: - UI Setup

    public func configure(editMode: Bool) {
        if editMode {
            filterByFavoritesButton.removeFromSuperview()
            addNewJobButton.removeFromSuperview()
            headerMenuButton.removeFromSuperview()
            
            addSubview(doneButtonView)
            addSubview(batchDeleteJobsButtonView)
            
            NSLayoutConstraint.activate([
                doneButtonView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
                doneButtonView.trailingAnchor.constraint(equalTo: batchDeleteJobsButtonView.leadingAnchor, constant: -20),
                
                batchDeleteJobsButtonView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
                batchDeleteJobsButtonView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
            ])
        } else {
            doneButtonView.removeFromSuperview()
            batchDeleteJobsButtonView.removeFromSuperview()
            
            addSubview(filterByFavoritesButton)
            addSubview(addNewJobButton)
            addSubview(headerMenuButton)
            configureHeaderMenu()
            
            NSLayoutConstraint.activate([
                filterByFavoritesButton.topAnchor.constraint(equalTo: topAnchor, constant: 20),
                filterByFavoritesButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
                
                addNewJobButton.topAnchor.constraint(equalTo: topAnchor, constant: 20),
                addNewJobButton.trailingAnchor.constraint(equalTo: headerMenuButton.leadingAnchor, constant: -5),
                
                headerMenuButton.topAnchor.constraint(equalTo: topAnchor, constant: 20),
                headerMenuButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            ])
        }
    }
    
    func configureHeaderMenu() {
        var menuItems: [UIAction] = []
        
        let deleteTasksAction = UIAction(title: "Select Tasks", image: UIImage(systemName: "checkmark.circle"), handler: { _ in
            self.headerCollectionViewDelegate?.tapDeleteTasksButton()
        })
        
        menuItems.append(deleteTasksAction)
        menu = UIMenu(title: "", options: [.displayInline], children: menuItems)
        headerMenuButton.menu = menu
    }
}
