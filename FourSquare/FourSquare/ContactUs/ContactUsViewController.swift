//
//  ContactUsViewController.swift
//  FourSquare
//
//  Created by JBS Solutions on 16.03.2020.
//  Copyright © 2020 JBSolutions. All rights reserved.
//

import UIKit

final class ContactUsViewController: UIViewController {
    
    // MARK: - Constants
    
    static let storyboardName = "ContactUs"

    private struct Constants {
        static let contactUsText: String = "Foursquare for Enterprise \n Your partner in finding creative ways to power location-based experiences, \n transforming your business from the ground up."
    }

    // MARK: - Properties
    
    @IBOutlet private weak var contactUsLabel: UILabel!

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }

    // MARK: - Private

    private func setupView() {
        contactUsLabel.text = Constants.contactUsText
    }
}
