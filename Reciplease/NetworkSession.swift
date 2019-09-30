//
//  NetworkSession.swift
//  Reciplease
//
//  Created by Paul Leclerc on 24/09/2019.
//  Copyright © 2019 Paul Leclerc. All rights reserved.
//

import Foundation
import Alamofire

class NetworkSession {
    func request(url urlString: String, completion: @escaping (Result<Data, Errors>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.incorectUrl))
            return
        }
        
//        AF.request(url).response { response in
//
//            guard let data = response.data else {
//                completion(.failure(.noData))
//                return
//            }
//
//            completion(.success(data))
//        }
        
        AF.request(url)
        .validate(statusCode: 200..<300)
        .validate(contentType: ["application/json"])
        .responseData { response in
            switch response.result {
            case .success:
                guard let data = response.data else {
                    completion(.failure(.noData))
                    return
                }
                
                completion(.success(data))
            case let .failure(error):
                print(error)
            }
        }
    }
}
