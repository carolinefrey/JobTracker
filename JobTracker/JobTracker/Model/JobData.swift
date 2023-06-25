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
        self.company = searchResult.companyName
        self.role = searchResult.role
        self.location = searchResult.location
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

// MARK: - Job Search API

struct JobSearchResults: Codable {
    var results: [Result]
}

//JobSearch
//struct Result: Codable {
//    var title: String
//    var url: String
//    var company: String
//    var location: String?
//}

//FindWork
struct Result: Codable {
    var role: String
    var url: String
    var companyName: String
    var location: String
}

func searchJobs(searchTerm: String, location: String, completion: @escaping ([SingleJob]?, Error?) -> Void) {
//    guard let searchURL = URL(string: "https://jobsearch4.p.rapidapi.com/api/v1/Jobs/Search?SearchQuery=\(searchTerm)") else {
//        print("Invalid URL")
//        return
//    }
    
    var searchLocation = location == "" ? "London" : location
    
    guard let searchURL = URL(string: "https://findwork.dev/api/jobs/?location=\(searchLocation)&search=\(searchTerm)&sort_by=relevance") else {
        print("Invalid URL")
        return
    }
    
    var urlRequest = URLRequest(url: searchURL)
    urlRequest.httpMethod = "GET"
    
//    let headers = [
//        "X-RapidAPI-Key": APIConstants.key,
//        "X-RapidAPI-Host": "jobsearch4.p.rapidapi.com"
//    ]
    let headers = [
        "Authorization": "Token \(APIConstants.key)"
    ]
    
    urlRequest.allHTTPHeaderFields = headers
    
    URLSession.shared.dataTask(with: urlRequest) { data, response, error in
        guard let data = data, error == nil else {
            return
        }
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let jobData = try decoder.decode(JobSearchResults.self, from: data)

            // Convert JobSearchResults to an array of SingleJob objects
            let response = jobData.results.map { result in
                SingleJob(searchResult: result)
            }
            completion(response, nil)
        } catch {
            completion(nil, error)
            print("Error: \(error.localizedDescription)")
        }
    }.resume()
}
