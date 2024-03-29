//
//  SingleDetailView.swift
//  JobTracker
//
//  Created by Caroline Frey on 12/2/22.
//

import UIKit

class SingleDetailView: UIView {
    
    let viewModel = AddEditViewModel()

    // MARK: - UI Properties
    
    var job: Job
    var detail: JobDetail
    var showStatusBox = false
    
    private var detailTitleLabel: UILabel = {
        let detailLabel = UILabel()
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        detailLabel.textAlignment = .left
        detailLabel.font = UIFont(name: "Nunito-SemiBold", size: 14)
        detailLabel.textColor = UIColor.black
        return detailLabel
    }()
    
    var detailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.sizeToFit()
        label.textAlignment = .left
        label.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        return label
    }()
    
    var statusBox: UIView = {
        let box = UIView()
        box.translatesAutoresizingMaskIntoConstraints = false
        box.layer.cornerRadius = 10
        return box
    }()
    
    // MARK: - Initializers
    
    init(job: Job, detail: JobDetail) {
        self.job = job
        self.detail = detail
        
        detailTitleLabel.text = viewModel.configureDetailLabelText(forDetail: detail)

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
        addSubview(detailTitleLabel)
        
        NSLayoutConstraint.activate([
            detailTitleLabel.topAnchor.constraint(equalTo: topAnchor),
            detailTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            detailTitleLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
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
            detailLabel.font = UIFont(name: "Nunito-Regular", size: 20)
            detailLabel.text = job.link
            let tapAction = UITapGestureRecognizer(target: self, action: #selector(configureURL(_:)))
            detailLabel.isUserInteractionEnabled = true
            detailLabel.addGestureRecognizer(tapAction)
        case .notes:
            detailLabel.font = UIFont(name: "Nunito-Regular", size: 20)
            detailLabel.text = job.notes
        case .dateLastUpdated:
            detailLabel.font = UIFont(name: "Nunito-Regular", size: 16)
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM dd, yyyy"
            detailLabel.text = formatter.string(from: job.dateLastUpdated)
        case .dateApplied:
            detailLabel.font = UIFont(name: "Nunito-Regular", size: 16)
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM dd, yyyy"
            detailLabel.text = formatter.string(from: job.dateApplied ?? Date.now)
        }
        
        if showStatusBox {
            configureStatusBoxStack()
        } else {
            configureStandardDetailLabel()
        }
    }
    
    // MARK: - Functions
    
    private func configureStatusBoxStack() {
        addSubview(statusBox)
        addSubview(detailLabel)
        
        NSLayoutConstraint.activate([
            statusBox.topAnchor.constraint(equalTo: detailTitleLabel.bottomAnchor, constant: 3),
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
            detailLabel.topAnchor.constraint(equalTo: detailTitleLabel.bottomAnchor, constant: 3),
            detailLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            detailLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    func setStatusBoxColor(status: JobStatus) {
        statusBox.backgroundColor = viewModel.setStatusBoxColor(forStatus: status)
    }
    
    @objc func configureURL(_ sender: UITapGestureRecognizer) {
        viewModel.configureURL(job.link ?? "")
    }
}

