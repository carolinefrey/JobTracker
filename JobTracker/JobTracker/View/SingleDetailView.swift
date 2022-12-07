//
//  SingleDetailView.swift
//  JobTracker
//
//  Created by Caroline Frey on 12/2/22.
//

import UIKit

class SingleDetailView: UIView {
    
    // MARK: - UI Properties
    
    var job: Job
    var detail: Detail
    var showStatusBox = false
    
    private var detailTitleLabel: UILabel = {
        let detailLabel = UILabel()
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        detailLabel.textAlignment = .left
        detailLabel.font = UIFont(name: "Nunito-SemiBold", size: 14)
        detailLabel.textColor = UIColor(named: "Color4")
        return detailLabel
    }()
    
    var detailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = UIColor(named: "Color4")
        return label
    }()
    
    var statusBox: UIView = {
        let box = UIView()
        box.translatesAutoresizingMaskIntoConstraints = false
        box.layer.cornerRadius = 10
        return box
    }()
    
    // MARK: - Initializers
    
    init(job: Job, detail: Detail) {
        self.job = job
        self.detail = detail
        
        detailTitleLabel.text = detail.rawValue
        
        if detail == .status {
            showStatusBox = true
        }
        
        super.init(frame: .zero)
        
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    
    private func setUpViews() {
        switch detail {
        case .status:
            detailLabel.font = UIFont(name: "Nunito-SemiBold", size: 26)
            detailLabel.text = job.status?.capitalized
            let status = JobStatus(rawValue: job.status ?? "open")
            setStatusBoxColor(status: status ?? .open)
        case .company:
            detailLabel.font = UIFont(name: "Nunito-SemiBold", size: 26)
            detailLabel.text = job.company
        case .role:
            detailLabel.font = UIFont(name: "Nunito-SemiBold", size: 26)
            detailLabel.text = job.role
        case .location:
            detailLabel.font = UIFont(name: "Nunito-SemiBold", size: 26)
            detailLabel.text = job.location
        case .link:
            //TODO: format link
            detailLabel.font = UIFont(name: "Nunito-Regular", size: 20)
            detailLabel.text = job.link
        case .notes:
            detailLabel.font = UIFont(name: "Nunito-Regular", size: 20)
            detailLabel.text = job.notes
        }
        
        addSubview(detailTitleLabel)
        
        if showStatusBox == true {
            configureStatusBoxStack()
        } else {
            configureStandardDetailLabel()
        }
        
        NSLayoutConstraint.activate([
            detailTitleLabel.topAnchor.constraint(equalTo: topAnchor),
            detailTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
        ])
    }
    
    // MARK: - Functions
    private func configureStatusBoxStack() {
        addSubview(statusBox)
        addSubview(detailLabel)
        
        NSLayoutConstraint.activate([
            statusBox.topAnchor.constraint(equalTo: detailTitleLabel.bottomAnchor, constant: 5),
            statusBox.leadingAnchor.constraint(equalTo: leadingAnchor),
            statusBox.heightAnchor.constraint(equalToConstant: 25),
            statusBox.widthAnchor.constraint(equalToConstant: 25),
            
            detailLabel.topAnchor.constraint(equalTo: statusBox.topAnchor),
            detailLabel.leadingAnchor.constraint(equalTo: statusBox.trailingAnchor, constant: 5),
            detailLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            detailLabel.centerYAnchor.constraint(equalTo: statusBox.centerYAnchor),
        ])
    }
    
    private func configureStandardDetailLabel() {
        addSubview(detailLabel)

        NSLayoutConstraint.activate([
            detailLabel.topAnchor.constraint(equalTo: detailTitleLabel.bottomAnchor, constant: 5),
            detailLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            detailLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            detailLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            //detailLabel.heightAnchor.constraint(equalToConstant: 45),
        ])
    }
    
    func setStatusBoxColor(status: JobStatus) {
        switch status {
        case .open:
            statusBox.backgroundColor = UIColor(named: "OpenStatus")
        case .applied:
            statusBox.backgroundColor = UIColor(named: "AppliedStatus")
        case .interview:
            statusBox.backgroundColor = UIColor(named: "InterviewStatus")
        case .closed:
            statusBox.backgroundColor = .darkGray
        }
    }
}

