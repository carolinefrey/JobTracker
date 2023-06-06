//
//  HeaderView.swift
//  JobTracker
//
//  Created by Caroline Frey on 11/29/22.
//

import UIKit

class HeaderView: UIView {

    // MARK: - UI Properties

    lazy var icon: UIImageView = {
        let image = UIImage(named: "briefcaseIcon")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let greeting: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Nunito-SemiBold", size: 26)
        label.textColor = UIColor.black
        label.textAlignment = .left
        return label
    }()
    
    let title: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont(name: "Nunito-Light", size: 14)
        title.textColor = UIColor.black
        title.textAlignment = .left
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
            icon.heightAnchor.constraint(equalToConstant: 80),
            icon.widthAnchor.constraint(equalToConstant: 80),
            
            greeting.centerYAnchor.constraint(equalTo: icon.centerYAnchor),
            greeting.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 5),
        
            title.topAnchor.constraint(equalTo: greeting.bottomAnchor),
            title.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 7),
        ])
    }
}
