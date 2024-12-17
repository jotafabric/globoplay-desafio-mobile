//
//  DetailsViewModel.swift
//  ChallengeGloboplay
//
//  Created by Josias Fabrício on 17/12/24.
//

import SwiftUI

class DetailsViewModel: ObservableObject {
    @Published var movie: Movie?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func getMovie(from id: Int, completion: @escaping (Result<Movie, Error>) -> Void) {
        let request = APIRequest(
            endpoint: "https://api.themoviedb.org/3/movie/\(id)",
            headers: [
                "Authorization" : "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyMWM5MGRkNmZiYjJjYzAwZDcxODBlZWYyMzZiZDhiOSIsIm5iZiI6MTczNDM3NDA4Ny4zNjUsInN1YiI6IjY3NjA3MmM3MjA3YjQ3OTkxOTQ1MzE4MiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.rHERpfbKp18LUhKQWp95ATz8KDDBahm-L62us7wBGE4"
            ],
            parameters: [
                "language": "pt-BR"
            ]
        )

        Task {
            do {
                let response: Movie = try await NetworkManager.shared.sendRequest(
                    request,
                    responseType: Movie.self
                )
                completion(.success(response))
            } catch {
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }
    }
}
