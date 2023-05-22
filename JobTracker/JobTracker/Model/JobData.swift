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

struct JobData {
    var savedJobs = [Job]()
    var favoritedJobs = [Job]()
    var filterByFavorites: Bool = false
    var filteredJobs = [Job]()
    var filtersApplied = [JobStatus]()
}
