//
//  RequestBuilder.swift
//  FourSquare
//
//  Created by JBS Solutions on 20.03.2020.
//  Copyright © 2020 JBSolutions. All rights reserved.
//

import CoreLocation

enum RequestType {
    case trendingVenues(CLLocation)
}

protocol RequestBuilder {
    func getUrl(for type: RequestType) throws -> URL
}

struct RequestBuilderImpl: RequestBuilder {
    
    private let authenticationString = "user=\(GlobalConstants.userName)&secret=\(GlobalConstants.secret)"
    private let baseString = GlobalConstants.basePath
    
    func getUrl(for type: RequestType) throws -> URL {
        let urlString: String
        switch type {
        case .trendingVenues(let location):
            urlString = baseString + authenticationString + String(location.altitude)
        }
        guard let url = URL(string: urlString) else {
            throw NetworkingError.incorrectURL
        }
        return url
    }
}
