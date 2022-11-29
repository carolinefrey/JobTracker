//
//  Jobs.swift
//  JobTracker
//
//  Created by Caroline Frey on 11/29/22.
//

import Foundation

enum JobStatus: String {
    case open = "open"
    case applied = "applied"
    case interview = "interview"
    case closed = "closed"
}

struct Job {
    var status: JobStatus
    var company: String
    var role: String
    var location: String
    var link: URL?
    var notes: String?
}

//make array of sample jobs

var jobs: [Job] = {[
    Job(status: .open, company: "Apple", role: "Junior iOS Developer", location: "Remote"),
    Job(status: .open, company: "Google", role: "iOS Engineer", location: "Boston, MA"),
    Job(status: .closed, company: "Spotify", role: "iOS Apprentice", location: "Denver, CO"),
    Job(status: .applied, company: "AirBnb", role: "iOS Engineer", location: "Remote"),
]}()
