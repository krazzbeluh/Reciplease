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
    
    var recipes = [Recipe]()
    private var firstLoad = true
    var fromPreSearchVC = false
    private var gotten = false
    private var oldBookmarks = [Recipe]()
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        if !fromPreSearchVC && (firstLoad || Bookmark.allRecipes != oldBookmarks) {
            self.recipes = Bookmark.allRecipes
            self.gotten = true
            self.tableView.reloadData()
            self.oldBookmarks = Bookmark.allRecipes
            self.firstLoad = false
        }
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
        if !fromPreSearchVC && !gotten {
            return 1
        } else {
            return recipes.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if !fromPreSearchVC && !gotten && Bookmark.all.count > 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LoadingCell", for: indexPath)
            
            return cell
        } else if !fromPreSearchVC && Bookmark.all.count == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NoBookmarks", for: indexPath)
            
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
