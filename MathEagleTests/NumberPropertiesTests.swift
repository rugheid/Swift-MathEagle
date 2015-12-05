//
//  NumberPropertiesTests.swift
//  MathEagle
//
//  Created by Rugen Heidbuchel on 05/12/15.
//  Copyright © 2015 Jorestha Solutions. All rights reserved.
//

import XCTest
import MathEagle


class NumberPropertiesTests: XCTestCase {
    
    func testDigits() {
        
        XCTAssertEqual(digits(124387), [1, 2, 4, 3, 8, 7])
        XCTAssertEqual(digits(-234), [2, 3, 4])
        XCTAssertEqual(digits(0), [0])
    }
    
    
    func testNumberOfDigits() {
        
        XCTAssertEqual(numberOfDigits(7), 1)
        XCTAssertEqual(numberOfDigits(1784835), 7)
        XCTAssertEqual(numberOfDigits(456789328763738272), 18)
        XCTAssertEqual(numberOfDigits(-12345), 5)
    }
    
    
    func testIsPandigital() {
        
        XCTAssertTrue(isPandigital(1234))
        XCTAssertTrue(isPandigital(964758321))
        XCTAssertTrue(isPandigital(85627134))
        XCTAssertTrue(isPandigital(1654237098, includeZero: true))
        
        XCTAssertFalse(isPandigital(1232))
        XCTAssertFalse(isPandigital(3487))
        XCTAssertFalse(isPandigital(1234567890))
        XCTAssertFalse(isPandigital(123456789, includeZero: true))
    }
    
}