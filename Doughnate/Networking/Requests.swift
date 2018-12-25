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
    
    static func changePassword(old: String, new: String, token: String) -> URLRequest {
        let body = ["current_password": old, "new_password": new]
        return URLRequest(method: .post,
                          domain: ApiUrl.host,
                          path: ["change-password/"],
                          body: body,
                          token: token)!
    }
    
    static func update(userId: Int, firstName: String, lastName: String, token: String) -> URLRequest {
        let body = ["first_name": firstName,
                    "last_name": lastName]
        return URLRequest(method: .put,
                          domain: ApiUrl.host,
                          path: ["profiles", "\(userId)/"],
                          body: body,
                          token: token)!
    }
    
    static func enableTwoFactorAuth(userId: Int, phone: String, token: String) -> URLRequest {
        let body: [String: Any] = [
                    "two_factor_auth_enabled": true]
        return URLRequest(method: .post,
                          domain: ApiUrl.host,
                          path: ["change-two-factor/"],
                          body: body,
                          token: token)!
    }

    static func update(phone: String, userId: Int, token: String) -> URLRequest {
        let body: [String: Any] = [
            "phone": phone]
        return URLRequest(method: .put,
                          domain: ApiUrl.host,
                          path: ["profiles", "\(userId)/"],
                          body: body,
                          token: token)!
    }
    
    static func disableTwoFactorAuth(userId: Int, token: String) -> URLRequest {
        let body: [String: Any] = ["two_factor_auth_enabled": false]
        return URLRequest(method: .post,
                          domain: ApiUrl.host,
                          path: ["change-two-factor/"],
                          body: body,
                          token: token)!
    }

    static func confirmTwoFactor(code: String, token: String) -> URLRequest {
        let body: [String: Any] = ["code": code]
        return URLRequest(method: .post,
                          domain: ApiUrl.host,
                          path: ["confirm-two-factor/"],
                          body: body,
                          token: token)!
    }
    
    static func getProjects(token: String?) -> URLRequest {
        return URLRequest(method: .get,
                          domain: ApiUrl.host,
                          path: ["projects/"],
                          token: token)!
    }

    static func getProject(id: Int, token: String?) -> URLRequest {
        return URLRequest(method: .get,
                          domain: ApiUrl.host,
                          path: ["projects/\(id)/"],
                          token: token)!
    }
    
    static func report(projectId: Int, message: String) -> URLRequest {
        let body: [String: Any] =
            ["project_id": projectId,
            "text": message]
        return URLRequest(method: .post,
                          domain: ApiUrl.host,
                          path: ["report/"],
                          body: body)!
    }
    
    static func subscribe(projectId: Int, subscriptionId: Int, token: String) -> URLRequest {
        let body: [String: Any] =
            ["subscription_plan_id": subscriptionId]
        return URLRequest(method: .post,
                          domain: ApiUrl.host,
                          path: ["projects", String(projectId), "subscribe/"],
                          body: body,
                          token: token)!
    }

    static func unsubscribe(projectId: Int, token: String) -> URLRequest {
        return URLRequest(method: .post,
                          domain: ApiUrl.host,
                          path: ["projects", String(projectId), "unsubscribe/"],
                          token: token)!
    }

    static func getCards(token: String) -> URLRequest {
        return URLRequest(method: .get,
                          domain: ApiUrl.host,
                          path: ["cards/"],
                          token: token)!
    }

    static func addCard(stripeToken: String, token: String) -> URLRequest {
        let body = ["stripeToken": stripeToken]
        return URLRequest(method: .post,
                          domain: ApiUrl.host,
                          path: ["cards", "tokenize/"],
                          body: body,
                          token: token)!
    }

    static func deleteCard(id: Int, token: String) -> URLRequest {
        return URLRequest(method: .delete,
                          domain: ApiUrl.host,
                          path: ["cards", String(id) + "/"],
                          token: token)!
    }

    static func getSubscriptions(token: String) -> URLRequest {
        return URLRequest(method: .get,
                          domain: ApiUrl.host,
                          path: ["user-sub-projects/"],
                          token: token)!
    }
}
