//
//  Response.swift
//  TestTask
//
//  Created by Евгений Соболь on 11/16/18.
//  Copyright © 2018 Eugene Sobol. All rights reserved.
//

import Foundation

enum Response<T, E: Error> {
    case success(T)
    case failure(E)
}

enum SimpleResponse<E: Error> {
    case success
    case failure(E)
}


typealias ResponseCompletion<T, E: Error> = (Response<T, E>) -> Void
typealias SimpleResponseCompletion<E: Error> = (SimpleResponse<E>) -> Void
