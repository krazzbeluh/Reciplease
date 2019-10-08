//
//  RecipeTestCase.swift
//  RecipleaseTests
//
//  Created by Paul Leclerc on 08/10/2019.
//  Copyright © 2019 Paul Leclerc. All rights reserved.
//

import XCTest
@testable import Reciplease

class RecipeTestCase: XCTestCase {
    var recipe1: Recipe!
    var recipe2: Recipe!
    
    override func setUp() {
        recipe1 = Recipe(name: "recipe1",
                         image: "https://image",
                         recipe: "https://marmitton",
                         ingredients: [Ingredient(name: "Tomato")],
                         uri: "https://edamam1")
        recipe2 = Recipe(name: "recipe2",
                         image: "https://image",
                         recipe: "https://cookingRecipe",
                         ingredients: [Ingredient(name: "tomato")],
                         uri: "https://edamam2")
    }

    func testRecipeEquality() { 
        XCTAssertNotEqual(recipe1, recipe2)
    }

}
