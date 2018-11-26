//
//  Requests.swift
//  Doughnate
//
//  Created by Евгений Соболь on 11/26/18.
//  Copyright © 2018 Евгений Соболь. All rights reserved.
//

import Foundation

class Requests {
    
    static func login(email: String, password: String) -> URLRequest {
        let body = ["email": email,
                    "password": password]
        return URLRequest(method: .post,
                          domain: ApiUrl.host,
                          path: ["login/"],
                          body: body)!
    }
    
    static func loginSMS(code: String) -> URLRequest {
        let body = ["code": code]
        return URLRequest(method: .post,
                          domain: ApiUrl.host,
                          path: ["login_sms/"],
                          body: body)!
    }
    
    static func signup(email: String, password: String) -> URLRequest {
        let body = ["email": email,
                    "password": password]
        return URLRequest(method: .post,
                          domain: ApiUrl.host,
                          path: ["signup/"],
                          body: body)!
    }
}
