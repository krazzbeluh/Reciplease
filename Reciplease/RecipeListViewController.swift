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
    var bookmarks = true
    
    override func viewWillAppear(_ animated: Bool) {
        if bookmarks {
            fetchBookmarks {
                self.tableView.reloadData()
            }
        } else {
            tableView.reloadData()
        }
    }
    
    private func fetchBookmarks(completion: @escaping (() -> Void)) {
        let bookmarks = UserDefaults.standard.object(forKey: "bookmarks") as? [String] ?? [String]()
        
        let numberOfBookmarks = bookmarks.count
        var fetchedRecipes = 0
        
        for bookmark in bookmarks {
            BookmarkFetcher(identifier: bookmark).fetchRecipe { result in
                fetchedRecipes += 1
                
                switch result {
                case .success(let recipe):
                    guard let recipe = recipe else {
                        self.showAlert(with: NetworkService.NetworkError.emptyBookmarkResponse)
                        return
                    }
                    
                    self.recipes.append(recipe)
                case .failure(let error):
                    self.showAlert(with: error)
                }
                
                if fetchedRecipes == numberOfBookmarks {
                    completion()
                }
            }
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
        //        return number of rows
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell",
                                                       for: indexPath) as? RecipeTableViewCell else {
                                                        return UITableViewCell()
        }
        
        cell.configure(recipeId: indexPath.row, recipe: self.recipes[indexPath.row])
        
        return cell
    }
}
