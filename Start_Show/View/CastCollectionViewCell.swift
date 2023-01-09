//
//  CastCollectionViewCell.swift
//  Start_Show
//
//  Created by Kevin Martinez on 9/11/22.
//



/* Note:
 we could use the profile_path from the title cast model call to avoid making extra calls to the API, but I wanted to show that witht he API manger we can make and API call and work with the data we get back whit in the CollectionViewCell itself.
 */

import UIKit

class CastCollectionViewCell: UICollectionViewCell {
    

    @IBOutlet var actorProfilePic: UIImageView!{ didSet {actorProfilePic.makeRounded(); actorProfilePic.tintColor = .lightGray}}
    @IBOutlet var actorName: UILabel!
    @IBOutlet var actorRollName: UILabel!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    
    var profilePicturePath = String()
    
    func fetchProfilePicture() {
        let baseUrl = K.BaseURLFor.titlePosterImage(withQuality: .high)
        let urlString = "\(baseUrl)\(profilePicturePath)"
        let profilePicUrl = URL(string: urlString)
        
        if let url = profilePicUrl {
            DispatchQueue.global(qos: .userInteractive).async { [weak self] in
                if let urlContents = try? Data(contentsOf: url), let image = UIImage(data: urlContents) {
                    DispatchQueue.main.async {
                            self?.actorProfilePic.image = image
                            self?.activityIndicator.stopAnimating()
                    }
                }
            }
        }
        
    }
}
