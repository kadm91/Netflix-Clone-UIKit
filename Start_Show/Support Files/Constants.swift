//
//  Constants.swift
//  Start_Show
//
//  Created by Kevin Martinez on 8/13/22.
//

import Foundation

struct K {
    struct CollectionViewReusableCellIdFor {
        static let categories = "Categories"
        static let topShows = "TopShows"
        static let actors = "actorsCollectionViewCell"
    }
    
    struct TableViewReusableCellIdFor {
        static let topShows = "MoviesCell"
    }
    
    struct ApiKeys {
        static let apiKey = Keys.apiKey
    }
    
    struct segueIdFor {
        static let titleDescriptionView = "TitleDescription"
        static let topMovieDescription = "TopMovieDescription"
        static let playTopMovieTrailerInFullScreen = "PlayTrailerInFullScreen"
    }
    
    struct StoryBoardIdfor {
        static let descriptionVC = "TitleDesacriptionVC"
    }
    
    struct BaseURLFor {
        static let topMovie = "https://api.themoviedb.org/3/movie/top_rated?&language=en-US&page=1&api_key="
        static let categoryTitles = "https://api.themoviedb.org/3/trending/movie/week?&api_key="
        static let cast = "https://api.themoviedb.org/3/movie/"
        static let actorprofile = "https://api.themoviedb.org/3/person/"
        
        static func titlePosterImage(withQuality: imageQuality) -> String {
            
            let baseURL = "https://image.tmdb.org/t/p/"
            
            switch withQuality {
            case .ultraLow:
                return  baseURL+"w92"
            case .superLow:
                return baseURL+"w154"
            case .low:
                return  baseURL+"w185"
            case .medium:
                return baseURL+"w342"
            case .high:
                return baseURL+"w500"
            case .hd:
                return  baseURL+"w780"
            case .superHd:
                return baseURL+"original"
            }
        }
    }
    
    
}


enum imageQuality  {
    case ultraLow
    case superLow
    case low
    case medium
    case high
    case hd
    case superHd
}
