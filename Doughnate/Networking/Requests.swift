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
    
    static func forgotPassword(email: String) -> URLRequest {
        let body = ["email": email]
        return URLRequest(method: .post,
                          domain: ApiUrl.host,
                          path: ["forgot_password/"],
                          body: body)!
    }
    
    static func changePassword(old: String, new: String) -> URLRequest {
        let body = ["old": old, "new": new]
        return URLRequest(method: .post,
                          domain: ApiUrl.host,
                          path: ["change_password/"],
                          body: body)!
    }
    
    static func update(_ user: User, token: String) -> URLRequest {
        let body = try! JSONEncoder().encode(user)
        return URLRequest(method: .put,
                          domain: ApiUrl.host,
                          path: ["users", "\(user.id)/"],
                          body: body,
                          token: token)!
    }
    
    static func getProjects() -> URLRequest {
        return URLRequest(method: .get,
                          domain: ApiUrl.host,
                          path: ["projects/"])!
    }
}
