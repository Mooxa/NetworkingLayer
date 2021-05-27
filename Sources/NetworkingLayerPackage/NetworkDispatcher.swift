//
//  NetworkDispatcher.swift
//  
//
//  Created by Mouhamed Dieye on 27/05/2021.
//

import Foundation
import Combine

struct NetworkDispatcher {
    let urlSession: URLSession!
    public init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    /// Dispatches an URLRequest and returns a publisher
    /// - Parameter request: URLRequest
    /// - Returns: A publisher with the provided decoded data or an error
    func dispatch<ReturnType: Codable>(request: URLRequest) -> AnyPublisher<ReturnType, NetworkRequestError> {
        return urlSession
            .dataTaskPublisher(for: request)
            // Map on Request response
            .tryMap({ data, response in
                // If the response is invalid, throw an error
                if let response = response as? HTTPURLResponse,
                   !(200...299).contains(response.statusCode) {
                    throw httpError(response.statusCode)
                }
                // Return Response data
                return data
            })
            // Decode data using our ReturnType
            .decode(type: ReturnType.self, decoder: JSONDecoder())
            // Handle any decoding errors
            .mapError { error in
                handleError(error)
            }
            // And finally, expose our publisher
            .eraseToAnyPublisher()
    }
}
