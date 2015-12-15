//
//  BigIntTests.swift
//  MathEagle
//
//  Created by Rugen Heidbuchel on 15/12/15.
//  Copyright © 2015 Jorestha Solutions. All rights reserved.
//

import Cocoa
import Foundation
import XCTest
import MathEagle

class BigIntTests: XCTestCase {
    
    func testInit() {
        let bigInt = BigInt()
        XCTAssertEqual("0", bigInt.stringValue)
    }
    
    func testStringValue() {
        let bigInt = BigInt(int: 123521)
        XCTAssertEqual("11110001010000001", bigInt.stringValue(2))
        XCTAssertEqual("123521", bigInt.stringValue(10))
    }
    
}