//
//  ImageFetcher.swift
//  Reciplease
//
//  Created by Paul Leclerc on 23/09/2019.
//  Copyright © 2019 Paul Leclerc. All rights reserved.
//

import Foundation
import Alamofire

class ImageFetcher {
    var url: String
    
    init(url: String) {
        self.url = url
    }
    
//    Main func
    func fetchImage(completion: @escaping (Result<Data, Errors>) -> Void) {
        guard let url = URL(string: self.url) else {
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
