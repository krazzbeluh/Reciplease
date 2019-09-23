//
//  preSearchViewController.swift
//  Reciplease
//
//  Created by Paul Leclerc on 17/09/2019.
//  Copyright © 2019 Paul Leclerc. All rights reserved.
//

import UIKit

protocol PreSearchDelegate: DisplayAlert {
    func clearTextField()
}

class PreSearchViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var ingredientTextField: UITextField!
    
    private var recipes: [Recipe]?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        PreSearchViewModel.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func fetchData(completion: @escaping (Result<[Recipe], Errors>) -> Void) {
        RecipesFetcher().fetchRecipes { result in
            switch result {
            case .success(let recipes):
                completion(.success(recipes))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToRequestList" {
            let successVC = segue.destination as! RecipeListViewController
            successVC.recipes = recipes
        }
    }
    
    @IBAction func didTapSearchButton(_ sender: Any) {
        searchRecipesAndPerformSegue()
    }
    
    func searchRecipesAndPerformSegue() {
        fetchData { result in
            switch result {
            case .failure(let error):
                self.showAlert(with: error)
            case .success(let recipes):
                print(recipes)
                self.recipes = recipes
                self.performSegue(withIdentifier: "segueToRequestList", sender: self)
            }
        }
    }
    
    private func addIngredient() {
        PreSearchViewModel.addIngredient(ingredientTextField.text)
        
        tableView.reloadData()
    }
    
    @IBAction func didTapAddButton(_ sender: Any) {
        addIngredient()
    }
    
    private func clearList() {
        IngredientListForSearch.ingredients = []
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
        return IngredientListForSearch.ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell",
                                                       for: indexPath) as? IngredientTableViewCell else {
            return UITableViewCell()
        }
        
        let ingredient = IngredientListForSearch.ingredients[indexPath.row]
        
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

extension PreSearchViewController: PreSearchDelegate {
    func clearTextField() {
        ingredientTextField.text = ""
    }
}
