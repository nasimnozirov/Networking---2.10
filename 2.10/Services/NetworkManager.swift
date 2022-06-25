//
//  NetworkManager.swift
//  2.10
//
//  Created by Nasim Nozirov on 19.06.2022.
//

import Foundation

class NetworkManager {
    
    static  let shared = NetworkManager()
    
    func fetchData(_ completion: @escaping (Drink) -> ()) {
        guard let url = URL(string: "\(Link.courseURL.rawValue)") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No Error")
                return
            }
            do {
                let drink = try JSONDecoder().decode(Drink.self, from: data)
                completion(drink)
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
    private init() { }
}
