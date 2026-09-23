//
//  MovieDetailsViewModel.swift
//  MDP
//
//  Created by Laasya Priya vemuri on 9/16/26.
//

import Foundation

protocol MovieDetailsViewModelProtocol {
    var imagePath: String? { get }
    var movieTitle: String { get }
    var ratingText: String { get }
    var languageText: String { get }
    var idText: String { get }
    var originalTitleText: String { get }
    var releaseDateText: String { get }
    var genresText: String { get }
    var voteCountText: String { get }
    var popularityText: String { get }
    var adultText: String { get }
    var softcoreText: String { get }
    var videoText: String { get }
    var overviewText: String { get }
}


// MARK: - MovieDetail ViewModel

class MovieDetailsViewModel: MovieDetailsViewModelProtocol {

    // MARK: - Property

    private let movie: Movie

    // MARK: - Initializer

    init(movie: Movie) {
        self.movie = movie
    }

    var imagePath: String? {
        return movie.backdropPath ?? movie.posterPath
    }

    var movieTitle: String {
        return movie.title
    }

    var ratingText: String {
        return "★ \(String(format: "%.1f", movie.voteAverage))"
    }

    var languageText: String {
        return movie.originalLanguage.uppercased()
    }

    var idText: String {
        return "\(Constants.idLabel.rawValue) \(movie.id)"
    }

    var originalTitleText: String {
        return "\(Constants.originalLabel.rawValue) \(movie.originalTitle)"
    }

    var releaseDateText: String {
        return "\(Constants.releaseLabel.rawValue) \(movie.releaseDate)"
    }

    var genresText: String {
        let genreIds = movie.genreIds.map { String($0) }.joined(separator: ", ")
        return "\(Constants.genreLabel.rawValue) \(genreIds)"
    }

    var voteCountText: String {
        return "\(Constants.votesLabel.rawValue) \(movie.voteCount)"
    }

    var popularityText: String {
        let popularity = String(format: "%.1f", movie.popularity)
        return "\(Constants.popularityLabel.rawValue) \(popularity)"
    }

    var adultText: String {
        let value = movie.adult ? Constants.yesLabel.rawValue : Constants.NoLabel.rawValue
        return "\(Constants.adultLabel.rawValue) \(value)"
    }

    var softcoreText: String {
        let value = movie.softcore ? Constants.yesLabel.rawValue : Constants.NoLabel.rawValue
        return "\(Constants.softcoreLabel.rawValue) \(value)"
    }

    var videoText: String {
        let value = movie.video ? Constants.yesLabel.rawValue : Constants.NoLabel.rawValue
        return "\(Constants.videoLabel.rawValue) \(value)"
    }

    var overviewText: String {
        return movie.overview
    }
}

