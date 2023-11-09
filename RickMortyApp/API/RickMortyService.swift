//
//  RickMortyService.swift
//  RickMortyApp
//
//  Created by Miras Maratov on 09.11.2023.
//

import Foundation


/// Основной объект для получения данных с API
final class RickMortyService {
    
    /// Cинглтон
    static let shared = RickMortyService()
    
    /// приватный инициализатор
    private init() {}
    
    /// Запрос в API
    /// - Parameters:
    ///   - request: экземпляр запроса
    ///   - completion: ответ с данными или ошибкой
    public func execute(_ request: RickMortyRequest, completion: @escaping () -> Void) {
        
    }
}