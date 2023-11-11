//
//  GetAllCharactersResponse.swift
//  RickMortyApp
//
//  Created by Miras Maratov on 11.11.2023.
//

import Foundation

struct GetAllCharactersResponse: Codable {
    struct Info: Codable {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }
    
    let info: Info
    let results: [CharacterResult]
}
