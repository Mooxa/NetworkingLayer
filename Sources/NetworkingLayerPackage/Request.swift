//
//  Request.swift
//  
//
//  Created by Mouhamed Dieye on 27/05/2021.
//

import Foundation
import Combine
public enum HTTPMethod: String {
    case get     = "GET"
    case post    = "POST"
    case put     = "PUT"
    case delete  = "DELETE"
}
public protocol Request {
    var path: String { get }
    var method: HTTPMethod { get }
    var contentType: String { get }
    var body: [String: Any]? { get }
    var headers: [String: String]? { get }
    associatedtype ReturnType: Codable
}



