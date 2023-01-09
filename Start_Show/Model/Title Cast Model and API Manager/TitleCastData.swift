//
//  TitleCastData.swift
//  Start_Show
//
//  Created by Kevin Martinez on 9/11/22.
//

import Foundation

struct TitleCastData: Codable{
    let id: Int
    let cast: [TitleCastResult]
}

struct TitleCastResult: Codable {
    let adult: Bool
    let gender: Int?
    let id: Int
    let known_for_department: String
    let name: String
    let original_name: String
    let popularity: Double
    let profile_path: String?
    let cast_id: Int
    let character: String
    let credit_id: String
    let order: Int
}


