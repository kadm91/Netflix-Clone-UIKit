//
//  TitleCastManager.swift
//  Start_Show
//
//  Created by Kevin Martinez on 9/11/22.
//

import Foundation

//MARK: - TopMovieManagerDelegate Protocol

protocol CastManagerDelegate {
    func didUpdateCast (_ topMovieManager: CastManager, cast: TitleCastModel )
    func castFailWithError(error: Error)
}

//MARK: - TopMovieManager Model

struct CastManager{
  
    //MARK: - properties
    var delegate: CastManagerDelegate?
   
   //MARK: - Methods
    
    func getcast(for movieId: Int) {
        
        let urlString = "\(K.BaseURLFor.cast)/\(movieId)/credits?api_key=\(K.ApiKeys.apiKey)&language=en-US"
        Task{
            do {
                guard let cast = try await performeRequestWithAsyncAwait(with: urlString) else {return}
                delegate?.didUpdateCast(self, cast: cast)
            } catch {
                print("errro getting data") // you can create a error enum and administrate how you see more suitable
            }
        }
    }

// Perfome NetworkCalling with async await method
    
    
    func performeRequestWithAsyncAwait(with urlString: String) async throws -> TitleCastModel?  {
        guard let url = URL(string: urlString) else {return nil}
        let (data, _) = try await URLSession.shared.data(from: url)
        guard let topMovieResult = parsseJson(data) else {return nil}
    return topMovieResult
    }
    
// parsseJson mehtod
  
    func parsseJson (_ castData: Data) -> TitleCastModel? {
        
        let decoder = JSONDecoder()
        
        do {
            
            let decodeData = try decoder.decode(TitleCastData.self, from: castData)
            let result = decodeData.cast
            let titles = TitleCastModel(titleCast: result)
            return titles
            
        } catch {
            self.delegate?.castFailWithError(error: error)
            return nil
        }
    }
}


