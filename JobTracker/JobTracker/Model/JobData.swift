//
//  Jobs.swift
//  JobTracker
//
//  Created by Caroline Frey on 11/29/22.
//

import Foundation


struct SingleJob {
    var company: String
    var role: String
    var location: String
    var status: JobStatus
    var link: String
    var notes: String
    var dateApplied: Date
    
    init(company: String, role: String, location: String, status: JobStatus, link: String, notes: String, dateApplied: Date) {
        self.company = company
        self.role = role
        self.location = location
        self.status = status
        self.link = link
        self.notes = notes
        self.dateApplied = dateApplied
    }
    
    init(searchResult: Result) {
        self.company = searchResult.company
        self.role = searchResult.title
//        self.location = searchResult.location - location is showing as null in Postman, make optional here?
        self.location = "N/A"
        self.status = .open
        self.link = searchResult.url
        self.notes = ""
        self.dateApplied = Date()
    }
}

struct JobData {
    var savedJobs = [Job]()
    var favoritedJobs = [Job]()
    var filterByFavorites: Bool = false
    var filteredJobs = [Job]()
    var filtersApplied = [JobStatus]()
}

public enum JobStatus: String, Codable {
    case open = "open"
    case applied = "applied"
    case interview = "interview"
    case closed = "closed"
}

public enum JobDetail: String {
    case status, company, role, location, link, notes, dateLastUpdated, dateApplied
}

public enum StatusButtonState {
    case normal, selected
}


public enum CollectionViewMessageLabelCase {
    case noJobs
    case noFilteredJobs
    case noFavorites
    case none
}
