//
//  CollectionVIewCellViewModel.swift
//  RickMortyApp
//
//  Created by Miras Maratov on 12.11.2023.
//

import Foundation

final class CollectionVIewCellViewModel {
// MARK: - properties
    public let characterName: String
    public let characterStatus: Status
    public let characterImgUrl: URL?
    
    public var characterStatusText: String {
        return characterStatus.rawValue
    }
    
// MARK: - init
    init(
        characterName: String,
        characterStatus: Status,
        characterImgUrl: URL?
    ) {
        self.characterName = characterName
        self.characterStatus = characterStatus
        self.characterImgUrl = characterImgUrl
    }
    
// MARK: - func to get image
    public func fetchImg(completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = characterImgUrl else {
            completion(.failure(URLError(.badURL)))
            return
        }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            completion(.success(data))
        }
        task.resume()
    }
}
