//
//  Movie.swift
//  MDP
//
//  Created by Laasya Priya vemuri on 9/15/26.
//

import Foundation

nonisolated struct MovieResponse: Decodable {
    let page: Int
    let results: [Movie]
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

nonisolated struct Movie: Decodable {
    let adult: Bool
    let backdropPath: String?
    let genreIds: [Int]
    let id: Int
    let title: String
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let popularity: Double
    let posterPath: String?
    let releaseDate: String
    let softcore: Bool
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
        case id
        case title
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case releaseDate =  "release_date"
        case softcore
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

/*
 MovieResponse represents the complete JSON response returned by the movie API. It contains the page information, the array of movies, and the total page and result counts. Each individual movie inside the results array is represented by the Movie struct. Both structs conform to Decodable so JSONDecoder can convert the JSON data into Swift objects.
 
 I use CodingKeys whenever the JSON key uses snake_case, like poster_path or vote_average, but my Swift property uses camelCase, like posterPath or voteAverage. Optional properties such as posterPath and backdropPath are used because the API may return null for those values.`

MovieResponse = complete API response
Movie = one movie inside results
Decodable = JSON → Swift model
CodingKeys = JSON name != Swift name
Optional = API may return null

*/
