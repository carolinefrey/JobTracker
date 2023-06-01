//
//  LaunchViewController.swift
//  JobTracker
//
//  Created by Caroline Frey on 5/31/23.
//

import UIKit

class LaunchViewController: UIViewController {

    // MARK: - Class Properties

    // MARK: - UI Properties
    
    private var contentView: LaunchView!

    // MARK: - Initializer
    
    // MARK: - Lifecycle
    
    override func loadView() {
        contentView = LaunchView()
        view = contentView
    }
    
    // MARK: - Functions
    
    // MARK: - Selector Functions

}
