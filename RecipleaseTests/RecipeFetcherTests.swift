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
    var recipesFetcher: RecipesFetcher!
    
    override func setUp() {
        recipesFetcher = RecipesFetcher()
    }
    
    func testRequestShouldReturnFailedCallbackIfError() {
        recipesFetcher.networkService = FakeNetworkSession(data: <#T##Data?#>, response: <#T##URLResponse?#>, error: <#T##Error?#>)
        
        let expectation = XCTestExpectation(description: "wait for queue change.")
        
        recipesFetcher.fetchRecipes { result in
            switch result {
            case .success(_): //swiftlint:disable:this empty_enum_arguments
                XCTAssert(false)
            case .failure(let error):
                if case NetworkService.NetworkError.error = error {
                    XCTAssert(true)
                } else {
                    XCTAssert(false)
                }
            }
            expectation.fulfill()
        }
    }

}
