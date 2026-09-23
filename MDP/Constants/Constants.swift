//
//  Constants.swift
//  MDP
//
//  Created by Laasya Priya vemuri on 9/15/26.
//

import Foundation

enum Constants : String {
    case movieDBUrl = "https://api.themoviedb.org/3/discover/movie?api_key=c91ed3a7a344459eccad9687acf0d07e"
    case movieCell = "Movie Cell"
    case ratingLabel = "Rating:"
    case defaultImage = "photo"
    case moviesDBTitle = "MoviesDB"
    case movieDetailsTitle = "Movie Details"
    case runtimeLabel = "Runtime:"
    case dateLabel = "Date:"
    case languageLabel = "Language:"
    case genreLabel = "Genre IDs:"
    case overviewLabel = "Overview"
    case idLabel = "ID:"
    case originalLabel = "Original Title:"
    case originalLangLabel = "Original Language:"
    case votesLabel = "Votes:"
    case popularityLabel = "Popularity:"
    case releaseLabel = "Release Date:"
    case adultLabel = "Adult:"
    case softcoreLabel = "Softcore:"
    case videoLabel = "Video:"
    case statusLabel = "Status"
    case movieInfoLabel = "Movie Information"
    case searchLabel = "Search Movies"
    case yesLabel = "Yes"
    case NoLabel = "No"
    case errorLabel = "Error"
    case okLabel = "OK"
}


/*
 The app starts from MovieViewController. In viewDidLoad, the ViewController asks MovieViewModel to fetch movies. The ViewModel calls the singleton NetworkManager, which uses URLSession to fetch the JSON and JSONDecoder to convert it into MovieResponse. The ViewModel stores that response and notifies the ViewController through a completion handler. The ViewController reloads the table on the main thread. The table asks the ViewModel for the movie count and each individual movie, and MovieCell displays that movie's title, rating, and poster.
 
 DI Version
 
 SceneDelegate creates and connects the dependencies. NetworkManager conforms to NetworkProtocol and handles API fetching and JSON decoding. MovieViewModel receives the network dependency, stores the fetched MovieResponse, and provides movie data to the ViewController. MovieViewController receives something conforming to MovieViewModelProtocol, so it can work with either the real ViewModel or MockMovieViewModel without changing its implementation.
 
 protocol = what I need
 class = how it is done
 initializer = how dependency enters
 SceneDelegate = where everything is connected
 Mock = fake implementation for testing
*/
