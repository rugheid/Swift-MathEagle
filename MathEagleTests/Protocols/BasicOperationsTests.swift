//
//  BasicOperationsTests.swift
//  MathEagleTests
//
//  Created by Kelly Roach on 7/31/18.
//  Copyright © 2018 Jorestha Solutions. All rights reserved.
//

import XCTest
import MathEagle

class BasicOperationsTests: XCTestCase {
    func testNegatable() {
        // Test protocol Negatable for unsigned integers
        do {
            // Expecting -n64 = -1 = 2^64-1 (mod 2^64) etc.
            let n : UInt = 1
            let n8 : UInt8 = 1
            let n16 : UInt16 = 1
            let n32 : UInt32 = 1
            let n64 : UInt64 = 1
            XCTAssertEqual(Int(bitPattern:-n),-1)
            XCTAssertEqual(Int8(bitPattern:-n8),-1)
            XCTAssertEqual(Int16(bitPattern:-n16),-1)
            XCTAssertEqual(Int32(bitPattern:-n32),-1)
            XCTAssertEqual(Int64(bitPattern:-n64),-1)
            XCTAssertNotEqual(-n,n)
            XCTAssertNotEqual(-n8,n8)
            XCTAssertNotEqual(-n16,n16)
            XCTAssertNotEqual(-n32,n32)
            XCTAssertNotEqual(-n64,n64)
            XCTAssertEqual(-(-n),n)
            XCTAssertEqual(-(-n8),n8)
            XCTAssertEqual(-(-n16),n16)
            XCTAssertEqual(-(-n32),n32)
            XCTAssertEqual(-(-n64),n64)
            XCTAssert(-n>=0)
            XCTAssert(-n8>=0)
            XCTAssert(-n16>=0)
            XCTAssert(-n32>=0)
            XCTAssert(-n64>=0)
        }
        do {
            // Expecting -n64 = 1 (mod 2^64) etc.
            let n : UInt = UInt(bitPattern:-1)
            let n8 : UInt8 = UInt8(bitPattern:-1)
            let n16 : UInt16 = UInt16(bitPattern:-1)
            let n32 : UInt32 = UInt32(bitPattern:-1)
            let n64 : UInt64 = UInt64(bitPattern:-1)
            XCTAssertEqual(Int(bitPattern:-n),1)
            XCTAssertEqual(Int8(bitPattern:-n8),1)
            XCTAssertEqual(Int16(bitPattern:-n16),1)
            XCTAssertEqual(Int32(bitPattern:-n32),1)
            XCTAssertEqual(Int64(bitPattern:-n64),1)
            XCTAssertNotEqual(-n,n)
            XCTAssertNotEqual(-n8,n8)
            XCTAssertNotEqual(-n16,n16)
            XCTAssertNotEqual(-n32,n32)
            XCTAssertNotEqual(-n64,n64)
            XCTAssertEqual(-(-n),n)
            XCTAssertEqual(-(-n8),n8)
            XCTAssertEqual(-(-n16),n16)
            XCTAssertEqual(-(-n32),n32)
            XCTAssertEqual(-(-n64),n64)
            XCTAssert(-n>=0)
            XCTAssert(-n8>=0)
            XCTAssert(-n16>=0)
            XCTAssert(-n32>=0)
            XCTAssert(-n64>=0)
        }
   }
}
