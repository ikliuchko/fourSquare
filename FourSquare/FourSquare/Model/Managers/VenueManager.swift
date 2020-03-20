//
//  VenueManager.swift
//  FourSquare
//
//  Created by JBS Solutions on 20.03.2020.
//  Copyright © 2020 JBSolutions. All rights reserved.
//

import Foundation

protocol VenueManager {
    func getTrendingVenues(for location: LocationDTO, completion: @escaping([Venue]?, Error?) -> Void)
}

final class VenueManagerImpl: VenueManager {
    private let venueRepository: VenueRepository = VenueRepositoryImpl()
    private let venueStorage: VenueStorage = VenueStorageImpl()
    
    func getTrendingVenues(for location: LocationDTO, completion: @escaping([Venue]?, Error?) -> Void) {
        venueRepository.getTrendingVenues(by: location) { venues, error in
            if let venues = venues {
                completion(venues, nil)
            } else {
               completion(nil, error)
            }
            
        }
    }
}
