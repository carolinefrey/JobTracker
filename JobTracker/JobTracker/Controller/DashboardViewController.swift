//
//  DashboardViewController.swift
//  JobTracker
//
//  Created by Caroline Frey on 11/23/22.
//

import UIKit

class DashboardViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    
    // MARK: - UI Properties
    
    var name: String = ""
    
    private var contentView: DashboardContentView!
    
    private var statusCounts: [String: Int] = ["open": 0, "applied": 0, "interview": 0, "closed": 0]
    
    private var savedJobs = [Job]()
    private var favoritedJobs = [Job]()
    private var filterByFavorites: Bool = false
    private var filteredJobs = [Job]()
    private var filtersApplied = [JobStatus]()

    lazy var settingsButton: UIBarButtonItem = {
        let config = UIImage.SymbolConfiguration(textStyle: .title3)
        let icon = UIImage(systemName: "gear", withConfiguration: config)
        let button = UIBarButtonItem(image: icon, style: .plain, target: self, action: #selector(presentSettingsView))
        button.tintColor = UIColor(named: "Color4")
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        navigationItem.rightBarButtonItem = settingsButton
        
        contentView = DashboardContentView()
        view = contentView
        
        name = defaults.string(forKey: "name") ?? ""
        
        if name != "" {
            contentView.headerView.greeting.text = "Hey, \(name)!"
        } else {
            contentView.headerView.greeting.text = "Hey!"
        }
        
        configureStatusBoxDelegates()
        configureCollectionView()
        fetchJobs()
        updateJobStatusCounts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchJobs()
        contentView.collectionView.reloadData()
        updateJobStatusCounts()
    }
    
    // MARK: - Functions
    
    private func configureStatusBoxDelegates() {
        contentView.statusBoxes.openStatusBox.delegate = self
        contentView.statusBoxes.appliedStatusBox.delegate = self
        contentView.statusBoxes.interviewStatusBox.delegate = self
        contentView.statusBoxes.closedStatusBox.delegate = self
    }
    
    private func configureCollectionView() {
        contentView.collectionView.dataSource = self
        contentView.collectionView.delegate = self
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressGesture(_:)))
        contentView.collectionView.addGestureRecognizer(gesture)
    }
    
    private func updateJobStatusCounts() {
        statusCounts = ["open": 0, "applied": 0, "interview": 0, "closed": 0]
        
        for job in savedJobs {
            statusCounts[job.status ?? "open", default: 0] += 1
        }
        
        contentView.statusBoxes.openStatusBox.countLabel.text = "\(statusCounts["open"] ?? 0)"
        contentView.statusBoxes.appliedStatusBox.countLabel.text = "\(statusCounts["applied"] ?? 0)"
        contentView.statusBoxes.interviewStatusBox.countLabel.text = "\(statusCounts["interview"] ?? 0)"
        contentView.statusBoxes.closedStatusBox.countLabel.text = "\(statusCounts["closed"] ?? 0)"
    }
    
    private func fetchJobs() {
        DataManager.fetchJobs { [weak self] jobs in
            if let fetchedJobs = jobs {
                savedJobs = fetchedJobs
            }
            DispatchQueue.main.async { [weak self] in
                self?.contentView.collectionView.reloadData()
            }
        }
        sortJobs()
    }
    
    private func sortJobs() {
        savedJobs.sort { job1, job2 in
            return job1.displayOrder?.intValue ?? 0 <= job2.displayOrder?.intValue ?? 0
        }
        filteredJobs.sort { job1, job2 in
            return job1.displayOrder?.intValue ?? 0 <= job2.displayOrder?.intValue ?? 0
        }
    }
    
    // MARK: - Selector Functions
    
    @objc func handleLongPressGesture(_ gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
        case .began:
            guard let targetIndexPath = contentView.collectionView.indexPathForItem(at: gesture.location(in: contentView.collectionView)) else {
                return
            }
            contentView.collectionView.beginInteractiveMovementForItem(at: targetIndexPath)
        case .changed:
            contentView.collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: contentView.collectionView))
        case .ended:
            contentView.collectionView.endInteractiveMovement()
        default:
            contentView.collectionView.cancelInteractiveMovement()
        }
    }
    
    @objc func presentSettingsView() {
        let settingsVC = SettingsViewController()
        settingsVC.delegate = self
        present(settingsVC, animated: true)
    }
}

// MARK: - UICollectionViewDataSource

extension DashboardViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if filtersApplied != [] {
            if filteredJobs.count == 0 {
                collectionView.displayEmptyMessage()
            } else {
                collectionView.restore()
            }
            return filteredJobs.count
        } else if favoritedJobs != [] && filterByFavorites {
            return favoritedJobs.count
        } else {
            if savedJobs.count == 0 {
                collectionView.displayEmptyMessage()
            } else {
                collectionView.restore()
            }
            return savedJobs.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DashboardCollectionViewCell.dashboardCollectionViewCellIdentifier, for: indexPath) as! DashboardCollectionViewCell

        if filtersApplied != [] {
            cell.configure(company: filteredJobs[indexPath.row].company ?? "N/A", location: filteredJobs[indexPath.row].location ?? "N/A", status: filteredJobs[indexPath.row].status ?? "open", favorite: filteredJobs[indexPath.row].favorite)
        } else if favoritedJobs != [] && filterByFavorites {
            cell.configure(company: favoritedJobs[indexPath.row].company ?? "N/A", location: favoritedJobs[indexPath.row].location ?? "N/A", status: favoritedJobs[indexPath.row].status ?? "open", favorite: favoritedJobs[indexPath.row].favorite)
        } else {
            cell.configure(company: savedJobs[indexPath.row].company ?? "N/A", location: savedJobs[indexPath.row].location ?? "N/A", status: savedJobs[indexPath.row].status ?? "open", favorite: savedJobs[indexPath.row].favorite)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item = savedJobs.remove(at: sourceIndexPath.row) //move the job within the actual data array
        savedJobs.insert(item, at: destinationIndexPath.row)
        
        for i in 0..<savedJobs.count {
            savedJobs[i].displayOrder = i as NSNumber
            
            DataManager.updateJob(job: savedJobs[i].self, company: savedJobs[i].company ?? "", role: savedJobs[i].role, location: savedJobs[i].location, status: savedJobs[i].status, link: savedJobs[i].link, notes: savedJobs[i].notes, dateApplied: savedJobs[i].dateApplied, displayOrder: savedJobs[i].displayOrder ?? 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier, for: indexPath) as! HeaderCollectionReusableView
        header.configure()
        header.newJobDelegate = self
        header.filterByFavoritesDelegate = self
        return header
    }
}

// MARK: - UICollectionViewDelegate

extension DashboardViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if filtersApplied != [] {
            let detailVC = JobDetailsViewController(job: filteredJobs[indexPath.row])
            detailVC.deleteJobDelegate = self //to pass through to EditJobVC
            navigationController?.pushViewController(detailVC, animated: true)
        } else {
            let detailVC = JobDetailsViewController(job: savedJobs[indexPath.row])
            detailVC.deleteJobDelegate = self //to pass through to EditJobVC
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}

// MARK: - UICollectionView Extension

extension UICollectionView {
    func displayEmptyMessage() {
        let messageLabel = UILabel()
        messageLabel.text = "Add a job by clicking the plus button!"
        messageLabel.font = UIFont(name: "Nunito-Regular", size: 16)
        messageLabel.textAlignment = .center
        messageLabel.textColor = UIColor(named: "Color4")
        
        self.backgroundView = messageLabel
    }
    
    func restore() {
        self.backgroundView = nil
    }
}

// MARK: - SetUsernameDelegate

extension DashboardViewController: SetUsernameDelegate {
    func didUpdateSettings(name: String) {
        if name != "" {
            contentView.headerView.greeting.text = "Hey, \(name)!"
        } else {
            contentView.headerView.greeting.text = "Hey!"
        }
    }
}

// MARK: - HeaderCollectionReusableViewDelegate

extension DashboardViewController: HeaderCollectionReusableViewDelegate {
    func tapAddNewJobButton() {
        let addNewJobVC = AddJobViewController()
        navigationController?.pushViewController(addNewJobVC, animated: true)
    }
}

// MARK: - HeaderCollectionReusableViewDelegate

extension DashboardViewController: FilterByFavoritesDelegate {
    func tapFilterButton(button: UIButton) {
        if filterByFavorites {
            filterByFavorites = false
            
            button.setImage(UIImage(systemName: "heart"), for: .normal)
            button.tintColor = .black
            button.setTitle("view favorites", for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.backgroundColor = UIColor(named: "FavoriteButtonColor")
            
            favoritedJobs.removeAll()
            contentView.collectionView.reloadData()
        } else {
            filterByFavorites = true
            
            button.setImage(UIImage(systemName: "circle.grid.2x2.fill"), for: .normal)
            button.tintColor = .black
            button.setTitle("view all", for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.backgroundColor = .lightGray
                        
            favoritedJobs = savedJobs.filter { job in
                return job.favorite == true
            }
            contentView.collectionView.reloadData()
        }
    }
}

// MARK: - JobDeletedDelegate
extension DashboardViewController: DeleteJobDelegate {
    func didDeleteJob(job: Job) {
        filteredJobs.removeAll { filteredJob in
            filteredJob == job
        }
        favoritedJobs.removeAll { favoritedJob in
            favoritedJob == job
        }
    }
}

// MARK: - StatusBoxViewDelegate

extension DashboardViewController: StatusBoxViewDelegate {
    func tapStatusBox(_ sender: UIButton) {
        switch sender {
        case contentView.statusBoxes.openStatusBox.box:
            if filtersApplied.contains(.open) {
                contentView.configureDefaultStatusButtonAppearance(status: .open)
                filtersApplied.removeAll { status in
                    status == .open
                }
            } else {
                contentView.configureFilteredStatusButtonAppearance(status: .open)
                filtersApplied.append(.open)
            }
        case contentView.statusBoxes.appliedStatusBox.box:
            if filtersApplied.contains(.applied) {
                contentView.configureDefaultStatusButtonAppearance(status: .applied)
                filtersApplied.removeAll { status in
                    status == .applied
                }
            } else {
                contentView.configureFilteredStatusButtonAppearance(status: .applied)
                filtersApplied.append(.applied)
            }
        case contentView.statusBoxes.interviewStatusBox.box:
            if filtersApplied.contains(.interview) {
                contentView.configureDefaultStatusButtonAppearance(status: .interview)
                filtersApplied.removeAll { status in
                    status == .interview
                }
            } else {
                contentView.configureFilteredStatusButtonAppearance(status: .interview)
                filtersApplied.append(.interview)
            }
        case contentView.statusBoxes.closedStatusBox.box:
            if filtersApplied.contains(.closed) {
                contentView.configureDefaultStatusButtonAppearance(status: .closed)
                filtersApplied.removeAll { status in
                    status == .closed
                }
            } else {
                contentView.configureFilteredStatusButtonAppearance(status: .closed)
                filtersApplied.append(.closed)
            }
        default:
            return
        }
        filteredJobs = savedJobs.filter { job in
            return filtersApplied.contains(JobStatus(rawValue: job.status!)!)
        }
        contentView.collectionView.reloadData()
    }
}

