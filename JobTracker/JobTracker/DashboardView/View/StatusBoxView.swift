//
//  StatusBoxView.swift
//  JobTracker
//
//  Created by Caroline Frey on 11/29/22.
//

import UIKit

protocol StatusBoxViewDelegate: AnyObject {
    func tapStatusBox(_ sender: UIButton)
}

class StatusBoxView: UIView {
        
    // MARK: - UI Properties
    
    weak var delegate: StatusBoxViewDelegate?
    
    let status: String
       
    lazy var box: UIButton = {
        let box = UIButton()
        box.translatesAutoresizingMaskIntoConstraints = false
        box.clipsToBounds = true
        box.layer.cornerRadius = 20
        box.backgroundColor = UIColor.statusBoxBackground
        box.addTarget(self, action: #selector(filterJobs(sender:)), for: .touchUpInside)
        return box
    }()
    
    let statusLabel: UILabel = {
        let statusLabel = UILabel()
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.textAlignment = .center
        statusLabel.font = UIFont(name: "Nunito-SemiBold", size: 14)
        statusLabel.text = ""
        statusLabel.textColor = .green
        
        return statusLabel
    }()
    
    let countLabel: UILabel = {
        let count = UILabel()
        count.translatesAutoresizingMaskIntoConstraints = false
        count.textAlignment = .center
        count.font = UIFont(name: "Nunito-SemiBold", size: 20)
        count.text = "3"
        return count
    }()

    // MARK: - Initializers
    
    init(status: JobStatus) {
        self.status = status.rawValue
        statusLabel.text = self.status
        
        switch status {
        case .open:
            statusLabel.textColor = UIColor.openStatusLabel
            countLabel.textColor = UIColor.openStatusLabel
        case .applied:
            statusLabel.textColor = UIColor.appliedStatusLabel
            countLabel.textColor = UIColor.appliedStatusLabel
        case .interview:
            statusLabel.textColor = UIColor.interviewStatusLabel
            countLabel.textColor = UIColor.interviewStatusLabel
        case .closed:
            statusLabel.textColor = .darkGray
            countLabel.textColor = .darkGray
        }
        
        super.init(frame: .zero)
        
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    
    @objc func filterJobs(sender: UIButton) {
        delegate?.tapStatusBox(sender)
    }
    
    // MARK: - UI Setup

    private func setUpViews() {
        box.addSubview(statusLabel)
        box.addSubview(countLabel)
        
        addSubview(box)
        addSubview(statusLabel)
        addSubview(countLabel)
        
        NSLayoutConstraint.activate([
            box.topAnchor.constraint(equalTo: topAnchor),
            box.leadingAnchor.constraint(equalTo: leadingAnchor),
            box.trailingAnchor.constraint(equalTo: trailingAnchor),
            box.bottomAnchor.constraint(equalTo: bottomAnchor),
            box.heightAnchor.constraint(equalToConstant: 76),
            box.widthAnchor.constraint(equalToConstant: 76),
            
            statusLabel.centerXAnchor.constraint(equalTo: box.centerXAnchor),
            statusLabel.topAnchor.constraint(equalTo: box.topAnchor, constant: 16),
            
            countLabel.centerXAnchor.constraint(equalTo: box.centerXAnchor),
            countLabel.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 5),
        ])
    }
}
