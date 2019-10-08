// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

class EdamamDecode {
    // MARK: Decode()
    static func convertToRecipes(data: Data) -> Result<[Recipe], Error> {
        guard let recipesDecoded = try? JSONDecoder().decode(Edamam.self, from: data) else {
            return .failure(DecoderError.unableToDecodeData)
        }
        
        var recipes = [Recipe]()
        for hit in recipesDecoded.hits {
            
            var ingredients = [Ingredient]()
            for ingredient in hit.recipe.ingredients {
                ingredients.append(Ingredient(name: ingredient.food))
            }
            
            recipes.append(Recipe(name: hit.recipe.label,
                                  image: hit.recipe.image,
                                  recipe: hit.recipe.url,
                                  ingredients: ingredients,
                                  uri: hit.recipe.uri))
        }
        
        return(.success(recipes))
    }
    
    // MARK: - Errors
    enum DecoderError: Error {
        case unableToDecodeData
    }

    // MARK: - Welcome
    struct Edamam: Decodable {
        let q: String
        let from, to: Int
        let more: Bool
        let count: Int
        let hits: [Hit]
    }

    // MARK: - Hit
    struct Hit: Decodable {
        let recipe: RecipeDecoder
    }

    // MARK: - Recipe
    struct RecipeDecoder: Decodable {
        let uri: String
        let label: String
        let image: String
        let url: String
        let ingredients: [IngredientDecoder]
    }

    // MARK: - Ingredient
    struct IngredientDecoder: Decodable {
        let food: String
    }
}
