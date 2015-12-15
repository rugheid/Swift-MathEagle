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
    
    
    // MARK: Init tests
    
    func testInit() {
        let bigInt = BigInt()
        XCTAssertEqual("0", bigInt.stringValue)
    }
    
    func testInitBigInt() {
        let bigInt = BigInt(string: "-31692029223372036854775807")
        let bigIntCopy = BigInt(bigInt: bigInt)
        XCTAssertEqual(bigInt, bigIntCopy)
    }
    
    
    // MARK: Conversion Tests
    
    func testIntValue() {
        var bigInt = BigInt(string: "-4321")
        XCTAssertEqual(-4321, bigInt.intValue)
        
        bigInt = BigInt(string: "11" + "111111111111111111111111111111111111111111111111111111111111111", base: 2)
        XCTAssertEqual(Int.max, bigInt.intValue)
    }
    
    func testUIntValue() {
        let bigInt = BigInt(string: "-4321")
        XCTAssertEqual(UInt(4321), bigInt.uintValue)
    }
    
    func testDoubleValue() {
        let bigInt = BigInt(string: "-4321")
        XCTAssertEqual(-4321.0, bigInt.doubleValue)
    }
    
    func testStringValue() {
        var bigInt = BigInt(int: 123521)
        XCTAssertEqual("11110001010000001", bigInt.stringValue(2))
        XCTAssertEqual("361201", bigInt.stringValue(8))
        XCTAssertEqual("123521", bigInt.stringValue(10))
        XCTAssertEqual("1e281", bigInt.stringValue(16))
        
        bigInt = BigInt(string: "-31692029223372036854775807")
        XCTAssertEqual("-1101000110111000011000101100011000010110100011010110101011011010011111111111111111111", bigInt.stringValue(2))
        XCTAssertEqual("-15067030543026432653323777777", bigInt.stringValue(8))
        XCTAssertEqual("-31692029223372036854775807", bigInt.stringValue(10))
        XCTAssertEqual("-1a370c58c2d1ad5b4fffff", bigInt.stringValue(16))
    }
    
    
    // MARK: Comparison Tests
    
    func testCompareBigInt() {
        let a = BigInt(int: 53103)
        let b = BigInt(int: 53103)
        let c = BigInt(int: -47801842)
        XCTAssertEqual(a.compare(b), NSComparisonResult.OrderedSame)
        XCTAssertEqual(a.compare(c), NSComparisonResult.OrderedDescending)
        XCTAssertEqual(c.compare(a), NSComparisonResult.OrderedAscending)
    }
    
    func testEqualityOperator() {
        let a = BigInt(int: 53103)
        let b = BigInt(int: 53103)
        let c = BigInt(int: -47801842)
        XCTAssertTrue(a == a)
        XCTAssertTrue(a == b)
        XCTAssertFalse(a == c)
    }
    
    func testInequalityOperator() {
        let a = BigInt(int: 53103)
        let b = BigInt(int: 53103)
        let c = BigInt(int: -47801842)
        XCTAssertTrue(a != c)
        XCTAssertFalse(a != a)
        XCTAssertFalse(a != b)
    }
    
    func testSmallerThanOperator() {
        let a = BigInt(int: 53103)
        let b = BigInt(int: 53103)
        let c = BigInt(int: -47801842)
        XCTAssertTrue(c < a)
        XCTAssertFalse(a < c)
        XCTAssertFalse(a < b)
        XCTAssertFalse(a < a)
    }
    
    func testSmallerThanOrEqualOperator() {
        let a = BigInt(int: 53103)
        let b = BigInt(int: 53103)
        let c = BigInt(int: -47801842)
        XCTAssertTrue(c <= a)
        XCTAssertTrue(a <= b)
        XCTAssertTrue(a <= a)
        XCTAssertFalse(a <= c)
    }
    
    func testGreaterThanOperator() {
        let a = BigInt(int: 53103)
        let b = BigInt(int: 53103)
        let c = BigInt(int: -47801842)
        XCTAssertTrue(a > c)
        XCTAssertFalse(c > a)
        XCTAssertFalse(a > b)
        XCTAssertFalse(a > a)
    }
    
    func testGreaterThanOrEqualOperator() {
        let a = BigInt(int: 53103)
        let b = BigInt(int: 53103)
        let c = BigInt(int: -47801842)
        XCTAssertTrue(a >= c)
        XCTAssertTrue(a >= b)
        XCTAssertTrue(a >= a)
        XCTAssertFalse(c >= a)
    }
    
    
    // MARK: Operation Tests
    
    func testAdd() {
        let a = BigInt(int: 53103)
        let b = BigInt(int: 53103)
        let c = BigInt(int: -47801842)
        XCTAssertEqual(BigInt(int: 106206), a.add(b))
        XCTAssertEqual(BigInt(int: 106206), a.add(a))
        XCTAssertEqual(BigInt(int: -47748739), a.add(c))
    }
    
    func testAdditionOperator() {
        let a = BigInt(int: 53103)
        let b = BigInt(int: 53103)
        let c = BigInt(int: -47801842)
        XCTAssertEqual(BigInt(int: 106206), a + b)
        XCTAssertEqual(BigInt(int: 106206), a + a)
        XCTAssertEqual(BigInt(int: -47748739), a + c)
    }
    
}