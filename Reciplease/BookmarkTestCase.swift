//
//  BookmarkTestCase.swift
//  RecipleaseTests
//
//  Created by Paul Leclerc on 08/10/2019.
//  Copyright © 2019 Paul Leclerc. All rights reserved.
//

import XCTest
@testable import Reciplease

class BookmarkTestCase: XCTestCase {
    lazy var unnamedBookmark: Bookmark = {
        let bookmark = Bookmark(context: AppDelegate.viewContext)
        bookmark.imageUrl = "https"
        bookmark.recipeUrl = "https"
        bookmark.uri = "https"
        return bookmark
    }()
    
    lazy var bookmarkWithoutImage: Bookmark = {
        let bookmark = Bookmark(context: AppDelegate.viewContext)
        bookmark.name = "https"
        bookmark.recipeUrl = "https"
        bookmark.uri = "https"
        return bookmark
    }()
    
    lazy var bookmarkWithoutRecipe: Bookmark = {
        let bookmark = Bookmark(context: AppDelegate.viewContext)
        bookmark.name = "https"
        bookmark.imageUrl = "https"
        bookmark.uri = "https"
        return bookmark
    }()
    
    lazy var bookmarkWithoutUri: Bookmark = {
        let bookmark = Bookmark(context: AppDelegate.viewContext)
        bookmark.name = "https"
        bookmark.imageUrl = "https"
        bookmark.recipeUrl = "https"
        return bookmark
    }()

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
        let bookmark = unnamedBookmark
        try! AppDelegate.viewContext.save()
        
        XCTAssertEqual(Bookmark.all.first, bookmark)
        XCTAssertEqual(Bookmark.allRecipes, [])
    }

    func testBookmarkWithoutImageReturnsNil() {
        let bookmark = bookmarkWithoutImage
        try! AppDelegate.viewContext.save()
        
        XCTAssertEqual(Bookmark.all.first, bookmark)
        XCTAssertEqual(Bookmark.allRecipes, [])
    }
    
    func testBookmarkWithoutRecipeUrlReturnsNil() {
        let bookmark = bookmarkWithoutRecipe
        try! AppDelegate.viewContext.save()
        
        XCTAssertEqual(Bookmark.all.first, bookmark)
        XCTAssertEqual(Bookmark.allRecipes, [])
    }
    
    func testBookmarkWithoutUriReturnsNil() {
        let bookmark = bookmarkWithoutUri
        try! AppDelegate.viewContext.save()
        
        XCTAssertEqual(Bookmark.all.first, bookmark)
        XCTAssertEqual(Bookmark.allRecipes, [])
    }
}
