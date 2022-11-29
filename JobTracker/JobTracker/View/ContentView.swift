//
//  ContentView.swift
//  JobTracker
//
//  Created by Caroline Frey on 11/28/22.
//

import UIKit

class ContentView: UIView {
    
    // MARK: - UI Properties
    
    var jobs = [Job]()
    
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
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            headerView.heightAnchor.constraint(equalToConstant: 80),
            
            statusBoxes.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            statusBoxes.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
}
