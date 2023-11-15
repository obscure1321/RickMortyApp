//
//  Episodes.swift
//  RickMortyApp
//
//  Created by Miras Maratov on 08.11.2023.
//

import Foundation

struct EpisodeResult: Codable {
    let id: Int?
    let name, airDate, episode: String?
    let characters: [String]?
    let url: String?
    let created: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case airDate = "air_date"
        case episode, characters, url, created
    }
}
