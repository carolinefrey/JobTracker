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
        } else if jobData.favoritedJobs != [] && jobData.filterByFavorites {
            return jobData.favoritedJobs.count
        } else {
            return jobData.savedJobs.count
        }
    }
    
    func handleToggleEmptyMessage(jobData: JobData) -> UILabel {
        var messageLabel = UILabel()
        if jobData.filtersApplied != [] {
            messageLabel = jobData.filteredJobs.count == 0 ? showEmptyMessage(show: true) : showEmptyMessage(show: false)
        } else if jobData.favoritedJobs != [] && jobData.filterByFavorites {
            messageLabel = showEmptyMessage(show: false)
        } else {
            messageLabel = jobData.savedJobs.count == 0 ? showEmptyMessage(show: true) : showEmptyMessage(show: false)
        }
        return messageLabel
    }

    func showEmptyMessage(show: Bool) -> UILabel {
        let messageLabel = UILabel()
        if show {
            messageLabel.text = "Add a job by clicking the plus button!"
            messageLabel.font = UIFont(name: "Nunito-Regular", size: 16)
            messageLabel.textAlignment = .center
            messageLabel.textColor = UIColor(named: "Color4")
        }
        return messageLabel
    }

    func handleCellForItemAt(data: JobData, cell: DashboardCollectionViewCell, indexPath: IndexPath) -> DashboardCollectionViewCell {
        if data.filtersApplied != [] {
            cell.configure(company: data.filteredJobs[indexPath.row].company ?? "N/A",
                           location: data.filteredJobs[indexPath.row].location ?? "N/A",
                           status: data.filteredJobs[indexPath.row].status ?? "open",
                           favorite: data.filteredJobs[indexPath.row].favorite)
        } else if data.favoritedJobs != [] && data.filterByFavorites {
            cell.configure(company: data.favoritedJobs[indexPath.row].company ?? "N/A",
                           location: data.favoritedJobs[indexPath.row].location ?? "N/A",
                           status: data.favoritedJobs[indexPath.row].status ?? "open",
                           favorite: data.favoritedJobs[indexPath.row].favorite)
        } else {
            cell.configure(company: data.savedJobs[indexPath.row].company ?? "N/A",
                           location: data.savedJobs[indexPath.row].location ?? "N/A",
                           status: data.savedJobs[indexPath.row].status ?? "open",
                           favorite: data.savedJobs[indexPath.row].favorite)
        }
        cell.removeCheckmark()
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
                                  dateApplied: data.savedJobs[i].dateApplied,
                                  displayOrder: data.savedJobs[i].displayOrder ?? 0)
        }
    }
}
