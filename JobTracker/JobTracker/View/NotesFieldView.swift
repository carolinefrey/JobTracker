//
//  NotesFieldView.swift
//  JobTracker
//
//  Created by Caroline Frey on 12/8/22.
//

import UIKit

class NotesFieldView: UIView {
    
    // MARK: - UI Properties
    
    private let titleView: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont(name: "Nunito-Light", size: 12)
        title.textColor = UIColor(named: "Color4")
        title.textAlignment = .left
        title.text = "notes"
        return title
    }()
    
    let notesFieldView: UITextView = {
        let field = UITextView()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.backgroundColor = .white
        field.returnKeyType = .done
        field.layer.cornerRadius = 10
        field.font = UIFont(name: "Nunito-Regular", size: 14)
        field.textColor = UIColor(named: "Color4")
        return field
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
        
        addSubview(titleView)
        addSubview(notesFieldView)
        
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: topAnchor),
            titleView.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            notesFieldView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 5),
            notesFieldView.leadingAnchor.constraint(equalTo: leadingAnchor),
            notesFieldView.trailingAnchor.constraint(equalTo: trailingAnchor),
            notesFieldView.heightAnchor.constraint(equalToConstant: 75),
        ])
    }
}
