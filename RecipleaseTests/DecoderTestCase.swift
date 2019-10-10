//
//  DecoderTestCase.swift
//  RecipleaseTests
//
//  Created by Paul Leclerc on 10/10/2019.
//  Copyright © 2019 Paul Leclerc. All rights reserved.
//

import XCTest
@testable import Reciplease

class DecoderTestCase: XCTestCase {
    
    override func setUp() {
    }

    func testConvertToRecipesShouldReturnRecipesIfCorrectData() {
        let bundle = Bundle(for: DecoderTestCase.self)
        let url = bundle.url(forResource: "Recipes", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        
        let result = EdamamDecode.convertToRecipes(data: data)
        
        if case .success(let recipes) = result {
            XCTAssertEqual(recipes.count, 20)
        } else {
            XCTAssert(false)
        }
    }
    
    func testConvertToRecipesShouldReturnErrorIfIncorrectData() {
        let data = "Recipes".data(using: .utf8)!
        
        let result = EdamamDecode.convertToRecipes(data: data)
        
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
