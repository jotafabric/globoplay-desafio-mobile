//
//  APIRequest.swift
//  ChallengeGloboplay
//
//  Created by Josias Fabrício on 16/12/24.
//

import Foundation

struct APIRequest {
    let endpoint: String
    let method: HTTPMethod
    let headers: [String: String]?
    let parameters: [String: Any]?
    
    init(endpoint: String, method: HTTPMethod = .get, headers: [String: String]? = nil, parameters: [String: Any]? = nil) {
        self.endpoint = endpoint
        self.method = method
        self.headers = headers
        self.parameters = parameters
    }
    
    func buildURLRequest() -> URLRequest? {
        guard let url = URL(string: endpoint) else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if let headers = headers {
            headers.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }
        }
        
        if let parameters = parameters, method == .post || method == .put {
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        }
        
        return request
    }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum APIError: Error, LocalizedError {
    case invalidRequest
    case invalidResponse
    case decodingError(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidRequest: return "Invalid request."
        case .invalidResponse: return "Invalid response from server."
        case .decodingError(let error): return "Decoding error: \(error.localizedDescription)"
        }
    }
}
