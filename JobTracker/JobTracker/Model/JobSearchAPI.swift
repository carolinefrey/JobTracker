//
//  JobSearchAPI.swift
//  JobTracker
//
//  Created by Caroline Frey on 6/16/23.
//

import Foundation

struct JobSearchResult: Codable {
    var data: [Data]
}

struct Data: Codable {
    var title: String
    var url: String
    var company: String
    var location: String
}

func searchJobs(searchTerm: String, completion: @escaping (JobSearchResult?, Error?) -> Void) {
    guard let searchURL = URL(string: "https://jobsearch4.p.rapidapi.com/api/v1/Jobs/Search?SearchQuery=\(searchTerm)") else {
        print("Invalid URL")
        return
    }
    
    var urlRequest = URLRequest(url: searchURL)
    urlRequest.httpMethod = "GET"
    
    let headers = [
        "X-RapidAPI-Key": APIConstants.key,
        "X-RapidAPI-Host": "jobsearch4.p.rapidapi.com"
    ]
    
    urlRequest.allHTTPHeaderFields = headers
    
    URLSession.shared.dataTask(with: urlRequest) { data, response, error in
        guard let data = data, error == nil else {
            return
        }
        do {
            let jobData = try JSONDecoder().decode(JobSearchResult.self, from: data)
            completion(jobData, nil)
        } catch {
            completion(nil, error)
            print("Error: \(error.localizedDescription)")
        }
    }.resume()
}

// TODO: - Use this to search jobs
//searchJobs(searchTerm: "ios engineer") { jobResults, error in
//    if let error = error {
//        print("Error: \(error.localizedDescription)")
//    }
//    DispatchQueue.main.async {
//        if let jobResults = jobResults {
//            //update UI
//        } else {
//            print("Jobs not found")
//        }
//    }
//}
