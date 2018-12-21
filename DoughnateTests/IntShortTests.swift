//
//  IntShortTests.swift
//  DoughnateTests
//
//  Created by Евгений Соболь on 12/21/18.
//  Copyright © 2018 Евгений Соболь. All rights reserved.
//

import XCTest
@testable import Doughnate

class IntShortTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLessK() {
        XCTAssertEqual(100.shortString, "100")
    }

    func testK() {
        XCTAssertEqual(12345.shortString, "12.3 k")
    }

    func testM() {
        XCTAssertEqual(123445678.shortString, "123.4 m")
    }

    func testLong() {
        XCTAssertEqual(12344567899999.shortString, "12344567.9 m")
    }

    func testRoundUp() {
        XCTAssertEqual(1230.shortString, "1.2 k")
    }

    func testRoundDown() {
        XCTAssertEqual(1280.shortString, "1.3 k")
    }

}
