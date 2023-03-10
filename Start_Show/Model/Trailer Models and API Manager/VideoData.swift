//
//  VideoData.swift
//  Start_Show
//
//  Created by Kevin Martinez on 8/21/22.
//

import Foundation

struct VideoData: Codable {
    
    let id: Int
    let results: [VideosResults]
}

struct VideosResults: Codable {
    
    let iso_639_1: String
    let iso_3166_1: String
    let name: String
    let key: String
    let site: String
    let size: Int
    let type: String
    let official: Bool
    let published_at: String
    let id: String
    
}
