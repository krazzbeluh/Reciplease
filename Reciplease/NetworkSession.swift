//
//  NetworkSession.swift
//  Reciplease
//
//  Created by Paul Leclerc on 24/09/2019.
//  Copyright © 2019 Paul Leclerc. All rights reserved.
//

import Foundation
import Alamofire

protocol NetworkSession {
    
}

extension NetworkSession {
    func request(url urlString: String, completion: @escaping (Result<Data, Errors>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.incorectUrl))
          return
        }
        
        AF.request(url).response { response in
            guard let data = response.data else {
                completion(.failure(.noData))
                return
            }
            
            completion(.success(data))
        }
    }
}
