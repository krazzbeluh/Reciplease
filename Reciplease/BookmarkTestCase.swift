//
//  BookmarkTestCase.swift
//  RecipleaseTests
//
//  Created by Paul Leclerc on 08/10/2019.
//  Copyright © 2019 Paul Leclerc. All rights reserved.
//

import XCTest
@testable import Reciplease

// MARK: Bookmark
class BookmarkTestCase: XCTestCase {

    override func setUp() {
        if Bookmark.all.count > 0 {
            for _ in 1 ... Bookmark.all.count {
                Bookmark.deleteBookmark(Bookmark.all[0])
            }
        }
    }
    
    func saveBookmark() -> Recipe {
        let recipe = Recipe(name: "recipe1",
                            image: "https://image",
                            recipe: "https://marmitton",
                            ingredients: [Ingredient(name: "Tomato")],
                            uri: "https://edamam1")
        
        Bookmark.saveBookmark(recipe)
        return recipe
    }
    
    func testAllBookmarkReturnsVoidArrayWhenNoBookmarks() {
        XCTAssertEqual(Bookmark.all, [])
    }
    
    func testSaveBookmarkAndFetch() {
        let recipe = saveBookmark()
        XCTAssertEqual(Bookmark.all.count, 1)
        XCTAssertEqual(Bookmark.all[0].uri, recipe.uri)
    }
    
    func testFetchAllRecipes() {
        let recipe = saveBookmark()
        XCTAssertEqual(Bookmark.allRecipes, [recipe])
    }
    
    func testBookmarkUnnamedReturnsNil() {
        let bookmark = Bookmark(context: AppDelegate.viewContext)
        bookmark.imageUrl = "imageUrl"
        bookmark.recipeUrl = "recipeUrl"
        bookmark.uri = "uri"
        bookmark.ingredients = [Ingredient(name: "ingredient").asBIngredient()]
        
        XCTAssertEqual(Bookmark.all.first, bookmark)
        XCTAssertEqual(Bookmark.allRecipes, [])
    }

    func testBookmarkWithoutImageReturnsNil() {
        let bookmark = Bookmark(context: AppDelegate.viewContext)
        bookmark.name = "name"
        bookmark.recipeUrl = "recipeUrl"
        bookmark.uri = "uri"
        bookmark.ingredients = [Ingredient(name: "ingredient").asBIngredient()]
        
        XCTAssertEqual(Bookmark.all.first, bookmark)
        XCTAssertEqual(Bookmark.allRecipes, [])
    }
    
    func testBookmarkWithoutRecipeUrlReturnsNil() {
        let bookmark = Bookmark(context: AppDelegate.viewContext)
        bookmark.name = "name"
        bookmark.imageUrl = "himageUrl"
        bookmark.uri = "uri"
        bookmark.ingredients = [Ingredient(name: "ingredient").asBIngredient()]
        
        XCTAssertEqual(Bookmark.all.first, bookmark)
        XCTAssertEqual(Bookmark.allRecipes, [])
    }
    
    func testBookmarkWithoutUriReturnsNil() {
        let bookmark = Bookmark(context: AppDelegate.viewContext)
        bookmark.name = "name"
        bookmark.imageUrl = "imageUrl"
        bookmark.recipeUrl = "recipeUrl"
        bookmark.ingredients = [Ingredient(name: "ingredient").asBIngredient()]
        
        XCTAssertEqual(Bookmark.all.first, bookmark)
        XCTAssertEqual(Bookmark.allRecipes, [])
    }
    
    func testBookmarkWithoutIngredientsReturnsNil() {
        let bookmark = Bookmark(context: AppDelegate.viewContext)
        bookmark.name = "name"
        bookmark.imageUrl = "imageUrl"
        bookmark.recipeUrl = "recipeUrl"
        bookmark.uri =  "uri"
        bookmark.ingredients = nil
        
        XCTAssertEqual(Bookmark.all.first, bookmark)
        XCTAssertEqual(Bookmark.allRecipes, [Recipe]())
    }
}

// MARK: Ingredient

extension BookmarkTestCase {
    
    func testAsIngredientMethodShouldReturnNilIfNoName() {
        let bIngredient = BIngredient(context: AppDelegate.viewContext)
        
        XCTAssertNil(bIngredient.asIngredient())
    }
    
    func testAsIngredientMethodShouldReturnIngredientIfName() {
        let bIngredient = BIngredient(context: AppDelegate.viewContext)
        let name = "bIngredient"
        
        bIngredient.name = name
        
        let ingredient = bIngredient.asIngredient()
        XCTAssertNotNil(ingredient)
        XCTAssertEqual(ingredient?.name, name)
    }
    
}
