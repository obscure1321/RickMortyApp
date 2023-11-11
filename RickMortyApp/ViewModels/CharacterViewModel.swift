//
//  CharacterViewModel.swift
//  RickMortyApp
//
//  Created by Miras Maratov on 11.11.2023.
//

import Foundation

struct CharacterViewModel {
    func fetchCharacters() {
        RickMortyService.shared.execute(.listCharacters,
                                        expecting: GetAllCharactersResponse.self) { result in
            switch result {
            case .success(let model):
                print("Example image url: " + String(model.results.first?.image ?? "No image"))
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
}
