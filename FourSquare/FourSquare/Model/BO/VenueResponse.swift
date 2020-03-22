//
//  VenueResponse.swift
//  FourSquare
//
//  Created by JBS Solutions on 23.03.2020.
//  Copyright © 2020 JBSolutions. All rights reserved.
//

import Foundation

struct VenueResponse: Codable {
    let response: String
    let venues: [Venue]
    
    
}
