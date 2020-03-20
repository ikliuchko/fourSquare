//
//  VenuesViewController.swift
//  FourSquare
//
//  Created by JBS Solutions on 16.03.2020.
//  Copyright © 2020 JBSolutions. All rights reserved.
//

import UIKit

final class VenueViewController: UIViewController {
    
    // MARK: - Constants
    
    private struct Constants {
        static let cellReuseIdentifier = "venueCell"
    }
    
    // MARK: - Properties
    
    @IBOutlet private var venuesTableView: UITableView!
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!
    
    private lazy var venueManager: VenueManager = VenueManagerImpl()
    
    private var venues: [Venue] = [] {
        didSet {
            venuesTableView.reloadData()
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        getVenuesData()
    }
    
    // MARK: - Private
    
    private func setupTableView() {
        venuesTableView.delegate = self
        venuesTableView.dataSource = self
    }
    
    private func getVenuesData() {
//        venueManager.getTrendingVenues(for: <#T##CLLocation#>, completion: <#T##([Venue]?, Error?) -> Void#>)
    }
    
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension VenueViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return venues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellReuseIdentifier) as? VenueCell else {
            return UITableViewCell()
        }
        cell.update(with: venues[indexPath.row].name)
        return cell
    }
}
