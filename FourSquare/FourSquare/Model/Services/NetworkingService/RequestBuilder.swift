//
//  RequestBuilder.swift
//  FourSquare
//
//  Created by JBS Solutions on 20.03.2020.
//  Copyright © 2020 JBSolutions. All rights reserved.
//

import Foundation

enum RequestType {
    case trendingVenues(LocationDTO)
}

protocol RequestBuilder {
    func getUrl(for type: RequestType) throws -> URL
}

struct RequestBuilderImpl: RequestBuilder {
    
    /// trending
    /// base
    /// https://api.foursquare.com/v2/
    /// path
    ///    venues/trending
    /// location
    ///    ?ll=40.7,-74
    /// one may ask, why the f**k we go with that type of authentication and the answer is
    /// foursquare provides their lib to process their ouath v2.0
    /// while this very project should not use any non native lib/pod
    /// client id
    ///    &client_id=
    /// client secret
    ///    &client_secret=
    /// api changes we're ready for
    ///    &v=20200122
    
    private let baseString = GlobalConstants.basePath
    private let authenticationString = "?client_id=\(GlobalConstants.userId)&client_secret=\(GlobalConstants.userSecret)"
    private let supportedVersionString = "&v=\(GlobalConstants.supportedApiVersion)"
    
    func getUrl(for type: RequestType) throws -> URL {
        let urlString: String
        switch type {
        case .trendingVenues(let location):
            urlString = baseString + authenticationString + "&ll=" + location.latitude + "," + location.longitude
        }
        guard let url = URL(string: urlString) else {
            throw NetworkingError.incorrectURL
        }
        return url
    }
}
