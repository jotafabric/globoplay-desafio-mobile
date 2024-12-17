//
//  TvSeries.swift
//  ChallengeGloboplay
//
//  Created by Josias Fabrício on 17/12/24.
//

import Foundation

struct TvSeriesResponse: Codable {
    let page: Int
    let results: [TvSerie]
}

struct TvSerie: Identifiable, Codable, Equatable {
    let id: Int
    let name: String
    let posterPath: String?
    let backdropPath: String?
    let overview: String
    let releaseDate: String
    
    var backdropURL: URL? {
        let baseURL = URL(string: "https://image.tmdb.org/t/p/w300")!
        guard let backdropPath else { return nil }
        return baseURL.appending(path: backdropPath)
    }
    
    var posterUrl: URL? {
        let posterUrl = URL(string: "https://image.tmdb.org/t/p/w100")!
        guard let posterPath else { return nil }
        return posterUrl.appending(path: posterPath)
    }
    
    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case id, name, overview
    }
}

