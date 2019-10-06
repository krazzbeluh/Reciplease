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
    @IBOutlet weak var ingredientTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var recipes: [Recipe]?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func fetchData(completion: @escaping (Result<[Recipe], Error>) -> Void) {
        RecipesFetcher().fetchRecipes { result in
            switch result {
            case .success(let recipes):
                completion(.success(recipes))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func switchActivityIndicator(shown: Bool) {
        activityIndicator.isHidden = !shown
        searchButton.isHidden = shown
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToRequestList" {
            let successVC = segue.destination as! RecipeListViewController
            
            guard let recipes = recipes else {
                showAlert(with: NetworkService.NetworkError.emptyResponse)
                return
            }
            
            successVC.recipes = recipes
            successVC.fromPreSearchVC = true
        }
    }
    
    @IBAction func didTapSearchButton(_ sender: Any) {
        guard Ingredient.listForSearch.count > 0 else {
            showAlert(with: Ingredient.IngredientListError.voidList)
            return
        }
        searchRecipesAndPerformSegue()
    }
    
    func searchRecipesAndPerformSegue() {
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
    
    func addIngredient(_ ingredient: String?) {
        guard let ingredient = ingredient else {
            showAlert(with: UIError.nilInTextField)
            return
        }

        guard ingredient != "" else {
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
    
    private func addIngredient() {
        addIngredient(ingredientTextField.text)
        
        tableView.reloadData()
    }
    
    @IBAction func didTapAddButton(_ sender: Any) {
        addIngredient()
    }
    
    private func clearList() {
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

extension PreSearchViewController: UITableViewDataSource {
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

extension PreSearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if ingredientTextField.text != nil && ingredientTextField.text != "" {
            addIngredient()
        }
        ingredientTextField.resignFirstResponder()
        return true
    }
}
