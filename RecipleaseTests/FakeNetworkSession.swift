//
//  FakeNetworkSession.swift
//  RecipleaseTests
//
//  Created by Paul Leclerc on 24/09/2019.
//  Copyright © 2019 Paul Leclerc. All rights reserved.
//

import Foundation
@testable import Reciplease

class FakeNetworkSession: NetworkSession {
    var data: Data?
    var response: URLResponse?
    var error: Error?
    
    init(data: Data?, response: URLResponse?, error: Error?) {
        self.data = data
        self.response = response
        self.error = error
    }
    
    override func request(url urlString: String, completion: @escaping (Result<Data, Errors>) -> Void) {
        guard URL(string: urlString) != nil else {
            completion(.failure(.incorectUrl))
            return
        }
        
        guard self.data != nil else {
            completion(.failure(.noData))
            return
        }
        
        guard response == FakeResponseData.responseOK else {
            completion(.failure(.responseNot200))
            return
        }
        
        completion(.success(FakeResponseData.correctData(ressourceName: "Recipes")))
    }
}
