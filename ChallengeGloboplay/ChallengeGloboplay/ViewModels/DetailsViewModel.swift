//
//  DetailsViewModel.swift
//  ChallengeGloboplay
//
//  Created by Josias Fabrício on 17/12/24.
//

import SwiftUI

class DetailsViewModel: ObservableObject {
    @Published var movieDetails: MovieDetails?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func getMovie(from id: Int, completion: @escaping (Result<MovieDetails, Error>) -> Void) {
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)")!
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        let queryItems: [URLQueryItem] = [
          URLQueryItem(name: "language", value: "pt-BR"),
        ]
        components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems

        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
          "accept": "application/json",
          "Authorization":  NSLocalizedString("auth", comment: "")
        ]

        Task {
            do {
                let (data, _) = try await URLSession.shared.data(for: request)
                let movie = try JSONDecoder().decode(MovieDetails.self, from: data)
                
                completion(.success(movie))
            } catch {
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }
    }
    
    func addFavorite(id: Int, completion: @escaping (Result<Bool, Error>) -> Void) async {
        let parameters = [
          "media_type": "movie",
          "media_id": id,
          "favorite": true
        ] as [String : Any?]

        do {
            let postData = try JSONSerialization.data(withJSONObject: parameters, options: [])
            
            let url = URL(string: "https://api.themoviedb.org/3/account/21691755/favorite")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.timeoutInterval = 10
            request.allHTTPHeaderFields = [
                "accept": "application/json",
                "content-type": "application/json",
                "Authorization":  NSLocalizedString("auth", comment: "")
            ]
            request.httpBody = postData
            let (_, _) = try await URLSession.shared.data(for: request)
            completion(.success(true))
        } catch {
            print(error.localizedDescription)
            completion(.failure(error))
        }
    }
}
