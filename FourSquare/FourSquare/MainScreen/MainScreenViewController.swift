//
//  MainScreenViewController.swift
//  FourSquare
//
//  Created by JBS Solutions on 16.03.2020.
//  Copyright © 2020 JBSolutions. All rights reserved.
//

import UIKit

final class MainScreenViewController: UIViewController {
    
    // MARK: - Constants
    
    private struct Constants {
    }
    
    // MARK: - Properties
    
    @IBOutlet private weak var segmentedControl: UISegmentedControl!
    
    private var pageViewController: MainScreenPageViewController?
    
    // MARK: - Overrides
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let pageViewController = segue.destination as? MainScreenPageViewController {
            self.pageViewController = pageViewController
            pageViewController.pageScrollDelegate = self
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        checkIdsSetup()
    }
    
    // MARK: - Public
    
    // MARK: - Private
    
    private func checkIdsSetup() {
        guard GlobalConstants.userId.isEmpty ||
            GlobalConstants.userSecret.isEmpty else { return }
        
        let alertVC = UIAlertController(title: "Oopsie", message: "Please set userId and userSecret in Global Constants", preferredStyle: .alert)
        self.present(alertVC, animated: true, completion: nil)
    }
    
    
    // MARK: - Actions
    
    @IBAction private func segmentedControlPressed(_ sender: UISegmentedControl) {
        pageViewController?.switchPage(to: sender.selectedSegmentIndex)
    }
    
}

extension MainScreenViewController: MainScreenPageViewControllerDelegate {
    func pageViewControllerDidSwitched(to index: Int) {
        segmentedControl.selectedSegmentIndex = index
    }
}
