//
//  DashboardCollectionViewCell.swift
//  JobTracker
//
//  Created by Caroline Frey on 11/29/22.
//

import UIKit

class DashboardCollectionViewCell: UICollectionViewCell {
    
    //MARK: - UI Properties
    
    static let dashboardCollectionViewCellIdentifier = "DashboardCollectionViewCell"
    
    let backgroundCell: UIView = {
        let cell = UIView()
        cell.translatesAutoresizingMaskIntoConstraints = false
        cell.backgroundColor = UIColor(named: "StatusBoxBackground")
        cell.clipsToBounds = true
        cell.layer.cornerRadius = 20
        return cell
    }()
    
    let companyLabel: UILabel = {
        let companyLabel = UILabel()
        companyLabel.translatesAutoresizingMaskIntoConstraints = false
        companyLabel.font = UIFont(name: "Nunito-SemiBold", size: 28)
        companyLabel.textColor = UIColor(named: "Color4")
        companyLabel.textAlignment = .left
        companyLabel.lineBreakMode = .byTruncatingTail
        companyLabel.numberOfLines = 1
        return companyLabel
    }()
    
    let jobLocationLabel: UILabel = {
        let locationLabel = UILabel()
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.font = UIFont(name: "Nunito-Light", size: 12)
        locationLabel.text = ("📍 Remote")
        locationLabel.lineBreakMode = .byTruncatingTail
        locationLabel.numberOfLines = 1
        locationLabel.textColor = UIColor(named: "Color4")
        return locationLabel
    }()

    //MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI Setup

    private func setUpViews() {
        
        addSubview(backgroundCell)
        addSubview(companyLabel)
        addSubview(jobLocationLabel)
        
        NSLayoutConstraint.activate([
           backgroundCell.topAnchor.constraint(equalTo: topAnchor),
           backgroundCell.leadingAnchor.constraint(equalTo: leadingAnchor),
           backgroundCell.trailingAnchor.constraint(equalTo: trailingAnchor),
           backgroundCell.bottomAnchor.constraint(equalTo: bottomAnchor),
           
           companyLabel.leadingAnchor.constraint(equalTo: backgroundCell.leadingAnchor, constant: 20),
           companyLabel.bottomAnchor.constraint(equalTo: backgroundCell.bottomAnchor, constant: -34),
           companyLabel.trailingAnchor.constraint(equalTo: backgroundCell.trailingAnchor, constant: -20),
           
           jobLocationLabel.topAnchor.constraint(equalTo: companyLabel.bottomAnchor),
           jobLocationLabel.leadingAnchor.constraint(equalTo: backgroundCell.leadingAnchor, constant: 20),
           jobLocationLabel.trailingAnchor.constraint(equalTo: backgroundCell.trailingAnchor, constant: -20),
        ])
    }
    
    func configure(company: String, location: String, status: String) {
        companyLabel.text = company
        jobLocationLabel.text = "📍 \(location)"
        
        let jobStatus = JobStatus(rawValue: status)
        
        switch jobStatus {
        case .open:
            backgroundCell.backgroundColor = UIColor(named: "OpenStatus")
        case .applied:
            backgroundCell.backgroundColor = UIColor(named: "AppliedStatus")
        case .interview:
            backgroundCell.backgroundColor = UIColor(named: "InterviewStatus")
        case .closed:
            backgroundCell.backgroundColor = .lightGray
        default:
            backgroundCell.backgroundColor = UIColor(named: "OpenStatus")
        }
    }
}
