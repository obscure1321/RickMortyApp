//
//  DetailViewViewModel.swift
//  RickMortyApp
//
//  Created by Miras Maratov on 12.11.2023.
//

import Foundation

final class DetailViewViewModel {
    private let character: CharacterResult
    
    var imageUrl: URL?
    
    init(character: CharacterResult) {
        self.character = character
    }
    
    public var title: String {
        character.name?.uppercased() ?? "Unknown"
    }
}
