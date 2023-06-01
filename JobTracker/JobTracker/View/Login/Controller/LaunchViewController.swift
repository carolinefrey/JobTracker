//
//  LaunchViewController.swift
//  JobTracker
//
//  Created by Caroline Frey on 5/31/23.
//

import UIKit

class LaunchViewController: UIViewController {

    // MARK: - Class Properties
    
    let defaults = UserDefaults.standard
    var pin: Int = -1

    // MARK: - UI Properties
    
    private var contentView: LaunchView!

    // MARK: - Lifecycle
    
    override func loadView() {
        contentView = LaunchView()
        view = contentView
        
        contentView.loginDelegate = self
        
        pin = defaults.integer(forKey: "pin")
        configureViews()
    }
    
    // MARK: - Functions
    
    private func configureViews() {
        if pin == 0 {
            contentView.configureFirstLaunch()
        } else {
            contentView.configureSubsequentLaunches()
        }
    }
}

extension LaunchViewController: LoginDelegate {
    func loginButtonTapped() {
        let pin = defaults.integer(forKey: "pin")
        let pinString = "\(pin)"
        if contentView.pinEntryField.text == pinString {
            navigationController?.pushViewController(DashboardViewController(viewModel: DashboardViewModel()), animated: true)
        } else {
            //TODO: add alert
            
            print("Wrong pin")
        }
    }
    
    func createPINButtonTapped() {
        var pin = Int(contentView.pinEntryField.text ?? "-1")
        
        //TODO: enforce 4 digit pin (nothing less)
        
        if pin != -1 {
            defaults.set(pin, forKey: "pin")
            navigationController?.pushViewController(DashboardViewController(viewModel: DashboardViewModel()), animated: true)
        } else {
            //TODO: add alert
            
            print("Invalid pin")
        }
    }
}
