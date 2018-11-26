//
//  Response.swift
//  TestTask
//
//  Created by Евгений Соболь on 11/16/18.
//  Copyright © 2018 Eugene Sobol. All rights reserved.
//

import Foundation

enum Response<T: Decodable, E: Error> {
    case success(T)
    case failure(E)
}

typealias ResponseCompletion<T: Decodable, E: Error> = (Response<T, E>) -> Void
