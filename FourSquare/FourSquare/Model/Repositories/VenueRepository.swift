//
//  VenueRepository.swift
//  FourSquare
//
//  Created by JBS Solutions on 20.03.2020.
//  Copyright © 2020 JBSolutions. All rights reserved.
//

import Foundation

protocol VenueRepository {
    func getTrendingVenues(by location: LocationDTO, completion: @escaping ([Venue]?, Error?) -> Void)
}

final class VenueRepositoryImpl: VenueRepository {
    
    private let networkinService: NetworkingService = NetworkingServiceImpl()
    private let requestBuilder: RequestBuilder = RequestBuilderImpl()
    
    func getTrendingVenues(by location: LocationDTO, completion: @escaping ([Venue]?, Error?) -> Void) {
        do {
            let requestURL = try requestBuilder.getUrl(for: .trendingVenues(location))
            networkinService.getData(for: requestURL) { data, error in
                if let data = data {
                    let decoder = JSONDecoder()
                    do {
                        let venues = try decoder.decode([Venue].self, from: data)
                        completion(venues, nil)
                    } catch {
                        completion(nil, error)
                    }
                } else {
                    completion(nil, error)
                }
            }
        }
        catch {
            completion(nil, error)
        }
    }
}
