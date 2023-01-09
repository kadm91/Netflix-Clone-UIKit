//
//  GenderModel.swift
//  Start_Show
//
//  Created by Kevin Martinez on 8/18/22.
//

import Foundation

//struct GenresModel {
//    let genres: [genres]
//}


struct GenreObjectMode {
    
    let name: Name
    let id: Id
    
}


enum Name: String {
     case Action
     case Adventure
     case Animation
     case Comedy
     case Crime
     case Drama
     case Family
     case Fantasy
     case Horror
     case Mystery
     case Romance
     case ScienceFiction = "Science Fiction"
     case Thriller
    
    static var allNames: [Name] = [.Action, .Adventure, .Animation, .Comedy, .Crime, .Drama, .Family, .Fantasy, .Horror, .Mystery, .Romance, .ScienceFiction, .Thriller ]
 }
 
enum Id: Int {
     case Action = 28
     case Adventure = 12
     case Animation = 16
     case Comedy = 35
     case Crime = 80
     case Drama = 18
     case Family = 10751
     case Fantasy = 14
     case Horror = 27
     case Mystery = 9648
     case Romance = 10749
     case ScienceFiction = 878
     case Thriller = 53
     
    static var allIds: [Id] = [.Action, .Adventure, .Animation, .Comedy, .Crime, .Drama, .Family, .Fantasy, .Horror, .Mystery, .Romance, .ScienceFiction, .Thriller ]
 }



struct Genres {
    
    var genres = [GenreObjectMode]()
    
    init() {
           
        let action = GenreObjectMode(name: Name.Action, id: Id.Action)
        let adventure = GenreObjectMode(name: .Adventure, id: .Adventure)
        let animation = GenreObjectMode(name: .Animation, id: .Animation)
        let comedy = GenreObjectMode(name: .Comedy, id: .Comedy)
        let crime = GenreObjectMode(name: .Crime, id: .Crime)
        let drama = GenreObjectMode(name: .Drama, id: .Drama)
        let family = GenreObjectMode(name: .Family, id: .Family)
        let fantasy = GenreObjectMode(name: .Fantasy, id: .Fantasy)
        let horror = GenreObjectMode(name: .Horror, id: .Horror)
        let mystery = GenreObjectMode(name: .Mystery, id: .Mystery)
        let romance = GenreObjectMode(name: .Romance, id: .Romance)
        let scienceFiction = GenreObjectMode(name: .ScienceFiction, id: .ScienceFiction)
        let thriller = GenreObjectMode(name: .Thriller, id: .Thriller)
        
        
        
        genres = [action,adventure, animation, comedy, crime, drama, family, fantasy, horror, mystery, romance, scienceFiction, thriller]
        
    }
    
    
    func extractGenresForMovie(idForMovie: [Int]) -> String {
        
        var gendersStringArray = [String]()
        
        for idForMovie in idForMovie {
            switch idForMovie {
                
            case Id.Action.rawValue:
                gendersStringArray.append(Name.Action.rawValue)
            case Id.Adventure.rawValue:
                gendersStringArray.append(Name.Adventure.rawValue)
            case Id.Animation.rawValue:
                gendersStringArray.append(Name.Animation.rawValue)
            case Id.Comedy.rawValue:
                gendersStringArray.append(Name.Comedy.rawValue)
            case Id.Crime.rawValue:
                gendersStringArray.append(Name.Crime.rawValue)
            case Id.Drama.rawValue:
                gendersStringArray.append(Name.Drama.rawValue)
            case Id.Family.rawValue:
                gendersStringArray.append(Name.Family.rawValue)
            case Id.Fantasy.rawValue:
                gendersStringArray.append(Name.Fantasy.rawValue)
            case Id.Horror.rawValue:
                gendersStringArray.append(Name.Horror.rawValue)
            case Id.Mystery.rawValue:
                gendersStringArray.append(Name.Mystery.rawValue)
            case Id.Romance.rawValue:
                gendersStringArray.append(Name.Romance.rawValue)
            case Id.ScienceFiction.rawValue:
                gendersStringArray.append(Name.ScienceFiction.rawValue)
            case Id.Thriller.rawValue:
                gendersStringArray.append(Name.Thriller.rawValue)
            default:
                break
            }
        }
        
        
        var modifiedStringsArray = [String]()
        
        for i in 0..<gendersStringArray.count{
            if gendersStringArray[i] == gendersStringArray[0] {
                modifiedStringsArray.insert(gendersStringArray[0], at: 0)
            } else {
                let newString =  " • " + gendersStringArray[i]
                modifiedStringsArray.append(newString)
            }
        }
        
        var compounsString = String()
        
        for modifiedString in modifiedStringsArray {
            compounsString += modifiedString
        }
        return compounsString
    }
}

