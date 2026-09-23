//
//  ErrorType.swift
//  MDP
//
//  Created by Laasya Priya vemuri on 9/16/26.
//

import Foundation

//MARK: - ErrorTypes

enum ErrorType: Error {
    case networkError
    case invalidURL
    case badServerResponse(statusCode: Int)
    case decodingFailed
}
