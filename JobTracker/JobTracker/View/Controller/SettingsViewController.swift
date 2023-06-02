//
//  SettingsViewController.swift
//  JobTracker
//
//  Created by Caroline Frey on 12/9/22.
//

import UIKit

protocol UpdateSettingsDelegate: AnyObject {
    func updateUsername(name: String)
}

class SettingsViewController: UIViewController {

    weak var delegate: UpdateSettingsDelegate?
    
    // MARK: - UserDefaults
    
    let defaults = UserDefaults.standard
    
    // MARK: - UI Properties
    
    private var contentView = SettingsView()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = contentView
        
        configure()
    }
    
    // MARK: - Functions
    
    func configure() {
        contentView.nameTextFieldView.delegate = self
        contentView.saveSettingsButton.addTarget(self, action: #selector(saveSettings), for: .touchUpInside)
    }

    @objc func saveSettings() {
        //check if name has been updated, only update if different than what is already saved
        let name = contentView.nameTextFieldView.text ?? ""
        if name != defaults.string(forKey: "name") {
            defaults.set("\(name)", forKey: "name")
            self.delegate?.updateUsername(name: name)
        }
        //check if pin has been updated
        if contentView.pinTextFieldView.text?.count ?? 0 < 4 {
            showInvalidPINAlert(title: "Invalid PIN", message: "Your PIN must contain 4 digits.")
        } else {
            let pin = Int(contentView.pinTextFieldView.text ?? "-1")
            if pin != defaults.integer(forKey: "pin") {
                defaults.set(pin, forKey: "pin")
            }
            
            dismiss(animated: true)
        }
    }
    
    
    private func showInvalidPINAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let okayButton = UIAlertAction(title: "Try again", style: .default)
        alert.addAction(okayButton)
        self.present(alert, animated: true)
    }
}

// MARK: - UITextFieldDelegate

extension SettingsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
