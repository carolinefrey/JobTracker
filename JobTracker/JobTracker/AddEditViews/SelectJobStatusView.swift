//
//  SelectJobStatusView.swift
//  JobTracker
//
//  Created by Caroline Frey on 11/30/22.
//

import UIKit

class SelectJobStatusView: UIView {
    
    // MARK: - UI Properties
    
    var selectedStatus: [JobStatus: Bool] = [.open: false, .applied: false, .interview: false, .closed: false]
    var status: JobStatus
    
    let statusLabel: UILabel = {
        let statusLabel = UILabel()
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.font = UIFont(name: "Nunito-Light", size: 12)
        statusLabel.textColor = UIColor.black
        statusLabel.textAlignment = .left
        statusLabel.text = "status"
        return statusLabel
    }()
    
    lazy var openStatusBox: UIButton = {
        let open = UIButton()
        open.translatesAutoresizingMaskIntoConstraints = false
        open.tag = 0
        open.layer.cornerRadius = 10
        open.backgroundColor = UIColor.openStatus
        open.addTarget(self, action: #selector(statusBoxSelected), for: .touchUpInside)
        open.setTitle("open", for: .normal)
        open.titleLabel?.font = UIFont(name: "Nunito-Light", size: 12)
        open.setTitleColor(UIColor.black, for: .normal)
        return open
    }()
    
    lazy var appliedStatusBox: UIButton = {
        let applied = UIButton()
        applied.translatesAutoresizingMaskIntoConstraints = false
        applied.tag = 1
        applied.layer.cornerRadius = 10
        applied.backgroundColor = UIColor.appliedStatus
        applied.addTarget(self, action: #selector(statusBoxSelected), for: .touchUpInside)
        applied.setTitle("applied", for: .normal)
        applied.titleLabel?.font = UIFont(name: "Nunito-Light", size: 12)
        applied.setTitleColor(UIColor.black, for: .normal)
        return applied
    }()
    
    lazy var interviewStatusBox: UIButton = {
        let interview = UIButton()
        interview.translatesAutoresizingMaskIntoConstraints = false
        interview.tag = 2
        interview.layer.cornerRadius = 10
        interview.backgroundColor = UIColor.interviewStatus
        interview.addTarget(self, action: #selector(statusBoxSelected), for: .touchUpInside)
        interview.setTitle("interview", for: .normal)
        interview.titleLabel?.font = UIFont(name: "Nunito-Light", size: 11)
        interview.setTitleColor(UIColor.black, for: .normal)
        return interview
    }()
    
    lazy var closedStatusBox: UIButton = {
        let closed = UIButton()
        closed.translatesAutoresizingMaskIntoConstraints = false
        closed.tag = 3
        closed.layer.cornerRadius = 10
        closed.backgroundColor = .lightGray
        closed.addTarget(self, action: #selector(statusBoxSelected), for: .touchUpInside)
        closed.setTitle("closed", for: .normal)
        closed.titleLabel?.font = UIFont(name: "Nunito-Light", size: 12)
        closed.setTitleColor(UIColor.black, for: .normal)
        return closed
    }()
    
    let boxStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .equalSpacing
        stack.spacing = 30
        stack.axis = .horizontal
        return stack
    }()
    
    // MARK: - Initializers
    
    init(status: JobStatus) {
        self.status = status
        super.init(frame: .zero)
        
        setUpViews()
        selectedStatus[status] = true
        configureStatusBox(statuses: selectedStatus)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    
    @objc func statusBoxSelected(_ sender: UIButton) {
        resetBoxes()
        
        switch sender.tag {
        case 0:
            selectedStatus[.open] = true
            status = .open
        case 1:
            selectedStatus[.applied] = true
            status = .applied
        case 2:
            selectedStatus[.interview] = true
            status = .interview
        case 3:
            selectedStatus[.closed] = true
            status = .closed
        default:
            selectedStatus[.open] = true
            status = .open
        }
        configureStatusBox(statuses: selectedStatus)
    }
    
    func configureStatusBox(statuses: Dictionary<JobStatus, Bool>) {
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular, scale: .medium)
        let checkmarkIcon = UIImage(systemName: "checkmark.circle.fill", withConfiguration: config)?.withTintColor(.white, renderingMode: .alwaysOriginal)
        
        if statuses[.open] == true {
            openStatusBox.setImage(checkmarkIcon, for: .normal)
            openStatusBox.setTitle("", for: .normal)
        } else if statuses[.applied] == true {
            appliedStatusBox.setImage(checkmarkIcon, for: .normal)
            appliedStatusBox.setTitle("", for: .normal)
        } else if statuses[.interview] == true {
            interviewStatusBox.setImage(checkmarkIcon, for: .normal)
            interviewStatusBox.setTitle("", for: .normal)
        } else if statuses[.closed] == true {
            closedStatusBox.setImage(checkmarkIcon, for: .normal)
            closedStatusBox.setTitle("", for: .normal)
        }
    }
    
    private func resetBoxes() {
        selectedStatus = [.open: false, .applied: false, .interview: false, .closed: false]
        openStatusBox.setTitle("open", for: .normal)
        openStatusBox.setImage(nil, for: .normal)
        
        appliedStatusBox.setTitle("applied", for: .normal)
        appliedStatusBox.setImage(nil, for: .normal)
        
        interviewStatusBox.setTitle("interview", for: .normal)
        interviewStatusBox.setImage(nil, for: .normal)
        
        closedStatusBox.setTitle("closed", for: .normal)
        closedStatusBox.setImage(nil, for: .normal)
        
    }
    
    // MARK: - UI Setup
    
    private func setUpViews() {
        addSubview(statusLabel)
        addSubview(boxStackView)
        
        boxStackView.addArrangedSubview(openStatusBox)
        boxStackView.addArrangedSubview(appliedStatusBox)
        boxStackView.addArrangedSubview(interviewStatusBox)
        boxStackView.addArrangedSubview(closedStatusBox)
        
        NSLayoutConstraint.activate([
            
            statusLabel.topAnchor.constraint(equalTo: topAnchor),
            statusLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            openStatusBox.heightAnchor.constraint(equalToConstant: 48),
            openStatusBox.widthAnchor.constraint(equalToConstant: 48),
            
            appliedStatusBox.heightAnchor.constraint(equalToConstant: 48),
            appliedStatusBox.widthAnchor.constraint(equalToConstant: 48),
            
            interviewStatusBox.heightAnchor.constraint(equalToConstant: 48),
            interviewStatusBox.widthAnchor.constraint(equalToConstant: 48),
            
            closedStatusBox.heightAnchor.constraint(equalToConstant: 48),
            closedStatusBox.widthAnchor.constraint(equalToConstant: 48),
            
            boxStackView.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 5),
            boxStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            boxStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}
