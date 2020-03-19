//
//  VenueStorage.swift
//  FourSquare
//
//  Created by JBS Solutions on 20.03.2020.
//  Copyright © 2020 JBSolutions. All rights reserved.
//

import Foundation

protocol VenueStorage {
    func getVenues(completion: @escaping ([Venue]?, Error?) -> Void)
    func store(venues: [Venue])
}

struct VenueStorageImpl: VenueStorage {
    func getVenues(completion: @escaping ([Venue]?, Error?) -> Void) {
        completion([], nil)
    }
    
    func store(venues: [Venue]) {
        print("succesfully stored")
    }
    
    
}
