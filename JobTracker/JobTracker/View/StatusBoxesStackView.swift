//
//  StatusBoxesStackView.swift
//  JobTracker
//
//  Created by Caroline Frey on 11/29/22.
//

import UIKit

class StatusBoxesStackView: UIView {

    // MARK: - UI Properties

    let openStatusBox: StatusBoxView = {
        let box = StatusBoxView(status: .open)
        box.translatesAutoresizingMaskIntoConstraints = false
        return box
    }()
    
    let appliedStatusBox: StatusBoxView = {
        let box = StatusBoxView(status: .applied)
        box.translatesAutoresizingMaskIntoConstraints = false
        return box
    }()
    
    let interviewStatusBox: StatusBoxView = {
        let box = StatusBoxView(status: .interview)
        box.translatesAutoresizingMaskIntoConstraints = false
        return box
    }()
    
    let closedStatusBox: StatusBoxView = {
        let box = StatusBoxView(status: .closed)
        box.translatesAutoresizingMaskIntoConstraints = false
        return box
    }()
    
    let statusBoxStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .equalSpacing
        stack.spacing = 10
        stack.axis = .horizontal
        return stack
    }()
    
    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
                
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup

    private func setUpViews() {
        
        addSubview(statusBoxStack)
        
        statusBoxStack.addArrangedSubview(openStatusBox)
        statusBoxStack.addArrangedSubview(appliedStatusBox)
        statusBoxStack.addArrangedSubview(interviewStatusBox)
        statusBoxStack.addArrangedSubview(closedStatusBox)

        NSLayoutConstraint.activate([
            statusBoxStack.topAnchor.constraint(equalTo: topAnchor),
            statusBoxStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            statusBoxStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            statusBoxStack.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
