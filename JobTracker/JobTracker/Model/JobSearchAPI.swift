//
//  JobSearchAPI.swift
//  JobTracker
//
//  Created by Caroline Frey on 6/16/23.
//

import Foundation

struct JobSearchResults: Codable {
    var data: [Result]
}

struct Result: Codable {
    var title: String
    var url: String
    var company: String
//    var location: String
}

func searchJobs(searchTerm: String, completion: @escaping ([SingleJob]?, Error?) -> Void) {
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
            let jobData = try JSONDecoder().decode(JobSearchResults.self, from: data)

            // Convert JobSearchResults to an array of SingleJob objects
            let response = jobData.data.map { result in
                SingleJob(searchResult: result)
            }
            completion(response, nil)
        } catch {
            completion(nil, error)
            print("Error: \(error.localizedDescription)")
        }
    }.resume()
}
