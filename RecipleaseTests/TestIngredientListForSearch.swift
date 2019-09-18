//
//  IngredientListForSearch.swift
//  RecipleaseTests
//
//  Created by Paul Leclerc on 18/09/2019.
//  Copyright © 2019 Paul Leclerc. All rights reserved.
//

//swiftlint:disable trailing_whitespace

@testable import Reciplease
import XCTest

class TestIngredientListForSearch: XCTestCase {

    func testAddingIngredientToListAddsIngredient() {
        let ingredient = "Tomato"
        
        IngredientListForSearch.addIngredient(ingredient)
        
        XCTAssertEqual(IngredientListForSearch.ingredients, [ingredient])
    }

}
