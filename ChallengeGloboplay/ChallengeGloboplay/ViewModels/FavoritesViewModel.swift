//
//  FavoritesViewModel.swift
//  ChallengeGloboplay
//
//  Created by Josias Fabrício on 16/12/24.
//

import SwiftUI

class FavoritesViewModel: ObservableObject {
    @Published var favorites: [Movie]?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func fetchMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        let request = APIRequest(
            endpoint: "https://api.themoviedb.org/3/account/21691755/favorite/movies",
            headers: [
                "Authorization" : NSLocalizedString("auth", comment: "")
            ],
            parameters: [
                "page": "1"
            ]
        )

        Task {
            do {
                let response: MoviesResponse = try await NetworkManager.shared.sendRequest(
                    request,
                    responseType: MoviesResponse.self
                )
                completion(.success(response.results))
            } catch {
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }
    }
}
