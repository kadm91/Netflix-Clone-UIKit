//
//  TitleDescriptionViewController.swift
//  Start_Show
//
//  Created by Kevin Martinez on 8/21/22.
//


// TODO: change the api call for the cast image for the one already in the cast model

import UIKit
import YouTubeiOSPlayerHelper

var glovalResult: TitleResults?

class TitleDescriptionViewController: UIViewController {
    
    @IBOutlet var trailerVideoLoadingIndicador: UIActivityIndicatorView!
    @IBOutlet var trailerPlayerView: YTPlayerView!
    @IBOutlet var titleLabel: UILabel! {didSet{titleLabel.text = ""}}
    @IBOutlet var titleOverviewLabel: UILabel! {didSet{titleOverviewLabel.text = ""}}
    @IBOutlet var titleGeneresLabel: UILabel! {didSet{titleGeneresLabel.text = ""}}
    @IBOutlet var castCollectionView: UICollectionView! {didSet {castCollectionView.delegate = self; castCollectionView.dataSource = self}}
    
   
    var trailerVideoManager = VideoManager()
    var topMovieSelected = false
    var playTopVideoInFullScreen = false
    var id = Int()
    var topMovieTitle = String()
    var topMovieOverview = String()
    var topMovieGenres = [Int]()
    var viewTranslation = CGPoint(x: 0, y: 0)
    var movieCast = [TitleCastResult]()
    var castManager = CastManager()
    var titleGenres = Genres()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handleDismiss)))
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        trailerPlayerView.delegate = self
        trailerVideoManager.delegate = self
        castManager.delegate = self

        if !topMovieSelected {
            guard let gloavalResultId = glovalResult?.id else {return}
            id = gloavalResultId
            
            if glovalResult?.title != nil {
                titleLabel.text = glovalResult?.title
            } else if glovalResult?.original_title != nil {
                titleLabel.text = glovalResult?.original_title
            } else if glovalResult?.original_name != nil {
                titleLabel.text = glovalResult?.original_name
            }
            guard let titleGenresIds = glovalResult?.genre_ids else {return}
           titleOverviewLabel.text = glovalResult?.overview
           titleGeneresLabel.text = titleGenres.extractGenresForMovie(idForMovie: titleGenresIds )
            
            
            
        } else {
            titleLabel.text = topMovieTitle
            titleOverviewLabel.text = topMovieOverview
            titleGeneresLabel.text = titleGenres.extractGenresForMovie(idForMovie: topMovieGenres)
        }
        trailerVideoManager.getVideos(videoId: id)
        castManager.getcast(for: id)
        
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    //MARK: - @objc methods
    
    @objc func handleDismiss(sender: UIPanGestureRecognizer) {
        
        if sender.translation(in: view).y > 0 {
            

        switch sender.state {
        case .changed:
            viewTranslation = sender.translation(in: view)
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.view.transform = CGAffineTransform(translationX: 0, y: self.viewTranslation.y)
            })
        case .ended:
            if viewTranslation.y < 200 {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    self.view.transform = .identity
                })
            } else {
                dismiss(animated: true, completion: nil)
            }
        default:
            break
        }
        }
        
    }
    
}

//MARK: - Extensions

extension TitleDescriptionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movieCast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let performerCell = collectionView.dequeueReusableCell(withReuseIdentifier: K.CollectionViewReusableCellIdFor.actors, for: indexPath)
        
        
        
        
        if let performerCell = performerCell as? CastCollectionViewCell {
            
            if let profilePicPath = movieCast[indexPath.item].profile_path {
                performerCell.profilePicturePath = profilePicPath
                performerCell.fetchProfilePicture()
            } else {
                performerCell.activityIndicator.stopAnimating()
                performerCell.actorProfilePic.image = UIImage(systemName: "person.circle")
            }
           
         
            performerCell.actorName.text = movieCast[indexPath.item].name
            performerCell.actorRollName.text = movieCast[indexPath.item].character
            
        }
      
    
        return performerCell
        
        
    }
    
    
}


//MARK: - VideoManagerDelegate

extension TitleDescriptionViewController: VideoManagerDelegate {
    func didUpdateVideos(_ GenderManager: VideoManager, videos: VideoModel) {
       
        var trailerKey: String?
        var playInLine: Int {
          return playTopVideoInFullScreen ? 0 : 1
        }
                
        for trailer in videos.videoResults {
            if trailer.site == "YouTube" && trailer.type == "Trailer"  {
                trailerKey = trailer.key
                break
            } else {
                trailerKey = trailer.key
            }
        }
        
        if let key = trailerKey {
            DispatchQueue.main.async { [weak self] in

                self?.trailerPlayerView.load(withVideoId: key, playerVars: ["playsinline": playInLine])
                self?.trailerVideoLoadingIndicador.stopAnimating()
                self?.topMovieSelected = false
            }
        }
        
    }
    
    func titledidFailWithError(error: Error) {
        print(error)
    }
}

//MARK: - YTPlayerViewDelegate

extension TitleDescriptionViewController: YTPlayerViewDelegate {
    
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        
             playTopVideoInFullScreen ?   playerView.playVideo() : playerView.stopVideo()
    }
 
}

//MARK: -  CastManagerDelegate
extension TitleDescriptionViewController: CastManagerDelegate {
    func didUpdateCast(_ topMovieManager: CastManager, cast: TitleCastModel) {
        
        
        // limit the number of actor the app will display , personally I think 15 is enough.
        switch cast.titleCast.count {
        case 15...:
            for index in 0..<15 {
                movieCast.append(cast.titleCast[index])
            }
        default:
            movieCast = cast.titleCast
        }
        
        
        DispatchQueue.main.async {
            self.castCollectionView.reloadData()
        }
        
        
    }
    
    func castFailWithError(error: Error) {
        // handle errors
    }
}
