//
//  AddJobTextFieldView.swift
//  JobTracker
//
//  Created by Caroline Frey on 12/1/22.
//

import UIKit

class TextFieldView: UIView {
    
    // MARK: - UI Properties

    var textFieldTitle: String
    var textFieldHeight: Int
    var autoCap: Bool
    
    private let titleView: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont(name: "Nunito-Light", size: 12)
        title.textColor = UIColor(named: "Color4")
        title.textAlignment = .left
        return title
    }()
    
    let textFieldView: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.backgroundColor = .white
        field.returnKeyType = .done
        field.layer.cornerRadius = 10
        field.font = UIFont(name: "Nunito-Regular", size: 14)
        field.textColor = UIColor(named: "Color4")
        field.setLeftPadding(10)
        field.setRightPadding(10)
        return field
    }()
    
    // MARK: - Initializers
    
    init(textFieldTitle: String, textFieldHeight: Int, autoCap: Bool) {
        self.textFieldTitle = textFieldTitle
        titleView.text = textFieldTitle
        
        self.textFieldHeight = textFieldHeight
        
        self.autoCap = autoCap
        if !autoCap {
            textFieldView.autocapitalizationType = .none
        }
    
        super.init(frame: .zero)

        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI Setup
    
    private func setUpViews() {
        
        addSubview(titleView)
        addSubview(textFieldView)
        
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: topAnchor),
            titleView.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            textFieldView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 5),
            textFieldView.leadingAnchor.constraint(equalTo: leadingAnchor),
            textFieldView.trailingAnchor.constraint(equalTo: trailingAnchor),
            textFieldView.heightAnchor.constraint(equalToConstant: 45),
        ])
    }
}

extension UITextField {
    func setLeftPadding(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPadding(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
