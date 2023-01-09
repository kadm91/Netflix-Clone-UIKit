//
//  VideoManager.swift
//  Start_Show
//
//  Created by Kevin Martinez on 8/21/22.
//

import Foundation

import Foundation



protocol VideoManagerDelegate {
    func didUpdateVideos (_ GenderManager: VideoManager, videos: VideoModel )
    func titledidFailWithError(error: Error)
}


struct VideoManager {
    
    var delegate: VideoManagerDelegate?
   
    let baseURL = "https://api.themoviedb.org/3/movie/"
    
    func getVideos(videoId: Int ) {
  
            let urlString = "\(baseURL)\(videoId)/videos?api_key=\(K.ApiKeys.apiKey)&language=en-US"
            perfomeRequest(with: urlString)
    }

    
    //MARK: - Perfome NetworkCalling
    
    func perfomeRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession (configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                
                if error != nil {
                    self.delegate?.titledidFailWithError(error: error!)
                }
                
                
                if let safeData = data {
                    if let videos = self.parsseJson(safeData) {
                        self.delegate?.didUpdateVideos(self, videos: videos)
                    }
                }
            }
            task.resume()
        }
    }
    
  
    func parsseJson (_ videosData: Data) -> VideoModel? {
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(VideoData.self, from: videosData)
            let result = decodeData.results
            let videos = VideoModel(videoResults: result)            
            return videos
        } catch {
            self.delegate?.titledidFailWithError(error: error)
            return nil
        }
        
    }
    
    
}
