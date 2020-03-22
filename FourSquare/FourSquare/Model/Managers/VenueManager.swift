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
        venueRepository.getTrendingVenues(by: location) { [unowned self] venues, error in
            if let venues = venues {
                self.venueStorage.store(venues: venues)
                completion(venues, nil)
            } else {
                self.venueStorage.getVenues { stVenues, stError in
                    if let venues = stVenues {
                        completion(venues, nil)
                    } else {
                        completion(nil, error)
                    }
                }
            }
            
        }
    }
}
