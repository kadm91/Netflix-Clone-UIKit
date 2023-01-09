//
//  TopShowsCollectionViewCell.swift
//  Start_Show
//
//  Created by Kevin Martinez on 8/12/22.
//

import UIKit

class TopShowsCollectionViewCell: UICollectionViewCell {
    
    
    var titlePosterURL: URL?
        
    @IBOutlet var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet var moviePoster: UIImageView! {
        didSet {
            moviePoster.backgroundColor = .clear
        }
    }


    func fetchImage(){
        if let url = titlePosterURL {
            DispatchQueue.global(qos: .userInteractive).async { [weak self] in
                if let urlContents = try? Data(contentsOf: url), let image = UIImage(data: urlContents) {
                    DispatchQueue.main.async {
                        if url == self?.titlePosterURL{
                            self?.moviePoster.image = image
                            self?.loadingIndicator.stopAnimating()
                        }
                    }
                }
            }
        }
        
    }
    
}
