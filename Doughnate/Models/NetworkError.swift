//
//  NetworkError.swift
//  TestTask
//
//  Created by Евгений Соболь on 11/16/18.
//  Copyright © 2018 Eugene Sobol. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case client(Error)
    case incorrectResponse
    case unableToParse(Data)
    case statusCode(Int)
}
