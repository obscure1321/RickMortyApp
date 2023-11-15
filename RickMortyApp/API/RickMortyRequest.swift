//
//  RickMortyRequest.swift
//  RickMortyApp
//
//  Created by Miras Maratov on 09.11.2023.
//

import Foundation

final class RickMortyRequest {
    private struct Constants {
        static let mainURL = "https://rickandmortyapi.com/api"
    }
    
    private let endpoint: RickMortyEndpoint
    
    private let pathComponents: [String]
    
    private let queryParameters: [URLQueryItem]
    
    private var urlString: String {
        var string = Constants.mainURL
        string += "/"
        string += endpoint.rawValue
        
        if !pathComponents.isEmpty {
            pathComponents.forEach ({
                string += "/\($0)"
            })
        }
        
        if !queryParameters.isEmpty {
            string += "?"
            let argumentString = queryParameters.compactMap({
                guard let value = $0.value else { return nil }
                return "\($0.name)=\(value)"
            }).joined(separator: "&")
            
            string += argumentString
        }
        
        return string
    }
    
    public var url: URL? {
        return URL(string: urlString)
    }
    
    public let httpMethod = "GET"
    
    init(
        endpoint: RickMortyEndpoint,
        pathComponents: [String] = [],
        queryParameters: [URLQueryItem] = []
    ) {
        self.endpoint = endpoint
        self.pathComponents = pathComponents
        self.queryParameters = queryParameters
    }
}

extension RickMortyRequest {
    static let listCharacters = RickMortyRequest(endpoint: .character)
}
