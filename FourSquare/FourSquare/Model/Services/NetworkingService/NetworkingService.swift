//
//  NetworkingService.swift
//  FourSquare
//
//  Created by JBS Solutions on 20.03.2020.
//  Copyright © 2020 JBSolutions. All rights reserved.
//

import Foundation

protocol NetworkingService {
    func getData(for url: URL, completion: @escaping (Data?, Error?) -> Void)
}

final class NetworkingServiceImpl: NetworkingService {
    
    func getData(for url: URL, completion: @escaping (Data?, Error?) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            completion(data, error)
        }
    }
}
