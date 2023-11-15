//
//  RickMortyService.swift
//  RickMortyApp
//
//  Created by Miras Maratov on 09.11.2023.
//

import Foundation

final class RickMortyService {
    
    static let shared = RickMortyService()
    
    private init() {}
    
    enum ServiceError: Error {
        case failedRequest
        case failedData
    }
    
    public func execute<T: Codable>(
        _ request: RickMortyRequest,
        expecting type: T.Type,
        completion: @escaping (Result<T, Error>
        ) -> Void) {
        guard let urlRequest = self.request(from: request) else {
            completion(.failure(ServiceError.failedRequest))
            return }
        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? ServiceError.failedData))
                return
            }
            do{
                let result = try JSONDecoder().decode(type.self, from: data)
                completion(.success(result))
            }
            catch{
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    private func request(from rmRequest: RickMortyRequest) -> URLRequest? {
        guard let url = rmRequest.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = rmRequest.httpMethod
        return request
    }
}
