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

enum LocationError: Error {
    case locationServiceNotEnabled
    case userDeclinedLocationService
}

class LocationServiceImpl: LocationService {
    
    private let locationManager = CLLocationManager()
    
    private var locationEnabled: Bool? {
        if CLLocationManager.locationServicesEnabled() {
        switch CLLocationManager.authorizationStatus() {
            case .notDetermined, .restricted, .denied:
                return false
            case .authorizedAlways, .authorizedWhenInUse:
                return true
            @unknown default:
            return false
        }
        } else {
            return nil
        }
    }
    
    func getCurrentLocation(completion: @escaping (LocationDTO?, Error?) -> Void) {
        guard let locationServiceEnabled = locationEnabled else {
            locationManager.requestWhenInUseAuthorization()
            completion(nil, LocationError.locationServiceNotEnabled)
            return
        }
        
        guard locationServiceEnabled else {
            completion(nil, LocationError.userDeclinedLocationService)
            return
        }
        
         
        
        
        
    }
    

}

//extension LocationServiceImpl: CLLocationManagerDelegate {
//
//}
