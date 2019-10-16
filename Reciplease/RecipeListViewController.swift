//
//  RecipeListViewController.swift
//  Reciplease
//
//  Created by Paul Leclerc on 17/09/2019.
//  Copyright © 2019 Paul Leclerc. All rights reserved.
//

import UIKit

class RecipeListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView! // contains recipes list or bookmarks list
    
    var recipes = [Recipe]() // all recipes or bookmarks
    var fromPreSearchVC = false // used to know if displaying recipes or bookmarks
    
    override func viewWillAppear(_ animated: Bool) { // reloads data if bookmarks list is modified
        super.viewWillAppear(animated)
        if !fromPreSearchVC {
            self.recipes = Bookmark.allRecipes
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() { // loads table view
        super.viewDidLoad()
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { // prepares segue to RecipeVC.
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

extension RecipeListViewController: UITableViewDataSource { // manages table view
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if recipes.count > 0 {
            return recipes.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if recipes.count == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "NoData",
                                                           for: indexPath) as? NoDataTableViewCell else {
                                                            return UITableViewCell()
            }
            
            cell.configure(fromPreSearch: fromPreSearchVC)
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell",
                                                           for: indexPath) as? RecipeTableViewCell else {
                                                            return UITableViewCell()
            }
            
            cell.configure(recipeId: indexPath.row, recipe: self.recipes[indexPath.row])
            
            return cell
        }
    }
}
