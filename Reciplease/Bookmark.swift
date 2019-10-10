//
//  Bookmark.swift
//  Reciplease
//
//  Created by Paul Leclerc on 07/10/2019.
//  Copyright © 2019 Paul Leclerc. All rights reserved.
//

import Foundation
import CoreData

class Bookmark: NSManagedObject {
    static var all: [Bookmark] {
        let request: NSFetchRequest<Bookmark> = Bookmark.fetchRequest()
        let bookmarks = try! AppDelegate.viewContext.fetch(request)
        return bookmarks
    }
    static var allRecipes: [Recipe] {
        var recipes = [Recipe]()
        for bookmark in all {
            let recipeOpt = bookmark.convertToRecipe()
            
            if let recipe = recipeOpt {
                print(recipe)
                recipes.append(recipe)
            }
            
        }
        
        return recipes
    }
    
    private func convertToRecipe() -> Recipe? {
        guard let name = self.name else {
            return nil
        }
        
        guard let imageUrl = self.imageUrl else {
            return nil
        }
        
        guard let recipeUrl = self.recipeUrl else {
            return nil
        }
        
        guard let uri = self.uri else {
            return nil
        }
        
        let bIngredients = self.ingredients!.allObjects as! [BIngredient]
        
        var ingredients = [Ingredient]()
        for bIngredient in bIngredients {
            if let ingredient = bIngredient.asIngredient() {
                ingredients.append(ingredient)
            }
        }
        
        return Recipe(name: name,
                      image: imageUrl,
                      recipe: recipeUrl,
                      ingredients: ingredients,
                      uri: uri)
    }
    
    static func saveBookmark(_ recipe: Recipe) {
        let bookmark = Bookmark(context: AppDelegate.viewContext)
        bookmark.name = recipe.name
        bookmark.uri = recipe.uri
        bookmark.recipeUrl = recipe.recipeUrl
        bookmark.imageUrl = recipe.imageUrl
        
        var bIngredients = [BIngredient]()
        for ingredient in recipe.ingredients {
            bIngredients.append(ingredient.asBIngredient())
        }
        
        bookmark.ingredients = NSSet(array: bIngredients)
        
        AppDelegate.saveContext()
    }
    
    static func deleteBookmark(_ bookmark: Bookmark) {
        AppDelegate.viewContext.delete(bookmark)
        AppDelegate.saveContext()
    }
}

class BIngredient: NSManagedObject {
    func asIngredient() -> Ingredient? {
        guard let name = self.name else {
            return nil
        }
        return Ingredient(name: name)
    }
}
