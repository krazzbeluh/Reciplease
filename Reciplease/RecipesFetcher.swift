//
//  RecipesFetcher.swift
//  Reciplease
//
//  Created by Paul Leclerc on 23/09/2019.
//  Copyright © 2019 Paul Leclerc. All rights reserved.
//

import Foundation
import Alamofire

// class used to call api
class RecipesFetcher {
    enum FetcherError: Error { // errors in fetcher (excluding AF errors)
        case noData, incorectUrl
    }
    
    var url: String { // returns the api computed with apiKey and ingredientsList
        var ingredientsString = ""
        
        var firstLoopTurn = true
        for i in Ingredient.listForSearch {
            if !firstLoopTurn {
                ingredientsString += ","
            }
            ingredientsString += i
            firstLoopTurn = false
        }
        
        return /*returnUrl =*/ "https://api.edamam.com/search?app_id=APIsignup&app_key=" + key + "&q=" + ingredientsString + "&from=0&to=20" //swiftlint:disable:this line_length
//        return returnUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
    
    private let key = "fed2ff4a" // the api Key
    
// MARK: Main func
    // calls AF method. Not testable but AF is tested by its developers.
    func fetchRecipes(completion: @escaping (Result<[Recipe], Error>) -> Void) {
        AF.request(url).responseJSON { response in
            self.treatment(response: response) { response in
                completion(response)
            }
        }
    }
    
    // treats AF response.
    func treatment(response: AFDataResponse<Any>, completion: @escaping (Result<[Recipe], Error>) -> Void) {
        switch response.result {
        case .success(_):
            guard let data = response.data else {
                completion(.failure(FetcherError.noData))
                return
            }
            
            switch EdamamDecode.convertToRecipes(data: data) {
            case .success(let recipes):
                completion(.success(recipes))
            case .failure(let error):
                completion(.failure(error))
            }
        case .failure(let error):
            completion(.failure(error))
        }
    }
}
