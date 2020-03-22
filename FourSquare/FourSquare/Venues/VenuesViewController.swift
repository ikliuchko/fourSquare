//
//  VenuesViewController.swift
//  FourSquare
//
//  Created by JBS Solutions on 16.03.2020.
//  Copyright © 2020 JBSolutions. All rights reserved.
//

import UIKit

final class VenuesViewController: UIViewController {
    
    // MARK: - Constants
    
    static let storyboardName = "Venues"
    
    private struct Constants {
        static let cellReuseIdentifier = "venueCell"
    }
    
    // MARK: - Properties
    
    @IBOutlet private var venuesTableView: UITableView!
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!
    
    private lazy var venueManager: VenueManager = VenueManagerImpl()
    private lazy var locationService: LocationService = LocationServiceImpl()
    
    private var venues: [Venue] = [] {
        didSet {
            venuesTableView.reloadData()
            if venues.count == 0 {
                displayEmptyVenuesAlert()
            }
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
        defer {
            activityIndicator.stopAnimating()
        }
        activityIndicator.startAnimating()
        locationService.getCurrentLocation { [weak self] location, error in
            if let error = error {
                self?.handle(error: error)
            }
            
            if let location = location {
                self?.venueManager.getTrendingVenues(for: location) { venues, error in
                    if let error = error {
                        DispatchQueue.main.async {
                        self?.handle(error: error)
                        }
                    }
                    
                    if let venues = venues {
                        DispatchQueue.main.async {
                            self?.venues = venues
                        }
                    }
                    
                }
            }
            
        }
    }
    
    private func displayEmptyVenuesAlert() {
        let alertVC = UIAlertController(title: "Oopsie",
                                    message: "You have disabled location services... so sad. Please turn them on in settings an restart the app",
                                    preferredStyle: .alert
        )
        let action = UIAlertAction(title: "Close", style: .cancel) { _ in
            self.dismiss(animated: true)
        }
        alertVC.addAction(action)
        present(alertVC, animated: true)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension VenuesViewController: UITableViewDelegate, UITableViewDataSource {
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

// MARK: - Error handling

extension VenuesViewController {
    private func handle(error: Error) {
        var alertVC = UIAlertController(title: "Oopsie",
                                        message: "Smth went wrong",
                                        preferredStyle: .alert)
        defer {
            self.present(alertVC, animated: true, completion: nil)
        }
        
        switch error {
        case LocationError.userDeclinedLocationService:
            alertVC = UIAlertController(title: "Oopsie",
                                        message: "You have disabled location services... so sad. Please turn them on in settings an restart the app",
                                        preferredStyle: .alert
            )
        case LocationError.locationServiceNotEnabled:
            alertVC = UIAlertController(title: "Oopsie",
                                        message: "You have not enabled location services... so sad. Please turn them on in settings an restart the app",
                                        preferredStyle: .alert
            )
        case LocationError.couldNotGetLocation:
            alertVC = UIAlertController(title: "Oopsie",
                                        message: "We could npt get your current location for some reason. Please try again",
                                        preferredStyle: .alert
            )
            let retryAction = UIAlertAction(title: "Retry", style: .cancel) { [unowned self] _ in
                self.getVenuesData()
            }
            alertVC.addAction(retryAction)
        default:
            return
        }
    }
}
