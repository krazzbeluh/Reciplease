//
//  RecipeViewController.swift
//  Reciplease
//
//  Created by Paul Leclerc on 17/09/2019.
//  Copyright © 2019 Paul Leclerc. All rights reserved.
//

import UIKit

class RecipeViewController: UIViewController { // Detailed recipe VC
    @IBOutlet weak var tableView: UITableView! // tableView integrating introduceTaVC and ingredientTVC
    @IBOutlet weak var starButton: UIBarButtonItem!  // bookmark button
    
    var recipe: Recipe! // recipe object.
    
    private var isBookmarked: Bool { // verifies if recipe is bookmarked
        for bookmark in Bookmark.all where bookmark.uri == recipe.uri {
            return true
        }
        return false
    }
    
    override func viewDidLoad() { // reloads tableView after view load
        super.viewDidLoad()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) { // refreshs bookmarkButton after returning on VC
        setBookmarkButton(bookmarked: isBookmarked)
    }

    @IBAction func didTapRedirectionButton(_ sender: Any) { // opens url in navigator
        guard let url = URL(string: recipe.recipeUrl) else {
            showAlert(with: RecipesFetcher.FetcherError.incorectUrl) // shows alert if unusable url
            return
        }
        UIApplication.shared.open(url)
    }
    
    @IBAction func didTabStarButton(_ sender: Any) {
        switchBookmarkRecipe()
    }
    
    private func switchBookmarkRecipe() { // adding/deleting bookmark and changing button
        print(isBookmarked)
        if isBookmarked {
            for index in 0 ... Bookmark.all.count - 1 where Bookmark.all[index].uri == recipe.uri {
                Bookmark.deleteBookmark(Bookmark.all[index])
                
//                breaking to avoid fatalError : Index out of range in next loop turns
                break
            }
        } else {
            Bookmark.saveBookmark(recipe)
        }
        
        setBookmarkButton(bookmarked: isBookmarked)
    }
    
    private func setBookmarkButton(bookmarked: Bool) { // sets bookmark button as attributed
        if bookmarked {
            starButton.image = UIImage(systemName: "star.fill")
        } else {
            starButton.image = UIImage(systemName: "star")
        }
    }
}

extension RecipeViewController: UITableViewDataSource { // managing tableView
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 { // if section is ingredientsSection
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
