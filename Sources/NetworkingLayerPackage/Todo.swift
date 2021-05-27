//
//  File.swift
//  
//
//  Created by Mouhamed Dieye on 27/05/2021.
//

import Foundation

// Model
struct Todo: Codable {
   var title: String
   var completed: Bool
}
// Request
struct FindTodos: Request {
     typealias ReturnType = [Todo]
     var path: String = "/todos"
}
