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
    private var apiErrorState: APIError?
    
    private var filteredMovies: [Movie] = []
    private var isSearching: Bool = false
    private var displayedMovies: [Movie] {
        if isSearching {
            return filteredMovies
        }
        return moviesData?.results ?? []
    }

    //MARK: - Fetch From The Network
    
    func fetchMoviesFromNetwork() async {
        let spiderMan = Movie(
            adult: false,
            backdropPath: "/qeQJx07rK2xm8SD2sJxFKhE7gs0.jpg",
            genreIds: [878, 28, 12],
            id: 969681,
            title: "Spider-Man: Brand New Day",
            originalLanguage: "en",
            originalTitle: "Spider-Man: Brand New Day",
            overview: "Fighting crime full-time as Spider-Man in a world that doesn't remember him—and the pressure of seeing his old friends move on without him—sparks a change in Peter Parker he may not have the power to control. But that transformation might also be the only thing that can stop a shocking new threat to the city and those he loves - a powerful villain no one can even see.",
            popularity: 691.7198,
            posterPath: "/bjiS5ipwxb9JFy3XRRN4OAilSeX.jpg",
            releaseDate: "2026-07-29",
            softcore: false,
            video: false,
            voteAverage: 7.85,
            voteCount: 2719
        )
        
        let coyoteVsAcme = Movie(
            adult: false,
            backdropPath: "/7GOW6jod9lLurW5utokAatxg7ql.jpg",
            genreIds: [35, 12, 10751],
            id: 1204680,
            title: "Coyote vs. Acme",
            originalLanguage: "en",
            originalTitle: "Coyote vs. Acme",
            overview: "After Acme products fail him one too many times in his dogged pursuit of the Roadrunner, Wile E. Coyote decides to hire a billboard lawyer to sue the Acme Corporation.",
            popularity: 539.7588,
            posterPath: "/vhv7lBWYM0DUuNU2a0V7Rhq21dD.jpg",
            releaseDate: "2026-08-20",
            softcore: false,
            video: false,
            voteAverage: 7.583,
            voteCount: 409
        )
        
        let colony = Movie(
            adult: false,
            backdropPath: "/hpBGCnzOvdtQoMyE48gvwp2y5yx.jpg",
            genreIds: [28, 27, 878],
            id: 1375646,
            title: "Colony",
            originalLanguage: "ko",
            originalTitle: "군체",
            overview: "Professor Se-jeong is thrust into a bloody nightmare when a rapidly mutating virus is released during a biotech conference causing authorities to seal the facility. Trapped inside with no escape, Se-jeong along with a small group of survivors must fight to stay alive while the infected undergo horrific transformations.",
            popularity: 399.4395,
            posterPath: "/tN799oUR0f1gUKDYdMNrDaY7I51.jpg",
            releaseDate: "2026-05-21",
            softcore: false,
            video: false,
            voteAverage: 8.094,
            voteCount: 800
        )
        
        let fetchedMovies = MovieResponse(
            page: 1,
            results: [
                spiderMan,
                coyoteVsAcme,
                colony
            ],
            totalPages: 1001,
            totalResults: 20001
        )
        moviesData = fetchedMovies
        apiErrorState = nil
    }
    
    //MARK: - Helper Functions
    
    func getTotalMoviesCount() -> Int {
        displayedMovies.count
    }
    
    func getMovie(for index: Int) -> Movie? {
        guard index >= 0, index < displayedMovies.count else {
            return nil
        }
        return displayedMovies[index]
    }
    
    func searchMovies(with searchText: String) {
        let trimmedText = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedText.isEmpty else {
            clearSearch()
            return
        }
        
        isSearching = true
        let movies = moviesData?.results ?? []
        filteredMovies = movies.filter { movie in
            movie.title.localizedCaseInsensitiveContains(trimmedText)
        }
    }
    
    func clearSearch() {
        isSearching = false
        filteredMovies.removeAll()
    }
    
    func isAPIThrownError() -> Bool {
        guard let _ = apiErrorState else {
            return false
        }
        return true
    }
    
    func getErrorMessage() -> String {
        apiErrorState?.rawValue ?? ""
    }
}

/*
 MockMovieViewModel is a fake implementation of MovieViewModelProtocol. It provides predefined movie data without calling the network, so I can test MovieViewController independently of the real API. Because the ViewController depends on the protocol, I can inject either the real ViewModel or the mock without changing the ViewController.
 
 MockMovieViewModel creates fake movie data instead of calling the API. I create a mock Movie, place it inside the results array of a mock MovieResponse, store that response in moviesData, and call completion immediately because there is no asynchronous network operation. The remaining methods return the fake data in the same way as the real ViewMode.
 */
