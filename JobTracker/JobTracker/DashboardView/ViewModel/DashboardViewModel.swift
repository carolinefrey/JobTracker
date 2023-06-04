//
//  DashboardViewModel.swift
//  JobTracker
//
//  Created by Caroline Frey on 5/22/23.
//

import Foundation
import UIKit

enum MessageLabelCase {
    case noJobs
    case noFilteredJobs
    case noFavorites
    case doNotShow
}

struct DashboardViewModel {
    
    func fetchJobs() -> [Job] {
        var finalJobs: [Job] = []
        DataManager.fetchJobs { jobs in
            if let fetchedJobs = jobs {
                finalJobs = fetchedJobs
            }
        }
        return finalJobs
    }
    
    func sortJobs(jobsToSort: [Job]) -> [Job] {
        var sortedJobs = jobsToSort
        sortedJobs.sort { job1, job2 in
            return job1.displayOrder?.intValue ?? 0 <= job2.displayOrder?.intValue ?? 0
        }
        return sortedJobs
    }

    func handleNumItemsInSection(jobData: JobData) -> Int {
        if jobData.filtersApplied != [] {
            return jobData.filteredJobs.count
        } else if jobData.filterByFavorites {
            return jobData.favoritedJobs.count
        } else {
            return jobData.savedJobs.count
        }
    }
    
    func handleToggleEmptyMessage(jobData: JobData) -> UILabel {
        var messageLabel = UILabel()
        if jobData.filtersApplied != [] {
            messageLabel = jobData.filteredJobs.count == 0 ? showEmptyMessage(show: .noFilteredJobs) : showEmptyMessage(show: .doNotShow)
        } else if jobData.filterByFavorites {
            messageLabel = jobData.favoritedJobs.count == 0 ? showEmptyMessage(show: .noFavorites) : showEmptyMessage(show: .doNotShow)
        } else {
            messageLabel = jobData.savedJobs.count == 0 ? showEmptyMessage(show: .noJobs) : showEmptyMessage(show: .doNotShow)
        }
        return messageLabel
    }

    //UI related - technically, should not be in VM
    func showEmptyMessage(show: MessageLabelCase) -> UILabel {
        let messageLabel = UILabel()
        if show == .noJobs || show == .noFilteredJobs {
            messageLabel.text = "Add a job by clicking the plus button!"
            messageLabel.font = UIFont(name: "Nunito-Regular", size: 16)
            messageLabel.textAlignment = .center
            messageLabel.textColor = UIColor(named: "Color4")
        } else if show == .noFavorites {
            messageLabel.text = "Favorite a job application by selecting it and tapping the heart in the top right corner!"
            messageLabel.font = UIFont(name: "Nunito-Regular", size: 16)
            messageLabel.textAlignment = .center
            messageLabel.textColor = UIColor(named: "Color4")
            messageLabel.lineBreakMode = .byWordWrapping
            messageLabel.numberOfLines = 0
        }
        return messageLabel
    }

    func handleCellForItemAt(data: JobData, cell: DashboardCollectionViewCell, indexPath: IndexPath) -> DashboardCollectionViewCell {
        if data.filtersApplied != [] {
            cell.configure(company: data.filteredJobs[indexPath.row].company ?? "N/A",
                           location: data.filteredJobs[indexPath.row].location ?? "N/A",
                           status: data.filteredJobs[indexPath.row].status ?? "open",
                           favorite: data.filteredJobs[indexPath.row].favorite,
                           dateLastUpdated: data.filteredJobs[indexPath.row].dateLastUpdated)
        } else if data.favoritedJobs != [] && data.filterByFavorites {
            cell.configure(company: data.favoritedJobs[indexPath.row].company ?? "N/A",
                           location: data.favoritedJobs[indexPath.row].location ?? "N/A",
                           status: data.favoritedJobs[indexPath.row].status ?? "open",
                           favorite: data.favoritedJobs[indexPath.row].favorite,
                           dateLastUpdated: data.favoritedJobs[indexPath.row].dateLastUpdated)
        } else {
            cell.configure(company: data.savedJobs[indexPath.row].company ?? "N/A",
                           location: data.savedJobs[indexPath.row].location ?? "N/A",
                           status: data.savedJobs[indexPath.row].status ?? "open",
                           favorite: data.savedJobs[indexPath.row].favorite,
                           dateLastUpdated: data.savedJobs[indexPath.row].dateLastUpdated)
        }
        return cell
    }
    
    func handleMoveItem(data: JobData) {
        for i in 0..<data.savedJobs.count {
            data.savedJobs[i].displayOrder = i as NSNumber
            
            DataManager.updateJob(job: data.savedJobs[i].self,
                                  company: data.savedJobs[i].company ?? "",
                                  role: data.savedJobs[i].role,
                                  location: data.savedJobs[i].location,
                                  status: data.savedJobs[i].status,
                                  link: data.savedJobs[i].link,
                                  notes: data.savedJobs[i].notes,
                                  dateLastUpdated: data.savedJobs[i].dateLastUpdated,
                                  dateApplied: data.savedJobs[i].dateApplied,
                                  displayOrder: data.savedJobs[i].displayOrder ?? 0)
        }
    }
}
