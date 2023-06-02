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
            showInvalidPINAlert(title: "Incorrect PIN", message: "The PIN you entered is incorrect.")
        }
    }
    
    func createPINButtonTapped() {
        let pinString = contentView.pinEntryField.text
        let pinInt = Int(pinString ?? "-1")
        if pinString?.count == 4 {
            defaults.set(pinInt, forKey: "pin")
            navigationController?.pushViewController(DashboardViewController(viewModel: DashboardViewModel()), animated: true)
        } else {
            showInvalidPINAlert(title: "Invalid PIN", message: "Your PIN must contain 4-digits.")
        }
    }
    
    private func showInvalidPINAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let okayButton = UIAlertAction(title: "Try again", style: .default)
        alert.addAction(okayButton)
        self.present(alert, animated: true)
    }
}
