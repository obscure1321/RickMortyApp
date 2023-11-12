//
//  DetailViewViewModel.swift
//  RickMortyApp
//
//  Created by Miras Maratov on 12.11.2023.
//

import Foundation

final class DetailViewViewModel {
// MARK: - properties
    private let character: CharacterResult
    
    var imageUrl: URL?
    
    public var title: String {
        character.name?.uppercased() ?? "Unknown"
    }
    
// MARK: - init
    init(character: CharacterResult) {
        self.character = character
    }
}
