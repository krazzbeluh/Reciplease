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
    static var all: [Recipe] {
        let request: NSFetchRequest<Bookmark> = Bookmark.fetchRequest()
        guard let bookmarks = try? AppDelegate.viewContext.fetch(request) else {
            return []
        }
        
        var recipes = [Recipe]()
        for bookmark in bookmarks {
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
        
        guard let ingredientsSet = self.ingredients else {
            return nil
        }
        
        // MARK: A revoir
        var ingredients = [Ingredient]()
        for ingredient in ingredientsSet {
            if let bIngredient = ingredient as? BIngredient {
                if let ingredientName = bIngredient.name {
                    ingredients.append(Ingredient(name: ingredientName))
                }
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
        
        do {
            try AppDelegate.viewContext.save()
        } catch {
            print("erreur")
        }
    }
}

class BIngredient: NSManagedObject {
    static var all: [BIngredient] {
        let request: NSFetchRequest<BIngredient> = BIngredient.fetchRequest()
        guard let ingredients = try? AppDelegate.viewContext.fetch(request) else {
            return []
        }
        return ingredients
    }
}
