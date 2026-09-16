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
    case baseImageUrl = "https://image.tmdb.org/t/p/w500"
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
