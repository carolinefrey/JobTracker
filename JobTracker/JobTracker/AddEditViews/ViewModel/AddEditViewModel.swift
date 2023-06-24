//
//  AddEditViewModel.swift
//  JobTracker
//
//  Created by Caroline Frey on 6/6/23.
//

import Foundation
import UIKit

struct AddEditViewModel {
    func handleAddNewJob(_ newJob: SingleJob) {
        DataManager.addJob(company: newJob.company, role: newJob.role, location: newJob.location, status: newJob.status, link: newJob.link, notes: newJob.notes, dateApplied: newJob.dateApplied)
    }
    
    func configureDetailLabelText(forDetail detail: JobDetail) -> String {
        if detail == .dateApplied {
            return "date applied"
        } else if detail == .dateLastUpdated {
            return "date last updated"
        } else {
            return detail.rawValue
        }
    }
    
    func setStatusBoxColor(forStatus status: JobStatus) -> UIColor {
        switch status {
        case .open:
            return UIColor.openStatus!
        case .applied:
            return UIColor.appliedStatus!
        case .interview:
            return UIColor.interviewStatus!
        case .closed:
            return .darkGray
        }
    }
    
    func configureURL(_ link: String) {
        let webURL = URL(string: link)!
        let application = UIApplication.shared
        application.open(webURL)
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

