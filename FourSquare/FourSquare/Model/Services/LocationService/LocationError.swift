//
//  LocationError.swift
//  FourSquare
//
//  Created by JBS Solutions on 22.03.2020.
//  Copyright © 2020 JBSolutions. All rights reserved.
//

import Foundation

enum LocationError: Error {
    case locationServiceNotEnabled
    case userDeclinedLocationService
    case couldNotGetLocation
}
