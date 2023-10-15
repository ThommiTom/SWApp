//
//  NetworkError.swift
//  SWApp
//
//  Created by Thomas Schatton on 13.10.23.
//

import Foundation

enum NetworkError: String, Error {
    case universalError = "An unkown error occured."
    case unableToComplete = "Unable to complete request.\nCheck Internet Connection."
    case invalidResponse = "Invalid Server Response."
    case invalidStatusCode = "Invalid Status Code."
    case invalidData = "Invalid Data."
    case invalidDecoding = "Cannot decode data."
    case invalidURL = "Invalid URL."
    case failedCreatingURL = "Failed to generate valid URL."
}
