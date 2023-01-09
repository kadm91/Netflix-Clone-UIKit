//
//  TopMovieManager.swift
//  Start_Show
//
//  Created by Kevin Martinez on 8/24/22.
//

import Foundation

//MARK: - TopMovieManagerDelegate Protocol

protocol TopMovieManagerDelegate {
    func didUpdateTopMovie (_ topMovieManager: TopMovieManager, topMovie: TopMovieModel )
    func topMoviedidFailWithError(error: Error)
}

//MARK: - TopMovieManager Model

struct TopMovieManager {
  
    //MARK: - properties
    var delegate: TopMovieManagerDelegate?
   
   //MARK: - Methods
    
    func getTopMovie() {
        let urlString = "\(K.BaseURLFor.topMovie)\(K.ApiKeys.apiKey)"
        Task{
            do {
                guard let topMovies = try await performeRequestWithAsyncAwait(with: urlString) else {return}
                delegate?.didUpdateTopMovie(self, topMovie: topMovies)
            } catch {
                print("errro getting data") // you can create a error enum and administrate how you see more suitable
            }
        }
    }

// Perfome NetworkCalling with async await method
    
    
    func performeRequestWithAsyncAwait(with urlString: String) async throws -> TopMovieModel?  {
        guard let url = URL(string: urlString) else {return nil}
        let (data, _) = try await URLSession.shared.data(from: url)
        guard let topMovieResult = parsseJson(data) else {return nil}
    return topMovieResult
    }
    
// parsseJson mehtod
  
    func parsseJson (_ topMovieData: Data) -> TopMovieModel? {
        
        let decoder = JSONDecoder()
        
        do {
            
            let decodeData = try decoder.decode(TopMovieData.self, from: topMovieData)
            let result = decodeData.results
            let titles = TopMovieModel(topMovie: result)
            return titles
            
        } catch {
            self.delegate?.topMoviedidFailWithError(error: error)
            return nil
        }
    }
}
