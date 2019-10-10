//
//  FetcherTestCase.swift
//  RecipleaseTests
//
//  Created by Paul Leclerc on 10/10/2019.
//  Copyright © 2019 Paul Leclerc. All rights reserved.
//

import XCTest
import Alamofire
@testable import Reciplease

class FetcherTestCase: XCTestCase {

    var recipesFetcher: RecipesFetcher!
    
    lazy var data: Data = {
        let bundle = Bundle(for: DecoderTestCase.self)
        let url = bundle.url(forResource: "Recipes", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }()
    
    override func setUp() {
        recipesFetcher = RecipesFetcher()
    }

    func testUrl() {
        Ingredient.listForSearch = ["Ingredient", "Ingredient2"]
        let expectedUrl = "https://api.edamam.com/search?app_id=API%20signup&app_key=fed2ff4a&q=Ingredient,%20Ingredient2&from=0&to=20" //swiftlint:disable:this line_length
        XCTAssertEqual(recipesFetcher.url, expectedUrl)
    }
    
    func testTreatmentShouldReturnSuccessCallbackIfNoError() {
        let response = AFDataResponse<Any>(request: nil,
                                           response: nil,
                                           data: data,
                                           metrics: nil,
                                           serializationDuration: 0,
                                           result: Result.success((Any).self))
        recipesFetcher.treatment(response: response) { result in
            guard case .success(let recipes) = result else {
                XCTAssert(false)
                return
            }
            
            XCTAssertEqual(recipes.count, 20)
        }
    }
    
    func testTreatmentShouldReturnFailureCallbackIfNoData() {
        let response = AFDataResponse<Any>(request: nil,
                                           response: nil,
                                           data: nil,
                                           metrics: nil,
                                           serializationDuration: 0,
                                           result: Result.success((Any).self))
        
        recipesFetcher.treatment(response: response) { result in
            guard case .failure(let error) = result else {
                XCTAssert(false)
                return
            }
            
            guard case RecipesFetcher.FetcherError.noData = error else {
                XCTAssert(false)
                return
            }
            
            XCTAssert(true)
        }
    }
    
    func testTreatmentShouldReturnFailedCallbackIfError() {
        let response = AFDataResponse<Any>(request: nil,
                                           response: nil,
                                           data: "test".data(using: .utf8),
                                           metrics: nil,
                                           serializationDuration: 0,
                                           result: Result.success((Any).self))
        
        recipesFetcher.treatment(response: response) { result in
            guard case .failure(let error) = result else {
                XCTAssert(false)
                return
            }
            
            guard case EdamamDecode.DecoderError.unableToDecodeData = error else {
                XCTAssert(false)
                return
            }
            
            XCTAssert(true)
        }
    }
    
    func testTreatmentShouldReturnFailedCallbackIfAFError() {
        let response = AFDataResponse<Any>(request: nil,
                                           response: nil,
                                           data: nil,
                                           metrics: nil,
                                           serializationDuration: 0,
                                           result: Result.failure(AFError.sessionDeinitialized)) //random error
        
        recipesFetcher.treatment(response: response) { result in
            guard case .failure(let error) = result else {
                XCTAssert(false)
                return
            }
            
            guard case AFError.sessionDeinitialized = error else {
                XCTAssert(false)
                return
            }
            
            XCTAssert(true)
        }
    }
}
