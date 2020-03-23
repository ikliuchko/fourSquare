//
//  Venue.swift
//  FourSquare
//
//  Created by JBS Solutions on 20.03.2020.
//  Copyright © 2020 JBSolutions. All rights reserved.
//

import Foundation

struct Venue: Codable {
    let id: String
    let name: String
}

// technical models for parsing
struct VenueRoot: Codable {
    let response: VenueResponse
}

struct VenueResponse: Codable {
    let venues: [Venue]
}
