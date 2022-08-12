//
//  ViewController.swift
//  Start_Show
//
//  Created by Kevin Martinez on 8/11/22.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let categories = ["Action", "Adventure", "Anime", "Children", "Family", "Clasic", "Comedies", "Documentaries", "Drama", "Horror", "Music", "Romantic","Sci-fi", "Fantasy", "Sports", "Thrillers", "TV Shows"]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = UICollectionViewCell()
        return cell
    }
    
    

  

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

struct K {
    struct collectionReusableCellIdFor {
        static let categories = "Categories"
    }
}
