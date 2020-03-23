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

final class LocationServiceImpl: NSObject, LocationService, CLLocationManagerDelegate {
    
    private let locationManager = CLLocationManager()
    private var completionBlock: ((LocationDTO?, Error?) -> Void)?
    
    private var locationEnabled: Bool? {
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .restricted, .denied:
                return false
            case .authorizedAlways, .authorizedWhenInUse:
                return true
            case .notDetermined:
                return nil
//            @unknown default:
//                return nil
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
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestLocation()
        
        self.completionBlock = completion
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate,
        let completion = completionBlock else {
            print("smth went wrong with locValue or completion in \(Self.self)")
            return
        }
        completion(LocationDTO(latitude: String(locValue.latitude),
                               longitude: String(locValue.longitude)),
                   nil)
        completionBlock = nil
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        guard let completion = completionBlock else {
            print("smth went wrong with completion in \(Self.self)")
            return
        }
        completion(nil, LocationError.couldNotGetLocation)
        completionBlock = nil
    }
}
