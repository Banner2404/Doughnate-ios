//
//  DoughnateTests.swift
//  DoughnateTests
//
//  Created by Евгений Соболь on 12/21/18.
//  Copyright © 2018 Евгений Соболь. All rights reserved.
//

import XCTest
@testable import Doughnate

class DoughnateTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testUser() {
        let json =
        """
        {
        "id": 12,
        "first_name": "user",
        "last_name": "last",
        "email": "test@gmail.com",
        "two_factor_auth_enabled": true }
        """

        let data = json.data(using: .utf8)!
        let user = try? JSONDecoder().decode(User.self, from: data)
        XCTAssertNotNil(user)
        XCTAssertEqual(user?.id, 12)
        XCTAssertEqual(user?.firstName, "user")
        XCTAssertEqual(user?.lastName, "last")
        XCTAssertEqual(user?.email, "test@gmail.com")
        XCTAssertEqual(user?.isTwoFactorAuthenticationEnabled, true)

    }

    func testToken() {
        let json =
        """
        {
        "token": "testtoken" }
        """

        let data = json.data(using: .utf8)!
        let token = try? JSONDecoder().decode(Token.self, from: data)
        XCTAssertNotNil(token)
        XCTAssertEqual(token?.accessToken, "testtoken")
    }

    func testCreditCard() {
        let json =
        """
        {
        "id": 123,
        "number_last4": "1234",
        "brand": "visa" }
        """

        let data = json.data(using: .utf8)!
        let card = try? JSONDecoder().decode(CreditCard.self, from: data)
        XCTAssertNotNil(card)
        XCTAssertEqual(card?.id, 123)
        XCTAssertEqual(card?.lastFour, "1234")
        XCTAssertEqual(card?.brand.rawValue, CreditCard.Brand.visa.rawValue)

    }

}
