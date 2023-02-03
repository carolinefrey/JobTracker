//
//  DataManager.swift
//  JobTracker
//
//  Created by Caroline Frey on 11/17/22.
//

import Foundation
import CoreData
import UIKit


class DataManager {
    
    static let managedObjectContext: NSManagedObjectContext = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }()
    
    // MARK: - Create
    
    static func addJob(company: String, role: String?, location: String?, status: JobStatus, link: String?, notes: String?, dateApplied: Date?) {
        let job = Job(context: managedObjectContext)
        job.company = company
        job.role = role
        job.location = location
        job.status = status.rawValue
        job.link = link
        job.notes = notes
        job.dateApplied = dateApplied
        job.displayOrder = 0
        job.favorite = false
        
        do {
            try managedObjectContext.save()
        }
        catch {
            
        }
    }
    
    // MARK: - Read
    
    static func fetchJobs(completion: ([Job]?) -> Void) {
        do {
            let jobs = try managedObjectContext.fetch(Job.fetchRequest())
            completion(jobs)
        }
        catch {
            
        }
        
        completion(nil)
    }
    
    static func fetchJob(job: String, completion: (Job?) -> Void) {
        let fetchRequest = NSFetchRequest<Job>(entityName: "Job")
        fetchRequest.predicate = NSPredicate(format: "job == %@", job)
        
        do {
            let job = try managedObjectContext.fetch(fetchRequest)
            completion(job.first)
        }
        catch {
            print("Could not fetch due to error: \(error.localizedDescription)")
        }
        
        completion(nil)
    }
    
    // MARK: - Update
    
    static func updateJob(job: Job, company: String, role: String?, location: String?, status: String?, link: String?, notes: String?, dateApplied: Date?, displayOrder: NSNumber = 0) {
        job.company = company
        job.role = role
        job.location = location
        job.status = status
        job.link = link
        job.notes = notes
        job.dateApplied = dateApplied
        job.displayOrder = displayOrder
        
        do {
            try managedObjectContext.save()
        }
        catch {
            
        }
    }
    
    static func favoriteJob(job: Job, favorite: Bool) {
        job.favorite = favorite
        
        do {
            try managedObjectContext.save()
        }
        catch {
            
        }
    }
    
    // MARK: - Delete
    
    static func deleteJob(item: Job) {
        managedObjectContext.delete(item)
        
        do {
            try managedObjectContext.save()
        }
        catch {
            
        }
    }
}
