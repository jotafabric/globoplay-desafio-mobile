//
//  HomeViewModel.swift
//  ChallengeGloboplay
//
//  Created by Josias Fabrício on 16/12/24.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var movies: [Movie]?
    @Published var tvSeries: [TvSerie]?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func fetchMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        let request = APIRequest(
            endpoint: "https://api.themoviedb.org/3/movie/popular",
            headers: [
                "Authorization" : "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyMWM5MGRkNmZiYjJjYzAwZDcxODBlZWYyMzZiZDhiOSIsIm5iZiI6MTczNDM3NDA4Ny4zNjUsInN1YiI6IjY3NjA3MmM3MjA3YjQ3OTkxOTQ1MzE4MiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.rHERpfbKp18LUhKQWp95ATz8KDDBahm-L62us7wBGE4"
            ],
            parameters: [
                "language": "pt-BR",
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
    
    func fetchTvSeries(completion: @escaping (Result<[TvSerie], Error>) -> Void) {
        let request = APIRequest(
            endpoint: "https://api.themoviedb.org/3/tv/popular",
            headers: [
                "Authorization" : "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyMWM5MGRkNmZiYjJjYzAwZDcxODBlZWYyMzZiZDhiOSIsIm5iZiI6MTczNDM3NDA4Ny4zNjUsInN1YiI6IjY3NjA3MmM3MjA3YjQ3OTkxOTQ1MzE4MiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.rHERpfbKp18LUhKQWp95ATz8KDDBahm-L62us7wBGE4"
            ],
            parameters: [
                "language": "pt-BR",
                "page": "1"
            ]
        )

        Task {
            do {
                let response: TvSeriesResponse = try await NetworkManager.shared.sendRequest(
                    request,
                    responseType: TvSeriesResponse.self
                )
                completion(.success(response.results))
            } catch {
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }
    }
}
