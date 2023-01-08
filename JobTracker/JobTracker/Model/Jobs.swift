//
//  Jobs.swift
//  JobTracker
//
//  Created by Caroline Frey on 11/29/22.
//

import Foundation

public enum JobStatus: String, Codable {
    case open = "open"
    case applied = "applied"
    case interview = "interview"
    case closed = "closed"
}

//public struct SingleJob: Codable {
//    var status: JobStatus
//    var company: String
//    var role: String
//    var location: String
//    var link: String?
//    var notes: String?
//
//    init(status: JobStatus = .open, company: String = "", role: String = "", location: String = "", link: String? = "", notes: String?) {
//        self.status = status
//        self.company = company
//        self.role = role
//        self.location = location
//        self.link = link
//        self.notes = notes
//    }
//}

//public struct FavoriteJobs {
//    var favorites: [SingleJob]
//}
