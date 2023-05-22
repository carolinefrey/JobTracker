//
//  SettingsViewController.swift
//  JobTracker
//
//  Created by Caroline Frey on 12/9/22.
//

import UIKit

protocol SetUsernameDelegate: AnyObject {
    func didUpdateSettings(name: String)
}

class SettingsViewController: UIViewController {

    weak var delegate: SetUsernameDelegate?
    
    // MARK: - UserDefaults
    
    let defaults = UserDefaults.standard
    
    // MARK: - UI Properties
    
    private var contentView = SettingsView()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = contentView
        contentView.textFieldView.delegate = self
        contentView.saveSettingsButton.addTarget(self, action: #selector(saveSettings), for: .touchUpInside)
    }
    
    // MARK: - Functions

    @objc func saveSettings() {
        let name = contentView.textFieldView.text ?? ""
        defaults.set("\(name)", forKey: "name")
        dismiss(animated: true)
        self.delegate?.didUpdateSettings(name: name)
    }
}

// MARK: - UITextFieldDelegate

extension SettingsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
