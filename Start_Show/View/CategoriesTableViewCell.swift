//
//  CategoriesTableViewCell.swift
//  Start_Show
//
//  Created by Kevin Martinez on 8/13/22.
//

import UIKit



class CategoriesTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    var titles = [TitleResults]()
    var didSelecItemAction: ((TitleResults)->Void)?

    
    @IBOutlet var moviesCollectionView: UICollectionView!{
        didSet {
            moviesCollectionView.delegate = self
            moviesCollectionView.dataSource = self
        }
    }
    
   
    
    override func prepareForReuse() {
        super.prepareForReuse()
        DispatchQueue.main.async {
            self.moviesCollectionView.reloadData()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return titles.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let topShowsCell = collectionView.dequeueReusableCell(withReuseIdentifier: K.CollectionViewReusableCellIdFor.topShows, for: indexPath)
        if let topShowsCell = topShowsCell as? TopShowsCollectionViewCell {
            
            if let postterPath = titles[indexPath.item].poster_path {
                if let url = URL(string:  K.BaseURLFor.titlePosterImage(withQuality: .medium)+postterPath ){
                    topShowsCell.titlePosterURL = url
                    topShowsCell.fetchImage()
                }
            }
        }
    
        return topShowsCell
        
    }
    
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        glovalResult = titles[indexPath.item]
    }
    
}

