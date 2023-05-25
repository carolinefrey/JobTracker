//
//  DashboardViewController.swift
//  JobTracker
//
//  Created by Caroline Frey on 11/23/22.
//

import UIKit

class DashboardViewController: UIViewController {
    
    // MARK: - Class Properties
    
    let defaults = UserDefaults.standard
    
    private var contentView: DashboardContentView!
    
    private let viewModel: DashboardViewModel
    
    private var data = JobData()
    
    // MARK: - UI Properties
    
    var name: String = ""
    var collectionViewEditMode = false
    var selectedJobApps: [Job] = []

    private var statusCounts: [String: Int] = ["open": 0, "applied": 0, "interview": 0, "closed": 0]
    
    lazy var settingsButton: UIBarButtonItem = {
        let config = UIImage.SymbolConfiguration(textStyle: .title3)
        let icon = UIImage(systemName: "gear", withConfiguration: config)
        let button = UIBarButtonItem(image: icon, style: .plain, target: self, action: #selector(presentSettingsView))
        button.tintColor = UIColor(named: "Color4")
        return button
    }()
    
    // MARK: - Initializer
    
    init(viewModel: DashboardViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        navigationItem.rightBarButtonItem = settingsButton
        
        contentView = DashboardContentView()
        view = contentView
            
        configureHeaderView()
        configureStatusBoxDelegates()
        configureCollectionView()
        
        data.savedJobs = viewModel.fetchJobs()
        sortJobs()
        
        updateJobStatusCounts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        data.savedJobs = viewModel.fetchJobs()
        sortJobs()
        
        contentView.collectionView.reloadData()
        updateJobStatusCounts()
    }
    
    // MARK: - Functions
    
    private func configureHeaderView() {
        name = defaults.string(forKey: "name") ?? ""

        if name != "" {
            contentView.headerView.greeting.text = "Hey, \(name)!"
        } else {
            contentView.headerView.greeting.text = "JobApp Tracker"
        }
    }
    
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
        
        for job in data.savedJobs {
            statusCounts[job.status ?? "open", default: 0] += 1
        }
        
        contentView.statusBoxes.openStatusBox.countLabel.text = "\(statusCounts["open"] ?? 0)"
        contentView.statusBoxes.appliedStatusBox.countLabel.text = "\(statusCounts["applied"] ?? 0)"
        contentView.statusBoxes.interviewStatusBox.countLabel.text = "\(statusCounts["interview"] ?? 0)"
        contentView.statusBoxes.closedStatusBox.countLabel.text = "\(statusCounts["closed"] ?? 0)"
    }
    
    private func sortJobs() {
        data.savedJobs = viewModel.sortJobs(jobsToSort: data.savedJobs)
        data.filteredJobs = viewModel.sortJobs(jobsToSort: data.filteredJobs)
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
        collectionView.backgroundView = viewModel.handleToggleEmptyMessage(jobData: data)
        return viewModel.handleNumItemsInSection(jobData: data)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DashboardCollectionViewCell.dashboardCollectionViewCellIdentifier, for: indexPath) as! DashboardCollectionViewCell
        
        viewModel.handleCellForItemAt(data: data, cell: cell, indexPath: indexPath)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item = data.savedJobs.remove(at: sourceIndexPath.row) //move the job within the actual data array
        data.savedJobs.insert(item, at: destinationIndexPath.row)
        
        viewModel.handleMoveItem(data: data)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier, for: indexPath) as! HeaderCollectionReusableView
        header.configure(editMode: collectionViewEditMode)
        header.headerCollectionViewDelegate = self
        return header
    }
}

// MARK: - UICollectionViewDelegate

extension DashboardViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if data.filtersApplied != [] {
            let detailVC = JobDetailsViewController(job: data.filteredJobs[indexPath.row])
            detailVC.deleteJobDelegate = self //to pass through to EditJobVC
            navigationController?.pushViewController(detailVC, animated: true)
        } else if collectionViewEditMode {
            selectedJobApps.append(data.savedJobs[indexPath.row])
        } else {
            let detailVC = JobDetailsViewController(job: data.savedJobs[indexPath.row])
            detailVC.deleteJobDelegate = self //to pass through to EditJobVC
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}

// MARK: - SetUsernameDelegate

extension DashboardViewController: SetUsernameDelegate {
    func didUpdateSettings(name: String) {
        if name != "" {
            contentView.headerView.greeting.text = "Hey, \(name)!"
        } else {
            contentView.headerView.greeting.text = "JobApp Tracker"
        }
    }
}

// MARK: - HeaderCollectionReusableViewDelegate

extension DashboardViewController: HeaderCollectionReusableViewDelegate {
    func tapFavoritesFilterButton(button: UIButton) {
        if data.filterByFavorites { //remove filter
            data.filterByFavorites = false
            
            button.setImage(UIImage(systemName: "heart"), for: .normal)
            button.tintColor = .black
            button.setTitle("view favorites", for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.backgroundColor = UIColor(named: "FavoriteButtonColor")
            
            data.favoritedJobs.removeAll()
            tapStatusBox(button)
            contentView.collectionView.reloadData()
        } else { //filter by favorites
            data.filterByFavorites = true
            
            button.setImage(UIImage(systemName: "circle.grid.2x2.fill"), for: .normal)
            button.tintColor = .black
            button.setTitle("view all", for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.backgroundColor = .lightGray
                        
            data.favoritedJobs = data.savedJobs.filter { job in
                return job.favorite == true
            }
            data.filtersApplied.removeAll()
            tapStatusBox(button)
            contentView.collectionView.reloadData()
        }
    }
    
    func tapAddNewJobButton() {
        let addNewJobVC = AddJobViewController()
        navigationController?.pushViewController(addNewJobVC, animated: true)
    }

    func tapEditJobsButton() {
        collectionViewEditMode = true
        
        contentView.collectionView.reloadData()
    }
    
    func tapDoneButton() {
        collectionViewEditMode = false
        
        contentView.collectionView.reloadData()
    }
    
    func batchDeleteJobs() {
        for job in selectedJobApps {
            DataManager.deleteJob(item: job)
            data.savedJobs.removeAll { $0 == job }
            data.filteredJobs.removeAll { $0 == job }
            data.favoritedJobs.removeAll { $0 == job }
        }
        contentView.collectionView.reloadData()
    }
}

// MARK: - JobDeletedDelegate

extension DashboardViewController: DeleteJobDelegate {
    func didDeleteJob(job: Job) {
        data.filteredJobs.removeAll { $0 == job }
        data.favoritedJobs.removeAll { $0 == job }
    }
}

// MARK: - StatusBoxViewDelegate

extension DashboardViewController: StatusBoxViewDelegate {
    func tapStatusBox(_ sender: UIButton) {
        switch sender {
        case contentView.statusBoxes.openStatusBox.box:
            if data.filtersApplied.contains(.open) {
                contentView.configureDefaultStatusButtonAppearance(status: .open)
                data.filtersApplied.removeAll { $0 == .open }
            } else {
                contentView.configureFilteredStatusButtonAppearance(status: .open)
                data.filtersApplied.append(.open)
                if data.filterByFavorites {  //turn off favorites filter if a status box is selected (they're mutually exclusive)
                    data.filterByFavorites = false
                }
            }
        case contentView.statusBoxes.appliedStatusBox.box:
            if data.filtersApplied.contains(.applied) {
                contentView.configureDefaultStatusButtonAppearance(status: .applied)
                data.filtersApplied.removeAll { $0 == .applied }
            } else {
                contentView.configureFilteredStatusButtonAppearance(status: .applied)
                data.filtersApplied.append(.applied)
                if data.filterByFavorites {
                    data.filterByFavorites = false
                }
            }
        case contentView.statusBoxes.interviewStatusBox.box:
            if data.filtersApplied.contains(.interview) {
                contentView.configureDefaultStatusButtonAppearance(status: .interview)
                data.filtersApplied.removeAll { $0 == .interview }
            } else {
                contentView.configureFilteredStatusButtonAppearance(status: .interview)
                data.filtersApplied.append(.interview)
                if data.filterByFavorites {
                    data.filterByFavorites = false
                }
            }
        case contentView.statusBoxes.closedStatusBox.box:
            if data.filtersApplied.contains(.closed) {
                contentView.configureDefaultStatusButtonAppearance(status: .closed)
                data.filtersApplied.removeAll { $0 == .closed }
            } else {
                contentView.configureFilteredStatusButtonAppearance(status: .closed)
                data.filtersApplied.append(.closed)
                if data.filterByFavorites {
                    data.filterByFavorites = false
                }
            }
        default: //falls to this case when "view favorites" is tapped. removes all status filters.
            contentView.configureDefaultStatusButtonAppearance(status: .open)
            contentView.configureDefaultStatusButtonAppearance(status: .closed)
            contentView.configureDefaultStatusButtonAppearance(status: .interview)
            contentView.configureDefaultStatusButtonAppearance(status: .applied)
        }
        data.filteredJobs = data.savedJobs.filter { job in
            return data.filtersApplied.contains(JobStatus(rawValue: job.status!)!)
        }
        contentView.collectionView.reloadData()
    }
}

