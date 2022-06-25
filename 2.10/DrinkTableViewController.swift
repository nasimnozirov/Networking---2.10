//
//  DrinkTableViewController.swift
//  2.10
//
//  Created by Nasim Nozirov on 19.06.2022.
//

import UIKit

class DrinkTableViewController: UITableViewController {
    
    var cocktails: [Cocktail] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 150
        NetworkManager.shared.fetchData { drink in
            self.cocktails = drink.drinks
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cocktails.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        let cocktail = cocktails[indexPath.row]
        content.text = cocktail.strDrink ?? "?"
        content.secondaryText = cocktail.description
        content.image = UIImage(named: DataManager.shared.cocktailImages[indexPath.row])
        content.imageProperties.cornerRadius = 25
        cell.contentConfiguration = content
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailsVC = segue.destination as? CocktailDetailsViewController else { return }
        if let indexPath = tableView.indexPathForSelectedRow {
            detailsVC.cocktail = cocktails[indexPath.row]
            detailsVC.image = UIImage(named: DataManager.shared.cocktailImages[indexPath.row])
        }
    }
}
