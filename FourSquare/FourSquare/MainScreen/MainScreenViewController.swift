//
//  MainScreenViewController.swift
//  FourSquare
//
//  Created by JBS Solutions on 16.03.2020.
//  Copyright © 2020 JBSolutions. All rights reserved.
//

import UIKit

class MainScreenViewController: UIViewController {
    
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

    // MARK: - Public

    // MARK: - Private
    
    
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
