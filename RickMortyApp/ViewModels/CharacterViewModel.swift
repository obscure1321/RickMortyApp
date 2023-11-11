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
                print("Total: " + String(model.info.pages))
                print("Page result count: " + String(model.results.count))
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
}
