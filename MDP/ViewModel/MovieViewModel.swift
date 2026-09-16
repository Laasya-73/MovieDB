//
//  MovieViewModel.swift
//  MDP
//
//  Created by Laasya Priya vemuri on 9/15/26.
//

import Foundation

//MARK: - Movie ViewModel Protocol

protocol MovieViewModelProtocol: AnyObject {
    func fetchMoviesFromNetwork(completion: @escaping () -> Void)
    func getTotalMoviesCount() -> Int
    func getMovie(for index: Int) -> Movie?
}

// MARK: - Movie ViewModel

class MovieViewModel: MovieViewModelProtocol {
    private var moviesData: MovieResponse?
    private let objNetwork: NetworkProtocol
    
    init(objNetwork: NetworkProtocol) {
        self.objNetwork = objNetwork
    }
    
    func fetchMoviesFromNetwork(completion: @escaping () -> Void) {
        //let objNetwork: NetworkProtocol = NetworkManager.shared
        objNetwork.fetchMovies(urlString: Constants.movieDBUrl.rawValue) { [weak self] fetchedMovies in
            self?.moviesData = fetchedMovies
            completion()
        }
    }
    
    func getTotalMoviesCount() -> Int {
        return moviesData?.results.count ?? 0
    }
    
    func getMovie(for index: Int) -> Movie? {
        guard let moviesData = moviesData, index < moviesData.results.count else { return nil }
        return moviesData.results[index]
    }
}

/*
 MovieViewModel stores the movie data returned by the network layer. Since the API has not completed when the ViewModel is first created, I keep moviesData as an optional MovieResponse. Once NetworkManager returns the response, the ViewModel stores it and provides that data to the ViewController.
 
 MovieViewModel.fetchMoviesFromNetwork asks the network layer to fetch the movies. When the MovieResponse comes back, the ViewModel stores it in moviesData. Its completion handler does not need to return the response again because the ViewModel already owns that data. The completion simply tells the ViewController that fetching is finished so it can update the UI.
 
 MovieViewModel.fetchMoviesFromNetwork asks the singleton NetworkManager to fetch the movies. When the network layer returns a MovieResponse, the ViewModel stores it in moviesData. I use [weak self] inside the escaping closure to avoid strongly capturing the ViewModel, and then I call the completion handler to notify the ViewController that the fetch has finished.
 
 getTotalMoviesCount() returns the number of movies inside the results array of MovieResponse. Since moviesData may still be nil before the API finishes, I use optional chaining and return 0 as the default.
 
 getMovie(for:) gives the ViewController one movie for a specific row. I first make sure the movie array exists and the index is valid, then I return the movie at that index.
  */

/*
 DI version
 
 MovieViewModel depends on something that follows NetworkProtocol, so instead of creating NetworkManager itself, I receive that dependency through the initializer and store it in objNetwork.
 
 MovieViewModel no longer accesses NetworkManager.shared directly. It receives an object conforming to NetworkProtocol through its initializer, stores that dependency in objNetwork, and uses it to fetch movies. This reduces the ViewModel's dependency on the concrete NetworkManager.
 
 MovieViewModelProtocol defines the behavior that MovieViewController needs from a ViewModel. The controller should depend on this protocol instead of the concrete MovieViewModel, so a real or mock ViewModel can be injected later.
 */
