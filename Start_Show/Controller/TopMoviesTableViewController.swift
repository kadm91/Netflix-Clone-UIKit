//
//  TopMoviesTableViewController.swift
//  Start_Show
//
//  Created by Kevin Martinez on 8/13/22.
//

import UIKit

var dataLoaded = false


class TopMoviesTableViewController: UITableViewController, UINavigationBarDelegate {
    
    //MARK: - @IBOutles
    @IBOutlet var navegationBar: UINavigationBar! {
        didSet {
            navegationBar.delegate = self
        }
    }
    
    @IBOutlet var topMovieViewContainer: UIView!
    
    @IBOutlet var topMovieImage: UIImageView!
    
    @IBOutlet var topMovieLoadingIndicator: UIActivityIndicatorView!
    
    @IBOutlet var topMovieTitleLabel: UILabel!{didSet{
        topMovieTitleLabel.text = ""
    }}
    
    @IBOutlet var topMovieGenresLable: UILabel!{
        didSet{
            topMovieGenresLable.text = ""
        }
    }
    
  
    
    //MARK: - Properties
    
    var titleManager = TitlesManager()
    var topMovieManager = TopMovieManager()
    lazy var generes = Genres()
    var titles = [TitleResults]()
    var SelectedTopMovie: TopMovieResult?
    
    //MARK: - Life Cycle
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startedConfiguration()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
   
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return  generes.genres.count
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var titlesPerCategory = [TitleResults]()
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.TableViewReusableCellIdFor.topShows, for: indexPath)
        if let cell = cell as? CategoriesTableViewCell {
            
            for title in titles {
                for genre in title.genre_ids {
                    if generes.genres[indexPath.section].id.rawValue == genre {
                        titlesPerCategory.append(title)
                        
                    }
                }
            }
            cell.titles = titlesPerCategory
        }
        return cell
    }
    
    //MARK: - TableView Delegate
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = .white
        header.textLabel?.font = UIFont.systemFont(ofSize: 24, weight: .heavy)
        header.textLabel?.frame = header.bounds
        header.textLabel?.text = header.textLabel?.text?.capitalized
        
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    
        return generes.genres[section].name.rawValue//categories[section].name
        
    }
    
    
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        
        self.navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
    
    
    //MARK: - @IBACtion
    
    @IBAction func topMovieInfoPresed(_ sender: UIButton) {
        performSegue(withIdentifier: K.segueIdFor.topMovieDescription, sender: self)
    }
    
    
    @IBAction func playTrailerInFullScreenPreset(_ sender: UIButton) {
        performSegue(withIdentifier: K.segueIdFor.playTopMovieTrailerInFullScreen, sender: self)
    }
    
    
    
    
    //MARK: - Navegation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
            
        case K.segueIdFor.topMovieDescription:
            prepareDescriptionVCForTopMovieInfo(for: segue, PlayTrailerInFullScreen: false)
            
        case K.segueIdFor.playTopMovieTrailerInFullScreen:
            prepareDescriptionVCForTopMovieInfo(for: segue, PlayTrailerInFullScreen: true)
            
        default: break
        }
        
    }
      
    
    
    
    //MARK: - Methods
    
    
    private func prepareDescriptionVCForTopMovieInfo(for segue: UIStoryboardSegue, PlayTrailerInFullScreen: Bool) {

        if let descriptionVC = segue.destination as? TitleDescriptionViewController {
            descriptionVC.topMovieSelected = true
            if let SelectedTopMovie = SelectedTopMovie {
                descriptionVC.id = SelectedTopMovie.id
                descriptionVC.topMovieTitle = SelectedTopMovie.title
                descriptionVC.topMovieOverview = SelectedTopMovie.overview
                descriptionVC.topMovieGenres = SelectedTopMovie.genre_ids
                descriptionVC.playTopVideoInFullScreen = PlayTrailerInFullScreen
               
            }
        }
    }
    
    
    private func startedConfiguration(){
        titleManager.delegate = self
        topMovieManager.delegate = self
        
        if dataLoaded == false {
            titleManager.getTitles()
            topMovieManager.getTopMovie()
            dataLoaded = true
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.addGradiantsToTopMovieImage()
            self?.configureNavbar()
        }
       
    }
    
    
   private func addGradiantsToTopMovieImage() {
        let view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: topMovieViewContainer.bounds.width + 14.0, height: topMovieImage.bounds.height))
        let gradient = CAGradientLayer()
        gradient.frame = view.frame
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradient.locations = [0.0, 1.0]
        view.layer.insertSublayer(gradient, at: 1)
        topMovieImage.addSubview(view)
        topMovieImage.bringSubviewToFront(view)
    }
    
    
    
    
    private func configureNavbar() {
        
        
        
        let logoBtn = UIButton(type: .custom)
        logoBtn.isUserInteractionEnabled = false
    logoBtn.setImage(UIImage(named: "homeScreenLogo"), for: .normal)
        logoBtn.frame = CGRect(x: 0, y: 0, width: 20, height: 35)
        let logoView = UIView(frame: logoBtn.frame)
        logoView.addSubview(logoBtn)
        
        let profilePic = UIButton(type: .custom)
        profilePic.setImage(UIImage(named: "profilePicTest"), for: .normal)
        profilePic.frame = CGRect(x: 0, y: 0, width: 28, height: 28)
        let profilePicView = UIView(frame: profilePic.frame)
        profilePicView.addSubview(profilePic)
        
        
        let leftNavBarItem = UIBarButtonItem(customView: logoView)
        let profilePicBarItem = UIBarButtonItem(customView: profilePicView)

        
        navegationBar.topItem?.setLeftBarButton(leftNavBarItem, animated: true)
        navegationBar.topItem?.rightBarButtonItems = [profilePicBarItem, UIBarButtonItem(image: UIImage(systemName: "airplayvideo"), style: .done, target: self, action: nil) ]

        navegationBar.setBackgroundImage(UIImage(), for: .default)
        navegationBar.shadowImage = UIImage()
        navegationBar.isTranslucent = true
        
     
        
     
    }
    
    
    //MARK: - End of TopMoviesTableViewController
}
//MARK: - Extensions

//MARK: - TitlesManagerDelegate

extension TopMoviesTableViewController: TitleManagerDelegate {
    func didUpdateTitles(_ GenderManager: TitlesManager, titles: TitleModel) {
        
        
        
        DispatchQueue.main.async {
            let titlesResults = titles.titles
            self.titles = titlesResults
            self.tableView.reloadData()
        }
        
    }
    
    func titledidFailWithError(error: Error) {
        // handle any errors
    }
}


//MARK: - TopMovieManagerExtension

extension TopMoviesTableViewController: TopMovieManagerDelegate {
    func didUpdateTopMovie(_ topMovieManager: TopMovieManager, topMovie: TopMovieModel) {
        
        let randonTopMovie = Int.random(in: 0..<topMovie.topMovie.count)
        let genresForTopMoview = topMovie.topMovie[randonTopMovie].genre_ids
        let combinedGenresString = generes.extractGenresForMovie(idForMovie: genresForTopMoview)

        
       
            SelectedTopMovie = topMovie.topMovie[randonTopMovie]
        
      
        
        
        var titlePosterURL: URL? {
            if let postterPath = topMovie.topMovie[randonTopMovie].poster_path {
                if let url = URL(string:  K.BaseURLFor.titlePosterImage(withQuality: .superHd)+postterPath ) {
                    return url
                }
            }
            return nil
        }
        
        if let url = titlePosterURL {
            DispatchQueue.global(qos: .userInteractive).async { [weak self] in
                if let urlContents = try? Data(contentsOf: url), let image = UIImage(data: urlContents) {
                    DispatchQueue.main.async {
                        if url == titlePosterURL{
                            self?.topMovieImage.image = image
                            self?.topMovieTitleLabel.text  = topMovie.topMovie[randonTopMovie].title
                            self?.topMovieGenresLable.text = combinedGenresString
                            self?.topMovieLoadingIndicator.stopAnimating()
                        }
                    }
                }
            }
        }
    }
    
    
    
    func topMoviedidFailWithError(error: Error) {
        //handle any errors
    }
    
}




