//
//  NotesFieldView.swift
//  JobTracker
//
//  Created by Caroline Frey on 12/8/22.
//

import UIKit

protocol NotesFieldAddJobViewDelegate: AnyObject {
    func tapDoneButtonFromAddView()
}

protocol NotesFieldEditJobViewDelegate: AnyObject {
    func tapDoneButtonFromEditView()
}

class NotesFieldView: UIView {
    
    // MARK: - UI Properties
    
    weak var addJobFieldDelegate: NotesFieldAddJobViewDelegate?
    weak var editJobFieldDelegate: NotesFieldEditJobViewDelegate?
    
    private let titleView: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont(name: "Nunito-Light", size: 12)
        title.textColor = UIColor.colorFour
        title.textAlignment = .left
        title.text = "notes"
        return title
    }()
    
    let notesFieldView: UITextView = {
        let field = UITextView()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.backgroundColor = .white
        field.returnKeyType = .default
        field.layer.cornerRadius = 10
        field.font = UIFont(name: "Nunito-Regular", size: 14)
        field.textColor = UIColor.colorFour
        return field
    }()
    
    lazy var keyboardToolbar: UIToolbar = {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissKeyboard))
        keyboardToolbar.setItems([flexible, doneBarButton], animated: false)
        return keyboardToolbar
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    
    @objc func dismissKeyboard() {
        addJobFieldDelegate?.tapDoneButtonFromAddView()
        editJobFieldDelegate?.tapDoneButtonFromEditView()
    }
    
    // MARK: - UI Setup
    
    private func setUpViews() {
        notesFieldView.inputAccessoryView = keyboardToolbar

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

