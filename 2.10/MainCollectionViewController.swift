//
//  MainCollectionViewController.swift
//  2.10
//
//  Created by Nasim Nozirov on 14.06.2022.
//

import UIKit

// MARK: - Enum

enum Link: String {
case imageURL = "https://cs14.pikabu.ru/post_img/2022/05/26/5/1653546000118641678.jpg"
case courseURL = "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=margarita"
}

enum UserAction: String, CaseIterable {
    case showImage = "Show Image"
    case JsonDecoder = "JSON Decoder"
    
}


class MainCollectionViewController: UICollectionViewController {

//    тут мы с помощью гетра allCases массив вернули массив из enum UserAction
    let userActions = UserAction.allCases

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        userActions.count // количество ячеек будет равно количество элементов нашего массива
    }

//    создание ячейки
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? UserActionCell else { return UICollectionViewCell() }  // кастим до типа нашего костомного ячейки(а и наче не смогли бы до label достучится
        cell.userActionLabel.text = userActions[indexPath.item].rawValue // присваиваем к label значение массива через [indexPath.item].rawValue
    
        return cell
    }

    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let userAction = userActions[indexPath.item] // определяем по какой ячейке табнули
        switch userAction { // после определение с помощью switch мы определяем действия по нажатию на ячейку
        case .showImage: performSegue(withIdentifier: "showImage", sender: nil) //переходим 
        case .JsonDecoder: performSegue(withIdentifier: "showTableView", sender: nil) //переходим
        }
    }
    
  
}

// MARK: - UICollectionViewDelegateFlowLayout  (тут мы настраиваем ячейки чтобы они в зависимости от экрана выгл норм
extension MainCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 48, height: 100)
    }
}

// MARK: - Networking
extension MainCollectionViewController {
    private func fetchCourses() {
        guard let url = URL(string: Link.courseURL.rawValue) else { return  }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error")
                return
            }
            do {
                let course = try JSONDecoder().decode(Cocktail.self, from: data)
            
                print(course)
            } catch let error {
           
                print(error.localizedDescription)
            }
        }.resume()
    }
}

