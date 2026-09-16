//
//  MockMovieViewModel.swift
//  MDP
//
//  Created by Laasya Priya vemuri on 9/16/26.
//

import Foundation

//MARK: - Mock ViewModel

class MockMovieViewModel: MovieViewModelProtocol {
    
    // MARK: - Properties
    
    private var moviesData: MovieResponse?

    //MARK: - Fetch From The Network
    
    func fetchMoviesFromNetwork(completion: @escaping () -> Void) {
        let mockMovie: Movie = Movie(backdropPath: nil, id: 42, title: "Spider Man Homecoming", originalLanguage: "EN", overview: "", popularity: 8.9, posterPath: nil, releaseDate: "2026", softcore: false, video: true, voteAverage: 9.4, voteCount: 1200)
        let fetchedMovies = MovieResponse(page: 1, results: [mockMovie], totalPages: 1, totalResults: 1)
        moviesData = fetchedMovies
        completion()
    }
    
    //MARK: - Helper Functions
    
    func getTotalMoviesCount() -> Int {
        moviesData?.results.count ?? 0
    }
    
    func getMovie(for index: Int) -> Movie? {
        guard let moviesData = moviesData, index < moviesData.results.count else { return nil }
        return moviesData.results[index]
    }
}

/*
 MockMovieViewModel is a fake implementation of MovieViewModelProtocol. It provides predefined movie data without calling the network, so I can test MovieViewController independently of the real API. Because the ViewController depends on the protocol, I can inject either the real ViewModel or the mock without changing the ViewController.
 
 MockMovieViewModel creates fake movie data instead of calling the API. I create a mock Movie, place it inside the results array of a mock MovieResponse, store that response in moviesData, and call completion immediately because there is no asynchronous network operation. The remaining methods return the fake data in the same way as the real ViewMode.
 */
