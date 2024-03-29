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
        layout.headerReferenceSize = CGSize(width: frame.size.width, height: 45)
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(DashboardCollectionViewCell.self, forCellWithReuseIdentifier: DashboardCollectionViewCell.dashboardCollectionViewCellIdentifier)
        collection.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier)
        collection.layer.cornerRadius = 30
        collection.backgroundColor = .white
        return collection
    }()
    
    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.background
        
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    
    func configureStatusButtonAppearance(state: StatusButtonState, forStatus status: JobStatus) {
        switch state {
        case .normal:
            switch status {
            case .open:                
                statusBoxes.openStatusBox.box.backgroundColor = UIColor.statusBoxBackground
                statusBoxes.openStatusBox.statusLabel.textColor = UIColor.openStatusLabel
                statusBoxes.openStatusBox.countLabel.textColor = UIColor.openStatusLabel
            case .applied:
                statusBoxes.appliedStatusBox.box.backgroundColor = UIColor.statusBoxBackground
                statusBoxes.appliedStatusBox.statusLabel.textColor = UIColor.appliedStatusLabel
                statusBoxes.appliedStatusBox.countLabel.textColor = UIColor.appliedStatusLabel
            case .interview:
                statusBoxes.interviewStatusBox.box.backgroundColor = UIColor.statusBoxBackground
                statusBoxes.interviewStatusBox.statusLabel.textColor = UIColor.interviewStatusLabel
                statusBoxes.interviewStatusBox.countLabel.textColor = UIColor.interviewStatusLabel
            case .closed:
                statusBoxes.closedStatusBox.box.backgroundColor = UIColor.statusBoxBackground
                statusBoxes.closedStatusBox.statusLabel.textColor = .darkGray
                statusBoxes.closedStatusBox.countLabel.textColor = .darkGray
            }
        case .selected:
            switch status {
            case .open:
                statusBoxes.openStatusBox.box.backgroundColor = UIColor.openStatus
                statusBoxes.openStatusBox.statusLabel.textColor = .black
                statusBoxes.openStatusBox.countLabel.textColor = .black
            case .applied:
                statusBoxes.appliedStatusBox.box.backgroundColor = UIColor.appliedStatus
                statusBoxes.appliedStatusBox.statusLabel.textColor = .black
                statusBoxes.appliedStatusBox.countLabel.textColor = .black
            case .interview:
                statusBoxes.interviewStatusBox.box.backgroundColor = UIColor.interviewStatus
                statusBoxes.interviewStatusBox.statusLabel.textColor = .black
                statusBoxes.interviewStatusBox.countLabel.textColor = .black
            case .closed:
                statusBoxes.closedStatusBox.box.backgroundColor = .darkGray
                statusBoxes.closedStatusBox.statusLabel.textColor = .white
                statusBoxes.closedStatusBox.countLabel.textColor = .white
            }
        }
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
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
