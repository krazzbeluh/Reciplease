//
//  preSearchViewController.swift
//  Reciplease
//
//  Created by Paul Leclerc on 17/09/2019.
//  Copyright © 2019 Paul Leclerc. All rights reserved.
//

import UIKit

class PreSearchViewController: UIViewController { // first VC in app
    @IBOutlet weak var tableView: UITableView! // ingredients list
    @IBOutlet weak var ingredientTextField: UITextField! // textfield to add wishes ingredients
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView! // activity indicator while API load
    
    private var recipes = [Recipe]() // recipe list (after api response)
    
    override func viewDidLoad() { // loads table view
        super.viewDidLoad()
        tableView.reloadData()
    }
    
    private func fetchData(completion: @escaping (Result<[Recipe], Error>) -> Void) { // fetchs data from api with recipesFetcher
        RecipesFetcher().fetchRecipes { result in
            switch result {
            case .success(let recipes):
                completion(.success(recipes))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func switchActivityIndicator(shown: Bool) { // switchs activity indicator
        activityIndicator.isHidden = !shown
        searchButton.isHidden = shown
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { // preparing segue to perform
        if segue.identifier == "segueToRequestList" {
            let successVC = segue.destination as! RecipeListViewController
            
            successVC.recipes = recipes
            successVC.fromPreSearchVC = true
        }
    }
    
    @IBAction func didTapSearchButton(_ sender: Any) { // launches fetcher if there's at least 1 ingredient
        guard Ingredient.listForSearch.count > 0 else {
            showAlert(with: Ingredient.IngredientListError.voidList)
            return
        }
        searchRecipesAndPerformSegue()
    }
    
    private func searchRecipesAndPerformSegue() { // searches recipes and perform segue if no error
        switchActivityIndicator(shown: true)
        fetchData { result in
            switch result {
            case .failure(let error):
                self.showAlert(with: error)
            case .success(let recipes):
                self.recipes = recipes
                self.performSegue(withIdentifier: "segueToRequestList", sender: self)
            }
            self.switchActivityIndicator(shown: false)
        }
    }
    
    private func addIngredient(_ ingredient: String?) { // adds ingredient to list if not nil and not already in list
        guard let ingredient = ingredient,
            ingredient != "" else {
            showAlert(with: UIError.nilInTextField)
            return
        }

        for ingredientInList in Ingredient.listForSearch {
            guard ingredient != ingredientInList else {
                showAlert(with: Ingredient.IngredientListError.ingredientAlreadyInList)
                return
            }
        }

        Ingredient.listForSearch.append(ingredient)

        ingredientTextField.text = ""
    }
    
    private func addIngredient() { // adds ingredient to list and reloads table view
        addIngredient(ingredientTextField.text)
        
        tableView.reloadData()
    }
    
    @IBAction func didTapAddButton(_ sender: Any) {
        addIngredient()
    }
    
    private func clearList() { // clears ingredients list and reloads table view
        Ingredient.listForSearch = []
        tableView.reloadData()
    }
    
    @IBAction func didTapClearButton(_ sender: Any) {
        clearList()
    }
    
    @IBAction func dismissKeyboard(_ sender: Any) {
        ingredientTextField.resignFirstResponder()
    }
    
}

extension PreSearchViewController: UITableViewDataSource { // manages table view
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Ingredient.listForSearch.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell",
                                                       for: indexPath) as? IngredientTableViewCell else {
            return UITableViewCell()
        }
        
        let ingredient = Ingredient.listForSearch[indexPath.row]
        
        cell.configure(name: ingredient)
        
        return cell
    }
    
}

extension PreSearchViewController: UITextFieldDelegate { // manages text field
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if ingredientTextField.text != nil && ingredientTextField.text != "" {
            addIngredient()
        }
        ingredientTextField.resignFirstResponder()
        return true
    }
}
