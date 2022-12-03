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

public struct SingleJob: Codable {
    var status: JobStatus
    var company: String
    var role: String
    var location: String
    var link: String?
    var notes: String?
}

//var jobs: [SingleJob] = {[
//    SingleJob(status: .open, company: "Apple", role: "Junior iOS Developer", location: "Remote"),
//    SingleJob(status: .open, company: "Google", role: "iOS Engineer", location: "Boston, MA"),
//    SingleJob(status: .closed, company: "Spotify", role: "iOS Apprentice", location: "Denver, CO"),
//    SingleJob(status: .applied, company: "AirBnb", role: "iOS Engineer", location: "Remote"),
//]}()
