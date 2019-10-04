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
    var fromPreSearchVC = false
    var gotten = false
    
    override func viewWillAppear(_ animated: Bool) {
        if !fromPreSearchVC {
            fetchBookmarks { recipes in
                self.recipes = recipes
                self.gotten = true
                self.tableView.reloadData()
            }
        } else {
            tableView.reloadData()
        }
    }
    
    private func fetchBookmarks(completion: @escaping (([Recipe]) -> Void)) {
        let bookmarks = UserDefaults.standard.object(forKey: "bookmarks") as? [String] ?? [String]()
        print(bookmarks)
        
        BookmarkFetcher(identifiers: bookmarks).fetchRecipes { recipes in
            completion(recipes)
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
        if !fromPreSearchVC && !gotten {
            let cell = tableView.dequeueReusableCell(withIdentifier: "loadingCell", for: indexPath)
            
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
