//
//  ViewController.swift
//  Start_Show
//
//  Created by Kevin Martinez on 8/11/22.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    

    
    @IBOutlet weak var categoryCollectionView: UICollectionView! {
        didSet {
            
            categoryCollectionView.dataSource = self
            categoryCollectionView.delegate = self
        }
    }
    
    let categories = ["Action", "Adventure", "Anime", "Children", "Clasic", "Comedies", "Documentaries", "Drama", "Family", "Fantasy", "Horror", "Music", "Romantic", "Sci-fi", "Sports", "TV Shows", "Thrillers"]
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.collectionReusableCellIdFor.categories, for: indexPath)
        
        if let categoryCell = cell as? CategorieCollectionViewCell {
            let categoryTitle = categoryCell.categoryButtom
            categoryTitle?.setTitle(categories[indexPath.row], for: .normal)
          
        }
        
        
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
