//
//  FakeNetworkSession.swift
//  RecipleaseTests
//
//  Created by Paul Leclerc on 24/09/2019.
//  Copyright © 2019 Paul Leclerc. All rights reserved.
//

import Foundation
@testable import Reciplease

class FakeNetworkSession: NetworkService {
    var data: Data?
    var response: URLResponse?
    var error: Error?
    
    init(data: Data?, response: URLResponse?, error: Error?) {
        self.data = data
        self.response = response
        self.error = error
    }
    
    override func getData(callback: @escaping (Result<Data, NetworkService.NetworkError>) -> Void) {
        guard error == nil else {
            callback(.failure(NetworkService.NetworkError.error))
        }
        
        guard self.data != nil else {
            callback(.failure(NetworkService.NetworkError.noData))
            return
        }
        
        guard response == FakeResponseData.responseOK else {
            callback(.failure(NetworkService.NetworkError.responseNot200))
            return
        }
        
        callback(.success(FakeResponseData.correctData(ressourceName: "Recipes")))
    }
}
