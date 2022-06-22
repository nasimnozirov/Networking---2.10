//
//  CocktailDetailsViewController.swift
//  2.10
//
//  Created by Nasim Nozirov on 22.06.2022.
//

import UIKit

class CocktailDetailsViewController: UIViewController {
    
    @IBOutlet var cocktailImage: UIImageView!
    @IBOutlet var cocktailNamesLabel: UILabel!
    @IBOutlet var cocktailDescriptionLabel: UILabel!
    
    var cocktail: Cocktail!
    var image: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    private func updateUI() {
        cocktailImage.image = image
        cocktailImage.layer.cornerRadius = 25
        cocktailNamesLabel.text = cocktail.debugDescription
        cocktailDescriptionLabel.text = cocktail.strInstructions
    }
}
