//
//  TitleData.swift
//  Start_Show
//
//  Created by Kevin Martinez on 8/18/22.
//

import Foundation

struct TitleData: Codable {
    let results: [TitleResults]
}

struct TitleResults: Codable {
    
    let poster_path: String?
    let adult: Bool
    let overview: String
    let release_date: String?
    let genre_ids: [Int]
    let id: Int
    let original_title: String?
    let title: String?
    let backdrop_path: String?
    let popularity: Double
    let vote_count: Int
    let video: Bool?
    let vote_average: Double
    let original_language: String
    let media_type: String
    let first_air_date: String?
    let name: String?
    let original_name: String?
    
}
