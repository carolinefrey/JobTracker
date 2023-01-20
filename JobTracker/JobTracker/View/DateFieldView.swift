//
//  DateFieldView.swift
//  JobTracker
//
//  Created by Caroline Frey on 1/20/23.
//

import UIKit

class DateFieldView: UIView {

    // MARK: - UI Properties
    
    let dateAppliedLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont(name: "Nunito-Light", size: 12)
        title.textColor = UIColor(named: "Color4")
        title.textAlignment = .left
        title.text = "date applied"
        return title
    }()
    
    let dateAppliedField: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.preferredDatePickerStyle = .compact
        datePicker.calendar = Calendar.current
        datePicker.datePickerMode = .date
        return datePicker
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI Setup
    
    private func setUpView() {
        
        addSubview(dateAppliedLabel)
        addSubview(dateAppliedField)
        
        NSLayoutConstraint.activate([
            dateAppliedLabel.topAnchor.constraint(equalTo: topAnchor),
            dateAppliedLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            dateAppliedField.topAnchor.constraint(equalTo: dateAppliedLabel.bottomAnchor, constant: 5),
            dateAppliedField.leadingAnchor.constraint(equalTo: leadingAnchor),
        ])
    }

}
