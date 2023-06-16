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
    private var jobData = JobData()
    
    // MARK: - UI Properties
    
    var name: String = ""
    var collectionViewEditMode = false      
    var selectedJobApps: [Job] = []

    private var statusCounts: [JobStatus: Int] = [.open: 0, .applied: 0, .interview: 0, .closed: 0]
    
    lazy var settingsButton: UIBarButtonItem = {
        let config = UIImage.SymbolConfiguration(textStyle: .title3)
        let icon = UIImage(systemName: "gear", withConfiguration: config)
        let button = UIBarButtonItem(image: icon, style: .plain, target: self, action: #selector(presentSettingsView))
        button.tintColor = UIColor.black
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
        
        jobData.savedJobs = viewModel.fetchJobs()
        sortJobs()
        
        updateJobStatusCounts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        jobData.savedJobs = viewModel.fetchJobs()
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
        statusCounts = [.open: 0, .applied: 0, .interview: 0, .closed: 0]
        
        for job in jobData.savedJobs {
            statusCounts[JobStatus(rawValue: job.status!)!, default: 0] += 1
        }
        
        contentView.statusBoxes.openStatusBox.countLabel.text = "\(statusCounts[.open] ?? 0)"
        contentView.statusBoxes.appliedStatusBox.countLabel.text = "\(statusCounts[.applied] ?? 0)"
        contentView.statusBoxes.interviewStatusBox.countLabel.text = "\(statusCounts[.interview] ?? 0)"
        contentView.statusBoxes.closedStatusBox.countLabel.text = "\(statusCounts[.closed] ?? 0)"
    }
    
    private func sortJobs() {
        viewModel.sortJobs(&jobData.savedJobs)
        viewModel.sortJobs(&jobData.filteredJobs)
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
        collectionView.backgroundView = viewModel.handleToggleEmptyMessage(jobData)
        return viewModel.handleNumItemsInSection(jobData)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DashboardCollectionViewCell.dashboardCollectionViewCellIdentifier, for: indexPath) as! DashboardCollectionViewCell
        
        return viewModel.handleCellForItemAt(jobData, cell: cell, indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item = jobData.savedJobs.remove(at: sourceIndexPath.row) //move the job within the actual data array
        jobData.savedJobs.insert(item, at: destinationIndexPath.row)
        
        viewModel.handleMoveItem(jobData)
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
        let cell = collectionView.cellForItem(at: indexPath) as! DashboardCollectionViewCell
        animateCellSelection(cell: cell, select: true)
        if collectionViewEditMode {
            if jobData.filtersApplied != [] {
                selectedJobApps.append(jobData.filteredJobs[indexPath.row])
            } else if jobData.filterByFavorites {
                selectedJobApps.append(jobData.favoritedJobs[indexPath.row])
            } else {
                selectedJobApps.append(jobData.savedJobs[indexPath.row])
            }
        } else if jobData.filtersApplied != [] {
            let detailVC = JobDetailsViewController(dashboardVC: self, job: jobData.filteredJobs[indexPath.row])
            detailVC.deleteJobDelegate = self //to pass through to EditJobVC
            detailVC.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(detailVC, animated: true)
        } else if jobData.filterByFavorites {
            let detailVC = JobDetailsViewController(dashboardVC: self, job: jobData.favoritedJobs[indexPath.row])
            detailVC.deleteJobDelegate = self //to pass through to EditJobVC
            detailVC.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(detailVC, animated: true)
        } else {
            let detailVC = JobDetailsViewController(dashboardVC: self, job: jobData.savedJobs[indexPath.row])
            detailVC.deleteJobDelegate = self //to pass through to EditJobVC
            detailVC.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? DashboardCollectionViewCell {
            animateCellSelection(cell: cell, select: false)
        }
        selectedJobApps.removeAll { $0 == jobData.savedJobs[indexPath.row] }
    }
    
    func animateCellSelection(cell: DashboardCollectionViewCell, select: Bool) {
        if select {
            UIView.animate(withDuration: 0.06, animations: {
                cell.alpha = 0.5
            })
        } else {
            UIView.animate(withDuration: 0.06, animations: {
                cell.alpha = 1
            })
        }
    }
}

// MARK: - SetUsernameDelegate

extension DashboardViewController: UpdateSettingsDelegate {
    func updateUsername(name: String) {
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
        if jobData.filterByFavorites { //remove filter
            jobData.filterByFavorites = false
            configureFavoritesButton(filterState: jobData.filterByFavorites)
            jobData.favoritedJobs.removeAll()
            tapStatusBox(button)
            contentView.collectionView.reloadData()
        } else { //filter by favorites
            jobData.filterByFavorites = true
            configureFavoritesButton(filterState: jobData.filterByFavorites)
            jobData.favoritedJobs = jobData.savedJobs.filter { job in
                return job.favorite == true
            }
            jobData.filtersApplied.removeAll()
            tapStatusBox(button)
            contentView.collectionView.reloadData()
        }
        
        func configureFavoritesButton(filterState: Bool) {
            if filterState {
                button.configuration?.title = "view all"
                button.configuration?.buttonSize = .small
                button.configuration?.image = UIImage(systemName: "circle.grid.2x2.fill")
                button.configuration?.imagePlacement = .leading
                button.configuration?.imagePadding = 5
                button.configuration?.baseBackgroundColor = .lightGray
                button.configuration?.baseForegroundColor = .black
            } else {
                button.configuration?.title = "view favorites"
                button.configuration?.buttonSize = .small
                button.configuration?.image = UIImage(systemName: "heart")
                button.configuration?.imagePlacement = .leading
                button.configuration?.imagePadding = 5
                button.configuration?.baseBackgroundColor = UIColor.favoriteButton
                button.configuration?.baseForegroundColor = .black
            }
        }
    }
    
    func tapAddNewJobButton() {
        let addNewJobVC = AddJobViewController(viewModel: AddEditViewModel())
        addNewJobVC.jobAddedDelegate = self
        addNewJobVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(addNewJobVC, animated: true)
    }

    func tapDeleteTasksButton() {
        collectionViewEditMode = true
        contentView.collectionView.allowsMultipleSelection = true
        contentView.collectionView.reloadData()
    }
    
    func tapDoneButton() {
        collectionViewEditMode = false
        contentView.collectionView.allowsMultipleSelection = false
        selectedJobApps.removeAll()
        contentView.collectionView.reloadData()
    }
    
    func batchDeleteJobs() {
        //delete selected jobs
        for job in selectedJobApps {
            DataManager.deleteJob(item: job)
            jobData.savedJobs.removeAll { $0 == job }
            jobData.filteredJobs.removeAll { $0 == job }
            jobData.favoritedJobs.removeAll { $0 == job }
        }
        selectedJobApps.removeAll()
        updateJobStatusCounts()
        contentView.collectionView.reloadData()
    }
}

// MARK: - JobDeletedDelegate

extension DashboardViewController: DeleteJobDelegate {
    func didDeleteJob(_ job: Job) {
        jobData.filteredJobs.removeAll { $0 == job }
        jobData.favoritedJobs.removeAll { $0 == job }
    }
}

// MARK: - JobAddedDelegate

extension DashboardViewController: JobAddedDelegate {
    func jobAdded(withStatus status: JobStatus) {
        jobData.savedJobs = viewModel.fetchJobs()
        if jobData.filtersApplied.contains(status) {
            jobData.filteredJobs = jobData.savedJobs.filter { job in
                return jobData.filtersApplied.contains(JobStatus(rawValue: job.status!)!)
            }
        }
        contentView.collectionView.reloadData()
    }
}

// MARK: - StatusBoxViewDelegate

extension DashboardViewController: StatusBoxViewDelegate {
    func tapStatusBox(_ sender: UIButton) {
        enum SenderButtonType {
            case statusBox, viewFavorites
        }
        
        var senderType: SenderButtonType {
            if sender == contentView.statusBoxes.openStatusBox.box || sender == contentView.statusBoxes.appliedStatusBox.box || sender == contentView.statusBoxes.interviewStatusBox.box || sender == contentView.statusBoxes.closedStatusBox.box {
                return .statusBox
            } else {
                return .viewFavorites
            }
        }
        
        var status: JobStatus {
            switch sender {
            case contentView.statusBoxes.openStatusBox.box:
                return .open
            case contentView.statusBoxes.appliedStatusBox.box:
                return .applied
            case contentView.statusBoxes.interviewStatusBox.box:
                return .interview
            default:
                return .closed
            }
        }
        
        switch senderType {
        case .statusBox:
            if jobData.filtersApplied.contains(status) {
                contentView.configureStatusButtonAppearance(state: .normal, forStatus: status)
                jobData.filtersApplied.removeAll { $0 == status }
            } else {
                contentView.configureStatusButtonAppearance(state: .selected, forStatus: status)
                jobData.filtersApplied.append(status)
            }
        default:
            contentView.configureStatusButtonAppearance(state: .normal, forStatus: .open)
            contentView.configureStatusButtonAppearance(state: .normal, forStatus: .closed)
            contentView.configureStatusButtonAppearance(state: .normal, forStatus: .interview)
            contentView.configureStatusButtonAppearance(state: .normal, forStatus: .applied)
        }
        
        jobData.filteredJobs = jobData.savedJobs.filter { job in
            return jobData.filtersApplied.contains(JobStatus(rawValue: job.status!)!)
        }
        contentView.collectionView.reloadData()
    }
}

