//
//  FormatterTests.swift
//  DoughnateTests
//
//  Created by Евгений Соболь on 12/21/18.
//  Copyright © 2018 Евгений Соболь. All rights reserved.
//

import XCTest
@testable import Doughnate

class FormatterTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInt() {
        XCTAssertEqual(NumberFormatter.oneFractionDigit.string(from: NSNumber(value: 100)), "100")
    }

    func testOneFraction() {
        XCTAssertEqual(NumberFormatter.oneFractionDigit.string(from: NSNumber(value: 100.1)), "100.1")
    }

    func testMultipleFraction() {
        XCTAssertEqual(NumberFormatter.oneFractionDigit.string(from: NSNumber(value: 100.123)), "100.1")
    }

    func testNegative() {
        XCTAssertEqual(NumberFormatter.oneFractionDigit.string(from: NSNumber(value: -100.4)), "-100.4")
    }

    func testZero() {
        XCTAssertEqual(NumberFormatter.oneFractionDigit.string(from: NSNumber(value: 0)), "0")
    }

    func testZeroFraction() {
        XCTAssertEqual(NumberFormatter.oneFractionDigit.string(from: NSNumber(value: 1.0)), "1")
    }

}
