//
//  RecipeFetcherTests.swift
//  RecipleaseTests
//
//  Created by Paul Leclerc on 24/09/2019.
//  Copyright © 2019 Paul Leclerc. All rights reserved.
//

import XCTest
@testable import Reciplease

class RecipeFetcherTests: XCTestCase {
    override func setUp() {
    }
    
    func testRequestShouldReturnFailedCallbackIfError() {
        let fetcher = RecipesFetcher(session:
            FakeNetworkSession(data: FakeResponseData.correctData(ressourceName: "Recipes"),
                               response: FakeResponseData.responseOK,
                               error: FakeResponseData.error))
        
        fetcher.fetchRecipes { result in
            switch result {
            case .success(_):
                XCTAssert(false)
            case .failure(let error):
                if case let error = .
            }
        }
        
    }

}
