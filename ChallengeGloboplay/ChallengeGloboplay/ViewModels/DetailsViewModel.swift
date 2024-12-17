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
}
