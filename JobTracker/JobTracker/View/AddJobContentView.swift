//
//  AddJobContentView.swift
//  JobTracker
//
//  Created by Caroline Frey on 11/30/22.
//

import UIKit

class AddJobContentView: UIView {

    // MARK: - UI Properties
    
    let title: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont(name: "Nunito-SemiBold", size: 26)
        title.textColor = UIColor(named: "Color4")
        title.text = "Add a new job"
        return title
    }()
    
    let selectStatusView: SelectJobStatusView = {
        let view = SelectJobStatusView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        
        addSubview(title)
        addSubview(selectStatusView)
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            selectStatusView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 24),
            selectStatusView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            selectStatusView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            selectStatusView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
