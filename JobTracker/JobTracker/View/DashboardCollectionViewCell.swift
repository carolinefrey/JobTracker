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
    
    let dateLabelBackground: UIView = {
        let background = UIView()
        background.translatesAutoresizingMaskIntoConstraints = false
        background.clipsToBounds = true
        background.layer.cornerRadius = 10
        return background
    }()
    
    let dateLastUpdatedLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.font = UIFont(name: "Nunito-Light", size: 14)
        dateLabel.textColor = UIColor(named: "Color4")
        return dateLabel
    }()
    
    let companyLabel: UILabel = {
        let companyLabel = UILabel()
        companyLabel.translatesAutoresizingMaskIntoConstraints = false
        companyLabel.font = UIFont(name: "Nunito-SemiBold", size: 24)
        companyLabel.textColor = UIColor(named: "Color4")
        companyLabel.textAlignment = .left
        companyLabel.lineBreakMode = .byTruncatingTail
        companyLabel.numberOfLines = 1
        return companyLabel
    }()
    
    let jobLocationLabel: UILabel = {
        let locationLabel = UILabel()
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.font = UIFont(name: "Nunito-Light", size: 14)
        locationLabel.lineBreakMode = .byTruncatingTail
        locationLabel.numberOfLines = 1
        locationLabel.textColor = UIColor(named: "Color4")
        return locationLabel
    }()
    
    let favoriteIndicator: UIImageView = {
        let heart = UIImageView()
        heart.translatesAutoresizingMaskIntoConstraints = false
        heart.image = UIImage(systemName: "heart")
        heart.tintColor = .black
        return heart
    }()
    
    let checkmark: UIImageView = {
        let checkmark = UIImageView()
        checkmark.translatesAutoresizingMaskIntoConstraints = false
        checkmark.image = UIImage(systemName: "checkmark")
        checkmark.tintColor = .black
        return checkmark
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
        addSubview(dateLabelBackground)
        addSubview(dateLastUpdatedLabel)
        addSubview(companyLabel)
        addSubview(jobLocationLabel)
        addSubview(favoriteIndicator)
        
        NSLayoutConstraint.activate([
           backgroundCell.topAnchor.constraint(equalTo: topAnchor),
           backgroundCell.leadingAnchor.constraint(equalTo: leadingAnchor),
           backgroundCell.trailingAnchor.constraint(equalTo: trailingAnchor),
           backgroundCell.bottomAnchor.constraint(equalTo: bottomAnchor),
           
           dateLabelBackground.topAnchor.constraint(equalTo: backgroundCell.topAnchor, constant: 10),
           dateLabelBackground.leadingAnchor.constraint(equalTo: backgroundCell.leadingAnchor, constant: 10),
           dateLabelBackground.heightAnchor.constraint(equalToConstant: 25),
           dateLabelBackground.widthAnchor.constraint(equalToConstant: 95),
           
           dateLastUpdatedLabel.centerXAnchor.constraint(equalTo: dateLabelBackground.centerXAnchor),
           dateLastUpdatedLabel.centerYAnchor.constraint(equalTo: dateLabelBackground.centerYAnchor),
           
           companyLabel.leadingAnchor.constraint(equalTo: backgroundCell.leadingAnchor, constant: 20),
           companyLabel.bottomAnchor.constraint(equalTo: backgroundCell.bottomAnchor, constant: -34),
           companyLabel.trailingAnchor.constraint(equalTo: backgroundCell.trailingAnchor, constant: -20),
           
           jobLocationLabel.topAnchor.constraint(equalTo: companyLabel.bottomAnchor),
           jobLocationLabel.leadingAnchor.constraint(equalTo: backgroundCell.leadingAnchor, constant: 20),
           jobLocationLabel.trailingAnchor.constraint(equalTo: backgroundCell.trailingAnchor, constant: -20),
           
           favoriteIndicator.topAnchor.constraint(equalTo: backgroundCell.topAnchor, constant: 10),
           favoriteIndicator.trailingAnchor.constraint(equalTo: backgroundCell.trailingAnchor, constant: -10)
        ])
    }
    
    func configure(company: String, location: String, status: String, favorite: Bool, dateLastUpdated: Date) {
        companyLabel.text = company
        jobLocationLabel.text = location != "" ? "📍 \(location)" : ""

        let dateFormatted = formatDate(date: dateLastUpdated)
        dateLastUpdatedLabel.text = "\(dateFormatted)"
        
        let jobStatus = JobStatus(rawValue: status)
        
        switch jobStatus {
        case .open:
            backgroundCell.backgroundColor = UIColor(named: "OpenStatus")
            dateLabelBackground.backgroundColor = UIColor(named: "OpenStatus")?.withAlphaComponent(0.6)
        case .applied:
            backgroundCell.backgroundColor = UIColor(named: "AppliedStatus")
            dateLabelBackground.backgroundColor = UIColor(named: "AppliedStatus")?.withAlphaComponent(0.6)
        case .interview:
            backgroundCell.backgroundColor = UIColor(named: "InterviewStatus")
            dateLabelBackground.backgroundColor = UIColor(named: "InterviewStatus")?.withAlphaComponent(0.6)
        case .closed:
            backgroundCell.backgroundColor = .lightGray
            dateLabelBackground.backgroundColor = .darkGray.withAlphaComponent(0.4)
        default:
            backgroundCell.backgroundColor = UIColor(named: "OpenStatus")
            dateLabelBackground.backgroundColor = UIColor(named: "OpenStatus")?.withAlphaComponent(0.6)
        }
        favoriteIndicator.image = favorite ? UIImage(systemName: "heart") : UIImage(systemName: "")
    }
    
    func showCheckmark() {
        addSubview(checkmark)
        
        NSLayoutConstraint.activate([
            checkmark.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            checkmark.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10)
        ])
    }
    
    func removeCheckmark() {
        checkmark.removeFromSuperview()
    }
    
    func formatDate(date: Date) -> String {
        var dateString = ""
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZZ"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "E MM/dd"
        
        if let date = dateFormatterGet.date(from: "\(date)") {
            dateString = dateFormatterPrint.string(from: date)
        } else {
            print("Error decoding string")
        }
        return dateString
    }
}
