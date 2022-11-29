//
//  ContentView.swift
//  JobTracker
//
//  Created by Caroline Frey on 11/28/22.
//

import UIKit

class ContentView: UIView {

    // MARK: - UI Properties

    let greeting: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Nunito-SemiBold", size: 26)
        label.textColor = UIColor(named: "Color4")
        label.textAlignment = .left
        label.text = NSUserName()
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

    //MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(named: "Background")
        
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup

    private func setUpViews() {
        
        addSubview(greeting)
        addSubview(title)
        
        NSLayoutConstraint.activate([
            greeting.topAnchor.constraint(equalTo: topAnchor),
            greeting.leadingAnchor.constraint(equalTo: leadingAnchor),
        
            title.topAnchor.constraint(equalTo: greeting.bottomAnchor, constant: 5),
            title.leadingAnchor.constraint(equalTo: leadingAnchor),
        ])
    }
}
