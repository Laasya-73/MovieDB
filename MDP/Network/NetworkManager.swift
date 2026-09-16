//
//  NetworkManager.swift
//  MDP
//
//  Created by Laasya Priya vemuri on 9/15/26.
//

import Foundation

protocol NetworkProtocol {
    func fetchMovies(urlString: String, completion: @escaping (MovieResponse?) -> Void)
}

class NetworkManager: NetworkProtocol {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchMovies(urlString: String, completion: @escaping (MovieResponse?) -> Void) {
        guard let serverURL = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        let request = URLRequest(url: serverURL)
        URLSession.shared.dataTask(with: request) {data, response, error in
            if let error = error {
                print("Failed to fetch movies: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let jsonData = data else {
                completion(nil)
                return
            }
            
            do {
                let moviesData = try JSONDecoder().decode(MovieResponse.self, from: jsonData)
                completion(moviesData)
                return
            } catch {
                print("Failed to parse: \(error)")
                completion(nil)
                return
            }
        } .resume()
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
