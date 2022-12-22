//
//  StatusBoxView.swift
//  JobTracker
//
//  Created by Caroline Frey on 11/29/22.
//

import UIKit

class StatusBoxView: UIView {
        
    // MARK: - UI Properties
    
    let status: String
       
    let box: UIButton = {
        let box = UIButton()
        box.translatesAutoresizingMaskIntoConstraints = false
        box.clipsToBounds = true
        box.layer.cornerRadius = 20
        box.backgroundColor = UIColor(named: "StatusBoxBackground")
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
            statusLabel.textColor = UIColor(named: "OpenStatusLabel")
            countLabel.textColor = UIColor(named: "OpenStatusLabel")
        case .applied:
            statusLabel.textColor = UIColor(named: "AppliedStatusLabel")
            countLabel.textColor = UIColor(named: "AppliedStatusLabel")
        case .interview:
            statusLabel.textColor = UIColor(named: "InterviewStatusLabel")
            countLabel.textColor = UIColor(named: "InterviewStatusLabel")
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

extension UIButton {
    func setBackgroundColor(_ color: UIColor, forState controlState: UIControl.State) {
        let colorImage = UIGraphicsImageRenderer(size: CGSize(width: 1, height: 1)).image { _ in
          color.setFill()
          UIBezierPath(rect: CGRect(x: 0, y: 0, width: 1, height: 1)).fill()
        }
        setBackgroundImage(colorImage, for: controlState)
      }
}
