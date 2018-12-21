//
//  UserManagerTests.swift
//  DoughnateTests
//
//  Created by Евгений Соболь on 12/21/18.
//  Copyright © 2018 Евгений Соболь. All rights reserved.
//

import XCTest
@testable import Doughnate

class UserManagerTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAuthentication() {
        let user = User(firstName: "first", lastName: "last", email: "email")
        let token = Token(accessToken: "token")
        let account = Account(user: user, token: token)
        UserManager.shared.authenticate(with: account)
        XCTAssertTrue(UserManager.shared.isAuthenticated)
        XCTAssertEqual(UserManager.shared.user?.email, user.email)
        XCTAssertEqual(UserManager.shared.user?.lastName, user.lastName)
        XCTAssertEqual(UserManager.shared.user?.firstName, user.firstName)
        XCTAssertEqual(UserManager.shared.token?.accessToken, token.accessToken)
    }

    func testUnauthentication() {
        let user = User(firstName: "first", lastName: "last", email: "email")
        let token = Token(accessToken: "token")
        let account = Account(user: user, token: token)
        UserManager.shared.authenticate(with: account)
        UserManager.shared.unauthenticate()
        XCTAssertFalse(UserManager.shared.isAuthenticated)
        XCTAssertNil(UserManager.shared.user)
        XCTAssertNil(UserManager.shared.token)

    }

    func testUpdateUser() {
        let user1 = User(firstName: "first", lastName: "last", email: "email")
        let user2 = User(firstName: "first2", lastName: "last3", email: "email4")

        let token = Token(accessToken: "token")
        let account = Account(user: user1, token: token)
        UserManager.shared.authenticate(with: account)
        UserManager.shared.update(user2)
        XCTAssertTrue(UserManager.shared.isAuthenticated)
        XCTAssertEqual(UserManager.shared.user?.email, user2.email)
        XCTAssertEqual(UserManager.shared.user?.lastName, user2.lastName)
        XCTAssertEqual(UserManager.shared.user?.firstName, user2.firstName)
        XCTAssertEqual(UserManager.shared.token?.accessToken, token.accessToken)

    }
}
