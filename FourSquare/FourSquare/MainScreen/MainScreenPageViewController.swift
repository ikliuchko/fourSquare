//
//  MainScreenPageViewController.swift
//  FourSquare
//
//  Created by JBS Solutions on 22.03.2020.
//  Copyright © 2020 JBSolutions. All rights reserved.
//

import UIKit

protocol MainScreenPageViewControllerDelegate: class {
    func pageViewControllerDidSwitched(to index: Int)
}

class MainScreenPageViewController: UIPageViewController {
    
    // MARK: - Constants
    
    // MARK: - Properties
    
    weak var pageScrollDelegate: MainScreenPageViewControllerDelegate?
    
    private lazy var venuesVC: VenuesViewController = {
        return UIStoryboard(name: VenuesViewController.storyboardName, bundle: nil).instantiateInitialViewController() as! VenuesViewController
    }()
    
    private lazy var contactUsVC: ContactUsViewController = {
        return UIStoryboard(name: ContactUsViewController.storyboardName, bundle: nil).instantiateInitialViewController() as! ContactUsViewController
    }()
    
    private lazy var orderedViewControllers: [UIViewController] = {
        return [venuesVC,
                contactUsVC]
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPageVC()
    }
    
    // MARK: - Public
    
    func switchPage(to index: Int) {
        openPage(at: index)
    }
    
    // MARK: - Private
    
    private func setupPageVC() {
        dataSource = self
        delegate = self
        
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
    }
    
    private func openPage(at index: Int) {
        guard orderedViewControllers.indices.contains(index) else {
            print("index out of bounds")
            return
        }
        
        let direction = getNavigationDirection(for: index)
        
        setViewControllers([orderedViewControllers[index]],
                           direction: direction,
                           animated: true,
                           completion: nil)
    }
    
    private func getNavigationDirection(for index: Int) -> UIPageViewController.NavigationDirection {
        guard let currentVC = self.viewControllers?.first,
            let currentIndex = orderedViewControllers.firstIndex(of: currentVC) else { return .forward }
        
        return index < currentIndex ? .reverse : .forward
    }
}

extension MainScreenPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        switch viewController {
        case is ContactUsViewController:
            return venuesVC
        default:
            return nil
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        switch viewController {
        case is VenuesViewController:
            return contactUsVC
        default:
            return nil
        }
    }
}

extension MainScreenPageViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        guard completed else { return }
        guard let vcToOpen = pageViewController.viewControllers?.first else {
            print("smth went wrong here: vc")
            return
        }
        
        guard let indexOfOpenedVC = orderedViewControllers.firstIndex(of: vcToOpen) else {
            print("smth went wrong here: index")
            return
        }
        
        pageScrollDelegate?.pageViewControllerDidSwitched(to: indexOfOpenedVC)
    }
    
}
