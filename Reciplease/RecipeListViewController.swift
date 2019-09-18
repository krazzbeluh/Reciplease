//
//  RecipeListViewController.swift
//  Reciplease
//
//  Created by Paul Leclerc on 17/09/2019.
//  Copyright © 2019 Paul Leclerc. All rights reserved.
//

import UIKit

class RecipeListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var recipes: [Recipe] = [Recipe(name: "Rien",
                                    image: "https://www.edamam.com/web-img/9fd/9fd0a2fa6bc6f6b8199d17ce0385cb47.jpg",
                                    recipe: "http://www.marthastewart.com/356426/double-crust-chicken-and-mushroom-pie",
                                    ingredients: [Ingredient(name: "Tomato", quantity: 3, measure: "kilograms"),
                                                  Ingredient(name: "Mushroom", quantity: 4, measure: "grams")],
                                    mark: 2, cookingTime: 3)]
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToRecipe" {
            let successVC = segue.destination as! RecipeViewController
            
            let sender = sender as! UIButton
            guard let recipeIDText = sender.titleLabel?.text else {
                fatalError("No data in button label")
            }
            
            guard let recipeID = Int(recipeIDText) else {
                fatalError("Text is not a number")
            }
            
            successVC.recipe = recipes[recipeID]
        }
    }
    
}

extension RecipeListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        return number of rows
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell",
                                                       for: indexPath) as? RecipeTableViewCell else {
                                                        return UITableViewCell()
        }
        
        cell.configure(recipeId: indexPath.row, recipe: recipes[indexPath.row])
        
        return cell
    }
}
