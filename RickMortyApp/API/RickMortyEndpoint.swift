//
//  RickMortyEndpoint.swift
//  RickMortyApp
//
//  Created by Miras Maratov on 09.11.2023.
//

import Foundation


/// Конечный результат запроса
@frozen enum RickMortyEndpoint: String {
    case character
    case location
    case episodes
}
