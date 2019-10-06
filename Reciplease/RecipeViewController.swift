//
//  RecipeViewController.swift
//  Reciplease
//
//  Created by Paul Leclerc on 17/09/2019.
//  Copyright © 2019 Paul Leclerc. All rights reserved.
//

import UIKit

class RecipeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var starButton: UIBarButtonItem!
    
    var recipe: Recipe!
    
    private var isBookmarked: Bool {
        for bookmark in Recipe.bookmarks where bookmark == recipe.identifier {
            return true
        }
        
        return false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        
        setBookmarkButton(bookmarked: isBookmarked)
    }

    @IBAction func didTapRedirectionButton(_ sender: Any) {
        guard let url = URL(string: recipe.recipeUrl) else {
            showAlert(with: NetworkService.NetworkError.incorectUrl)
            return
        }
        UIApplication.shared.open(url)
    }
    
    @IBAction func didTabStarButton(_ sender: Any) {
        switchBookmarkRecipe()
    }
    
    private func switchBookmarkRecipe() {
        if isBookmarked {
            for index in 0 ... Recipe.bookmarks.count - 1 where Recipe.bookmarks[index] == recipe.identifier {
                Recipe.bookmarks.remove(at: index)
                
//                breaking to avoid fatalError : Index out of range
                break
            }
        } else {
            print(recipe.identifier)
            Recipe.bookmarks.append(recipe.identifier)
        }
        
        setBookmarkButton(bookmarked: isBookmarked)
    }
    
    private func setBookmarkButton(bookmarked: Bool) {
        if bookmarked {
            starButton.image = UIImage(systemName: "star.fill")
        } else {
            starButton.image = UIImage(systemName: "star")
        }
    }
    
}

extension RecipeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return "Ingredients"
        } else {
            return ""
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return recipe.ingredients.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "IntroduceCell",
                                                           for: indexPath) as? IntroduceTableViewCell else {
                                                            return UITableViewCell()
            }
            cell.configure(title: recipe.name, image: recipe.imageUrl)
            
            return cell
        } else if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell",
                                                           for: indexPath) as? IngredientTableViewCell else {
                                                            return UITableViewCell()
            }
            cell.configure(name: recipe.ingredients[indexPath.row].name)
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
}
