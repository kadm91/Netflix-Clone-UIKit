//
//  TitleManager.swift
//  Start_Show
//
//  Created by Kevin Martinez on 8/18/22.
//

import Foundation


protocol TitleManagerDelegate {
    func didUpdateTitles (_ GenderManager: TitlesManager, titles: TitleModel )
    func titledidFailWithError(error: Error)
}


struct TitlesManager {
    //MARK: - Properties
    
    var delegate: TitleManagerDelegate?
   //MARK: - Methods
    
    func getTitles() {
        // I just call the results for one page from the api becase this is just a example app, if you want you can manipulate the networking call for the titles api and make a pagination to have more results in your title array. 
        let randomPageForTrendingMoviesApi = Int.random(in: 1...10)
        let urlString = "\(K.BaseURLFor.categoryTitles)\(K.ApiKeys.apiKey)&page=\(randomPageForTrendingMoviesApi)"
            perfomeRequest(with: urlString)
    }

    
//Perfome NetworkCalling ( if you want to do the networkcalling using asyng await see topMovieManager file)
    
    func perfomeRequest(with urlString: String) {

        if let url = URL(string: urlString) {
        let session = URLSession (configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
                
                if error != nil {
                    self.delegate?.titledidFailWithError(error: error!)
                }
                
                if let safeData = data {
                    if let titles = self.parsseJson(safeData) {
                        self.delegate?.didUpdateTitles(self, titles: titles)
                    }
                }
            }
            task.resume()
        }
    }
    
  // parsseJoson Method
    
    func parsseJson (_ titleData: Data) -> TitleModel? {
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(TitleData.self, from: titleData)
            let result = decodeData.results
            let titles = TitleModel(titles: result)
            return titles
        } catch {
            self.delegate?.titledidFailWithError(error: error)
            return nil
        }
    }
    
}
