//
//  ImageFetcher.swift
//  Reciplease
//
//  Created by Paul Leclerc on 23/09/2019.
//  Copyright © 2019 Paul Leclerc. All rights reserved.
//

import Foundation
//import Alamofire

class ImageFetcher {
    required init(session: NetworkSession) {
        networkSession = session
        url = "https://google.fr"
    }
    
    private var networkSession = NetworkSession()
    var url: String
    
    init(url: String) {
        self.url = url
    }
    
//    Main func
    func fetchImage(completion: @escaping (Result<Data, Errors>) -> Void) {
        networkSession.request(url: url) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
