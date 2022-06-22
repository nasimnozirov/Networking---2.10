//
// Cocktail.swift
//  2.10
//
//  Created by Nasim Nozirov on 18.06.2022.
//

import Foundation

struct Cocktail: Decodable {
    
    let strDrink: String?
    let strAlcoholic: String?
    let strDrinkThumb: String?
    let strInstructions: String?
    let strIngredient1: String?
    let strIngredient2: String?
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?
    let strIngredient6: String?
    let strIngredient7: String?
    let strIngredient8: String?
    let strIngredient9: String?
    let strIngredient10: String?
    let strIngredient11: String?
    let strIngredient12: String?
    let strIngredient13: String?
    let strIngredient14: String?
    let strIngredient15: String?
    
    var description: String {
        var descriptionInStringFormat = "Ingredients: "
        let allIngredients = [
            strIngredient1,
            strIngredient2,
            strIngredient3,
            strIngredient4,
            strIngredient5,
            strIngredient6,
            strIngredient7,
            strIngredient8,
            strIngredient9,
            strIngredient10,
            strIngredient11,
            strIngredient12,
            strIngredient13,
            strIngredient14,
            strIngredient15
        ]

        for index in 0...allIngredients.count - 1 {
            if let ingredient = allIngredients[index] {
                descriptionInStringFormat += "\(ingredient)"
            }
        }
        return descriptionInStringFormat
    }
}

struct Drink: Decodable {
    let drinks: [Cocktail]
}
