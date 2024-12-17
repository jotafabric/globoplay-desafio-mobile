//
//  NetworkManager.swift
//  ChallengeGloboplay
//
//  Created by Josias Fabrício on 16/12/24.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    func sendRequest<T: Decodable>(
        _ request: APIRequest,
        responseType: T.Type
    ) async throws -> T {
        guard let urlRequest = request.buildURLRequest() else {
            throw APIError.invalidRequest
        }
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw APIError.invalidResponse
        }
        
        do {
            let decodedObject = try JSONDecoder().decode(T.self, from: data)
            return decodedObject
        } catch {
            throw APIError.decodingError(error)
        }
    }
}
