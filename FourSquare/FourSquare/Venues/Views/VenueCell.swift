//
//  VenueCell.swift
//  FourSquare
//
//  Created by JBS Solutions on 20.03.2020.
//  Copyright © 2020 JBSolutions. All rights reserved.
//

import UIKit

final class VenueCell: UITableViewCell {
    
    // MARK: - Properties
    
    @IBOutlet private var titleLabel: UILabel!
    
    // MARK: - Lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = nil
    }
    
    func update(with title: String) {
        titleLabel.text = title
    }
}
