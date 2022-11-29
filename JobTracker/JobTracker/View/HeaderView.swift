//
//  HeaderView.swift
//  JobTracker
//
//  Created by Caroline Frey on 11/29/22.
//

import UIKit

class HeaderView: UIView {

    // MARK: - UI Properties

    let icon: UIImageView = {
        let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.image = UIImage(named: "meCircle")
        icon.contentMode = .scaleAspectFit
        return icon
    }()
    
    let greeting: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Nunito-SemiBold", size: 26)
        label.textColor = UIColor(named: "Color4")
        label.textAlignment = .left
        label.text = "Hey, Caroline"
        //label.text = NSUserName()
        return label
    }()
    
    let title: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont(name: "Nunito-Light", size: 14)
        title.textColor = UIColor(named: "Color4")
        title.textAlignment = .left
        title.text = "Future iOS Engineer"
        return title
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
        
        addSubview(icon)
        addSubview(greeting)
        addSubview(title)
        
        NSLayoutConstraint.activate([
            icon.topAnchor.constraint(equalTo: topAnchor),
            icon.leadingAnchor.constraint(equalTo: leadingAnchor),
            icon.heightAnchor.constraint(equalToConstant: 75),
            icon.widthAnchor.constraint(equalToConstant: 75),
            
            greeting.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            greeting.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 7),
        
            title.topAnchor.constraint(equalTo: greeting.bottomAnchor),
            title.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 7),
        
        ])
    }
}
