//
//  preSearchViewController.swift
//  Reciplease
//
//  Created by Paul Leclerc on 17/09/2019.
//  Copyright © 2019 Paul Leclerc. All rights reserved.
//

import UIKit

class PreSearchViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToRequestList" {
            let successVC = segue.destination as! RecipeListViewController
            successVC.recipes = [Recipe(name: "Double-Crust Chicken and Mushroom Pie",
                                        image: "https://www.edamam.com/web-img/9fd/9fd0a2fa6bc6f6b8199d17ce0385cb47.jpg", //swiftlint:disable:this line_length
                                        recipe: "http://www.marthastewart.com/356426/double-crust-chicken-and-mushroom-pie", //swiftlint:disable:this line_length
                                        ingredients: [Ingredient(name: "Tomato", quantity: 3, measure: "kilograms"),
                                                      Ingredient(name: "Mushroom", quantity: 2, measure: "")],
                                        mark: 4, cookingTime: 5),
                                 Recipe(name: "Slow-Cooker Red Curry Soup With Chicken and Kale Recipe",
                                        image: "https://www.edamam.com/web-img/1e9/1e920f1d762a3e0b53842f754ad041f0.jpg", //swiftlint:disable:this line_length
                                        recipe: "http://www.seriouseats.com/recipes/2014/02/slow-cooker-penang-curry-soup-with-chicken-and-kale.html", //swiftlint:disable:this line_length
                                    ingredients: [Ingredient(name: "Tomato", quantity: 3, measure: "Units")],
                                    mark: 6, cookingTime: 2)]
        }
    }

}

extension PreSearchViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell",
                                                       for: indexPath) as? IngredientTableViewCell else {
            return UITableViewCell()
        }
        
        let ingredient = "Tomatoes"
        
        cell.configure(name: ingredient)
        
        return cell
    }
    
}
