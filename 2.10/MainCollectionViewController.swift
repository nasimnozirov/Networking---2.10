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
case courseURL = "https://v2.jokeapi.dev/joke/Any?safe-mode"
}

enum UserAction: String, CaseIterable {
    case showImage = "Show Image"
    case JsonDecoder = "JSON Decoder"
    
}


class MainCollectionViewController: UICollectionViewController {

    let userActions = UserAction.allCases
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
//
//
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        userActions.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? UserActionCell else { return UICollectionViewCell() }
        cell.userActionLabel.text = userActions[indexPath.item].rawValue
    
        return cell
    }

    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let userAction = userActions[indexPath.item]
        switch userAction {
        case .showImage: performSegue(withIdentifier: "showImage", sender: nil)
        case .JsonDecoder: fetchCourses()
        }
    }
    
    // MARK: - Private Methods
    private func successAlert() {
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: "Success",
                message: "You can see the results in the Debug aria",
                preferredStyle: .alert
            )
            
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
            self.present(alert, animated: true)
        }
    }
    
    private func failedAlert() {
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: "Failed",
                message: "You can see error in the Debug aria",
                preferredStyle: .alert
            )
            
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
            self.present(alert, animated: true)
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
                let course = try JSONDecoder().decode(Course.self, from: data)
                self.successAlert()
                print(course)
            } catch let error {
                self.failedAlert()
                print(error.localizedDescription)
            }
        }.resume()
    }
}

