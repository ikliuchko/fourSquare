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
    
    // MARK: - Pre-defined
    
    // base
    private let baseString = GlobalConstants.basePath
    
    // path
    private enum Path: String {
        case trendingVenues = "/v2/venues/trending"
    }
    
    // auth
    private let authenticationItems = [
        URLQueryItem(name: "client_id", value: GlobalConstants.userId),
        URLQueryItem(name: "client_secret", value: GlobalConstants.userSecret)
    ]
    
    // version
    private let versionItem = URLQueryItem(name: "v", value: GlobalConstants.supportedApiVersion)
    
    // limit
    private let limitItem = URLQueryItem(name: "limit", value: String(GlobalConstants.limitOfItemsToLoad))
        
    // MARK: - Request builder
    
    func getUrl(for type: RequestType) throws -> URL {
        var urlComponents = getPredefinedComponents()
        switch type {
        case .trendingVenues(let location):
            urlComponents.path = Path.trendingVenues.rawValue
            let llItem = URLQueryItem(name: "ll", value: location.latitude + "," + location.longitude)
            urlComponents.queryItems?.append(llItem)
            urlComponents.queryItems?.append(limitItem)
        }
        urlComponents.percentEncodedQuery = urlComponents.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        guard let url = urlComponents.url else {
            throw NetworkingError.incorrectURL
        }
        return url
    }
    
    // MARK: - Private
    
    private func getPredefinedComponents() -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = GlobalConstants.basePath
        urlComponents.queryItems = authenticationItems
        urlComponents.queryItems?.append(versionItem)
        
        return urlComponents
    }
}


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
