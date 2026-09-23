//
//  NetworkManager.swift
//  MDP
//
//  Created by Laasya Priya vemuri on 9/15/26.
//

import Foundation

/*
 Problem Statement: Error Handling different scenarios
 - Blank or Incorrect URL -> Unable to retrieve the data, Please try again! -> OK button
 - The server is down -> Server is down, Please try again!
 - Unable to parse -> Unable to convert retrieved data
 */

enum APIState <T> {
    case success(T)
    case failure(APIError)
}

enum APIError: String {
    case incorrectURL = "Unable to retrieve the data, Please try again!"
    case serverDown = "Server is down, Please try again!"
    case unableToParse = "Unable to convert retrieved data"
}

protocol NetworkProtocol {
    //func fetchMovies(urlString: String, completion: @escaping (MovieResponse?) -> Void)
    func fetchMovies(urlString: String) async -> (APIState<MovieResponse>)
}

class NetworkManager: NetworkProtocol {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchMovies(urlString: String) async -> (APIState<MovieResponse>) {
        guard let serverURL = URL(string: urlString) else {
            return .failure(.incorrectURL)
        }
        
        let request = URLRequest(url:serverURL)
        
        do {
            let (jsonData, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                // The server is down
                return .failure(.serverDown)
            }
            
            let moviesResponse = try JSONDecoder().decode(MovieResponse.self, from: jsonData)
            return .success(moviesResponse)
        } catch {
            print("Log:: Unable to convert retrieved data")
            return .failure(.unableToParse)
        }
    }
}

/*
 NetworkManager is a singleton. fetchMovies receives the API URL and returns the parsed MovieResponse asynchronously through a completion handler. I first convert the URL string into a URL, create a URLRequest, use URLSession to fetch the data, handle networking errors and missing data, decode the JSON into MovieResponse using JSONDecoder, and finally pass the result through the completion handler.
 
 
 The completion handler or completion means the asynchronous operation has finished and the caller is being notified of the result.
 
 Whenever my asynchronous function uses a completion handler or completion, I should try to call that completion on every possible path, whether the operation succeeds or fails, so the caller always receives a result and knows the asynchronous work has finished.
 */

/*
 DI Version
 
 NetworkProtocol defines the networking behavior required by the application. NetworkManager conforms to that protocol and provides the actual implementation using URLSession. By depending on the protocol instead of directly depending on NetworkManager, I can later inject different networking implementations without changing the ViewModel.
 
 */
