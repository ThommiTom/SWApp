//
//  NetworkingManager.swift
//  SWApp
//
//  Created by Thomas Schatton on 13.10.23.
//

import Foundation

class NetworkManager {
    private init() {}

    static func networkCall<T: Decodable>(with url: URL?, completion: @escaping (Result<T, NetworkError>) -> Void) {
        guard let url = url else {
            completion(.failure(.failedCreatingURL))
            return
        }

        let request = URLRequest(url: url)

        URLSession.shared.dataTask(with: request) { data, urlResponse, error in
            // handle eventual error
            guard error == nil else {
                completion(.failure(.unableToComplete))
                return
            }

            // check url response
            guard let httpResponse = urlResponse as? HTTPURLResponse else {
                completion(.failure(.invalidResponse))
                return
            }

            print("Status Code: \(httpResponse.statusCode) - \(request.url?.absoluteString ?? "URL n/a")")

            // check http status code
            guard (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.invalidStatusCode))
                return
            }

            // check data availability
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }

            // parse data
            NetworkManager.parse(data: data, completion: completion)
        }
        .resume()
    }

    static func networkCall<T: Decodable>(with url: URL?) async throws -> T {
        guard let url = url else { throw NetworkError.failedCreatingURL }

        do {
            let (data, urlResponse) = try await URLSession.shared.data(from: url)

            guard let httpResponse = urlResponse as? HTTPURLResponse else { throw NetworkError.invalidResponse}
            guard (200...299).contains(httpResponse.statusCode) else { throw NetworkError.invalidStatusCode }
            print("Status Code: \(httpResponse.statusCode) - \(url.absoluteString)")

            let result: T = try NetworkManager.parse(data: data)
            return result
        } catch {
            throw error
        }
    }
}

// Parsing helpers!
extension NetworkManager {
    private static func parse<T: Decodable>(data: Data, completion: @escaping (Result<T, NetworkError>) -> Void) {
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decoder.dateDecodingStrategy = .iso8601

            let element: T = try decoder.decode(T.self, from: data)
            completion(.success(element))
        } catch let DecodingError.dataCorrupted(context) {
            print("Data corrupted: \(context)")
            completion(.failure(.invalidDecoding))
        } catch let DecodingError.keyNotFound(key, context) {
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
            completion(.failure(.invalidDecoding))
        } catch let DecodingError.valueNotFound(value, context) {
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
            completion(.failure(.invalidDecoding))
        } catch let DecodingError.typeMismatch(type, context) {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
            completion(.failure(.invalidDecoding))
        } catch {
            print("Unknown error while decoding.")
            completion(.failure(.invalidDecoding))
        }
    }

    private static func parse<T: Decodable>(data: Data) throws -> T {
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decoder.dateDecodingStrategy = .iso8601

            let element: T = try decoder.decode(T.self, from: data)
            return element
        } catch let DecodingError.dataCorrupted(context) {
            print("Data corrupted: \(context)")
            throw DecodingError.dataCorrupted(context)
        } catch let DecodingError.keyNotFound(key, context) {
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
            throw DecodingError.keyNotFound(key, context)
        } catch let DecodingError.valueNotFound(value, context) {
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
            throw DecodingError.valueNotFound(value, context)
        } catch let DecodingError.typeMismatch(type, context) {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
            throw DecodingError.typeMismatch(type, context)
        } catch {
            print("Unknown error while decoding.")
            throw NetworkError.invalidDecoding
        }
    }
}
