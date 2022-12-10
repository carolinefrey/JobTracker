//
//  ContentView.swift
//  JobTracker
//
//  Created by Caroline Frey on 11/28/22.
//

import UIKit

class DashboardContentView: UIView {
    
    // MARK: - UI Properties
        
    let headerView: HeaderView = {
        let view = HeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let statusBoxes: StatusBoxesStackView = {
        let stack = StatusBoxesStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 150, height: 150)
        layout.sectionInset = UIEdgeInsets(top: 24, left: 30, bottom: 24, right: 30)
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(DashboardCollectionViewCell.self, forCellWithReuseIdentifier: DashboardCollectionViewCell.dashboardCollectionViewCellIdentifier)
        collection.layer.cornerRadius = 20
        return collection
    }()
    
    //MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(named: "Background")
        
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    
    private func setUpViews() {
        addSubview(headerView)
        addSubview(statusBoxes)
        addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            headerView.heightAnchor.constraint(equalToConstant: 80),
            
            statusBoxes.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            statusBoxes.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            collectionView.topAnchor.constraint(equalTo: statusBoxes.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
