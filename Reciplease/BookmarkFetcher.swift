//
//  BookmarkFetcher.swift
//  Reciplease
//
//  Created by Paul Leclerc on 23/09/2019.
//  Copyright © 2019 Paul Leclerc. All rights reserved.
//

import Foundation

class BookmarkFetcher {
    
    init(identifiers: [String]) {
        self.identifiers = identifiers
//        networkService = NetworkService(url: url)
    }
    
    var networkService = NetworkService(url: "https://www.google.fr")
//    private var url: String {
//        let returnUrl = "https://api.edamam.com/search?app_id=API signup&app_key=" + key + "&q=" + identifiers[0] //swiftlint:disable:this line_length
//        return returnUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
//    }
    
    private let key = "fed2ff4a"
    var identifiers: [String]
    
//    Main func
    func fetchRecipes(completion: @escaping ([Recipe]) -> Void) {
        var recipes = [Recipe]()
        for identifier in identifiers {
            var urlString = "https://api.edamam.com/search?app_id=API signup&app_key=" + key + "&q=" + identifier
            urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            let urlOpt = URL(string: urlString)
            
            guard let url = urlOpt else {
                print("error : Invalid url : " + urlString)
                return
            }
            
            networkService.getData(url: url) { result in
                switch result {
                case .success(let data):
                    guard let recipesData = try? JSONDecoder().decode(Edamam.self, from: data) else {
                        return
                    }
                    
                    var recipeOpt: Recipe?
                    for hit in recipesData.hits {
                        
                        var ingredients = [Ingredient]()
                        for ingredient in hit.recipe.ingredients {
                            ingredients.append(Ingredient(name: ingredient.food))
                        }
                        
                        recipeOpt = Recipe(name: hit.recipe.label,
                                              image: hit.recipe.image,
                                              recipe: hit.recipe.url,
                                              ingredients: ingredients,
                                              uri: hit.recipe.uri)
                    }
                    
                    guard let recipe = recipeOpt else {
                        return
                    }
                    
                    recipes.append(recipe)
                case .failure(let error):
                    print(error)
                }
                completion(recipes)
            }
        }
    }
}
