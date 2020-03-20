//
//  LocationService.swift
//  FourSquare
//
//  Created by JBS Solutions on 20.03.2020.
//  Copyright © 2020 JBSolutions. All rights reserved.
//

import CoreLocation

protocol LocationService {
    func getCurrentLocation(completion: @escaping (LocationDTO?, Error?) -> Void)
}

struct LocationServiceImpl: LocationService {
    func getCurrentLocation(completion: @escaping (LocationDTO?, Error?) -> Void) {
        //
    }
    

}
