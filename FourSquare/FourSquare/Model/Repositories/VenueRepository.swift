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
    
    // MARK: - Properties
    
    private let networkinService: NetworkingService = NetworkingServiceImpl()
    private let requestBuilder: RequestBuilder = RequestBuilderImpl()
    
    // MARK: - Venue Repository
    
    func getTrendingVenues(by location: LocationDTO, completion: @escaping ([Venue]?, Error?) -> Void) {
        do {
            let requestURL = try requestBuilder.getUrl(for: .trendingVenues(location))
            networkinService.getData(for: requestURL) { data, error in
                if let data = data {
                    let decoder = JSONDecoder()
                    do {
                        let venueRootResponse: VenueRoot = try decoder.decode(VenueRoot.self, from: data)
//                        completion(self.dummyVenues, nil)
                        completion(venueRootResponse.response.venues, nil)
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
    
    // dummy data
    
    let dummyVenues = [
    Venue(id: "3232", name: "Aaaaa"),
    Venue(id: "4242", name: "Bbbbb"),
    Venue(id: "5353", name: "Ccccc"),
    Venue(id: "6161", name: "Ddddd"),
    Venue(id: "7777", name: "Eeeee")]
}
