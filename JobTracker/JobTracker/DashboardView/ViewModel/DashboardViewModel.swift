//
//  DashboardViewModel.swift
//  JobTracker
//
//  Created by Caroline Frey on 5/22/23.
//

import Foundation
import UIKit

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
    
    func sortJobs(_ jobsToSort: [Job]) -> [Job] {
        var sortedJobs = jobsToSort
        sortedJobs.sort { job1, job2 in
            return job1.displayOrder?.intValue ?? 0 <= job2.displayOrder?.intValue ?? 0
        }
        return sortedJobs
    }

    func handleNumItemsInSection(_ jobData: JobData) -> Int {
        if jobData.filtersApplied != [] {
            return jobData.filteredJobs.count
        } else if jobData.filterByFavorites {
            return jobData.favoritedJobs.count
        } else {
            return jobData.savedJobs.count
        }
    }
    
    func handleToggleEmptyMessage(_ jobData: JobData) -> UILabel {
        var messageLabel = UILabel()
        if jobData.filtersApplied != [] {
            messageLabel = jobData.filteredJobs.count == 0 ? displayMessage(.noFilteredJobs) : displayMessage(.none)
        } else if jobData.filterByFavorites {
            messageLabel = jobData.favoritedJobs.count == 0 ? displayMessage(.noFavorites) : displayMessage(.none)
        } else {
            messageLabel = jobData.savedJobs.count == 0 ? displayMessage(.noJobs) : displayMessage(.none)
        }
        return messageLabel
    }

    //UI related - technically, should not be in VM
    func displayMessage(_ message: CollectionViewMessageLabelCase) -> UILabel {
        let messageLabel = UILabel()
        if message == .noJobs || message == .noFilteredJobs {
            messageLabel.text = "Add a job by clicking the plus button!"
            messageLabel.font = UIFont(name: "Nunito-Regular", size: 16)
            messageLabel.textAlignment = .center
            messageLabel.textColor = UIColor.colorFour
        } else if message == .noFavorites {
            messageLabel.text = "Favorite a job application by selecting it and tapping the heart in the top right corner!"
            messageLabel.font = UIFont(name: "Nunito-Regular", size: 16)
            messageLabel.textAlignment = .center
            messageLabel.textColor = UIColor.colorFour
            messageLabel.lineBreakMode = .byWordWrapping
            messageLabel.numberOfLines = 0
        }
        return messageLabel
    }

    func handleCellForItemAt(_ jobData: JobData, cell: DashboardCollectionViewCell, indexPath: IndexPath) -> DashboardCollectionViewCell {
        if jobData.filtersApplied != [] {
            cell.configure(company: jobData.filteredJobs[indexPath.row].company ?? "N/A",
                           location: jobData.filteredJobs[indexPath.row].location ?? "N/A",
                           status: jobData.filteredJobs[indexPath.row].status ?? "open",
                           favorite: jobData.filteredJobs[indexPath.row].favorite,
                           dateLastUpdated: jobData.filteredJobs[indexPath.row].dateLastUpdated)
        } else if jobData.favoritedJobs != [] && jobData.filterByFavorites {
            cell.configure(company: jobData.favoritedJobs[indexPath.row].company ?? "N/A",
                           location: jobData.favoritedJobs[indexPath.row].location ?? "N/A",
                           status: jobData.favoritedJobs[indexPath.row].status ?? "open",
                           favorite: jobData.favoritedJobs[indexPath.row].favorite,
                           dateLastUpdated: jobData.favoritedJobs[indexPath.row].dateLastUpdated)
        } else {
            cell.configure(company: jobData.savedJobs[indexPath.row].company ?? "N/A",
                           location: jobData.savedJobs[indexPath.row].location ?? "N/A",
                           status: jobData.savedJobs[indexPath.row].status ?? "open",
                           favorite: jobData.savedJobs[indexPath.row].favorite,
                           dateLastUpdated: jobData.savedJobs[indexPath.row].dateLastUpdated)
        }
        return cell
    }
    
    func handleMoveItem(_ jobData: JobData) {
        for i in 0..<jobData.savedJobs.count {
            jobData.savedJobs[i].displayOrder = i as NSNumber
            
            DataManager.updateJob(job: jobData.savedJobs[i].self,
                                  company: jobData.savedJobs[i].company ?? "",
                                  role: jobData.savedJobs[i].role,
                                  location: jobData.savedJobs[i].location,
                                  status: jobData.savedJobs[i].status,
                                  link: jobData.savedJobs[i].link,
                                  notes: jobData.savedJobs[i].notes,
                                  dateLastUpdated: jobData.savedJobs[i].dateLastUpdated,
                                  dateApplied: jobData.savedJobs[i].dateApplied,
                                  displayOrder: jobData.savedJobs[i].displayOrder ?? 0)
        }
    }
}
