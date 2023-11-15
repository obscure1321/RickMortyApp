//
//  CharacterViewModel.swift
//  RickMortyApp
//
//  Created by Miras Maratov on 11.11.2023.
//

import UIKit

// MARK: - custom protocol
protocol CharacterViewModelProtocol: AnyObject {
    func didLoadInitialCharacters()
    func didSelectCharacter(_ character: CharacterResult)
}

final class CharacterViewModel {
    // MARK: - properties
    weak var delegate: CharacterViewModelProtocol?
    
    var characters: [CharacterResult] = [] {
        didSet{
            for character in characters {
                let viewModel = CollectionVIewCellViewModel(
                    characterName: character.name ?? "Unknown",
                    characterStatus: character.status ?? .unknown,
                    characterImgUrl: URL(string: character.image ?? "https://rickandmortyapi.com/api/character/avatar/24.jpeg")
                )
                cellViewModels.append(viewModel)
            }
        }
    }
    
    var cellViewModels: [CollectionVIewCellViewModel] = []
    
    // MARK: - func to get data
    func fetchCharacters() {
        RickMortyService.shared.execute(.listCharacters,
                                        expecting: GetAllCharactersResponse.self
        ) { [ weak self ] result in
            switch result {
            case .success(let responseModel):
                let results = responseModel.results
                self?.characters = results
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialCharacters()
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
}
