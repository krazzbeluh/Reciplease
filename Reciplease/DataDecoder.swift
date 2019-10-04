// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

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
