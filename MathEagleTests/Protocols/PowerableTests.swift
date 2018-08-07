//
//  PowerableTests.swift
//  MathEagleTests
//
//  Created by Kelly Roach on 8/1/18.
//  Copyright © 2018 Jorestha Solutions. All rights reserved.
//

import XCTest
import MathEagle

class PowerableTests: XCTestCase {
    func testPow() {
        // Test documents current pow API
        XCTAssertEqual(pow(Int(2),right:UInt(3)),Int(8))
        XCTAssertEqual(pow(Int8(2),right:UInt(3)),Int(8))
        XCTAssertEqual(pow(Int16(2),right:UInt(3)),Int(8))
        XCTAssertEqual(pow(Int32(2),right:UInt(3)),Int(8))
        XCTAssertEqual(pow(Int64(2),right:UInt(3)),Int(8))
        XCTAssertEqual(pow(UInt(2),right:UInt(3)),UInt(8))
        XCTAssertEqual(pow(UInt8(2),right:UInt(3)),UInt(8))
        XCTAssertEqual(pow(UInt16(2),right:UInt(3)),UInt(8))
        XCTAssertEqual(pow(UInt32(2),right:UInt(3)),UInt(8))
        XCTAssertEqual(pow(UInt64(2),right:UInt(3)),UInt(8))
        XCTAssertEqual(pow(Float(2.0),right:UInt(3)),Float(8.0))
        XCTAssertEqual(pow(Double(2.0),right:UInt(3)),Double(8.0))
        XCTAssertEqual(pow(CGFloat(2.0),right:UInt(3)),CGFloat(8.0))
    }
    func testNaturalPowerable() {
        // Test documents current ** API
        XCTAssertEqual(Int(2)**UInt(3),Int(8))
        XCTAssertEqual(Int8(2)**UInt(3),Int(8))
        XCTAssertEqual(Int16(2)**UInt(3),Int(8))
        XCTAssertEqual(Int32(2)**UInt(3),Int(8))
        XCTAssertEqual(Int64(2)**UInt(3),Int(8))
        XCTAssertEqual(UInt(2)**UInt(3),UInt(8))
        XCTAssertEqual(UInt8(2)**UInt(3),UInt(8))
        XCTAssertEqual(UInt16(2)**UInt(3),UInt(8))
        XCTAssertEqual(UInt32(2)**UInt(3),UInt(8))
        XCTAssertEqual(UInt64(2)**UInt(3),UInt(8))
        XCTAssertEqual(Float(2.0)**UInt(3),Float(8.0))
        XCTAssertEqual(Double(2.0)**UInt(3),Double(8.0))
        XCTAssertEqual(CGFloat(2.0)**UInt(3),CGFloat(8.0))
    }
    func testIntegerPowerable() {
        // Test documents current ** API
        XCTAssertEqual(Int(2)**Int(-3),Double(0.125))
        XCTAssertEqual(Int8(2)**Int(-3),Double(0.125))
        XCTAssertEqual(Int16(2)**Int(-3),Double(0.125))
        XCTAssertEqual(Int32(2)**Int(-3),Double(0.125))
        XCTAssertEqual(Int64(2)**Int(-3),Double(0.125))
        XCTAssertEqual(UInt(2)**Int(-3),Double(0.125))
        XCTAssertEqual(UInt8(2)**Int(-3),Double(0.125))
        XCTAssertEqual(UInt16(2)**Int(-3),Double(0.125))
        XCTAssertEqual(UInt32(2)**Int(-3),Double(0.125))
        XCTAssertEqual(UInt64(2)**Int(-3),Double(0.125))
        XCTAssertEqual(Float(2.0)**Int(-3),Float(0.125))
        XCTAssertEqual(Double(2.0)**Int(-3),Double(0.125))
        XCTAssertEqual(CGFloat(2.0)**Int(-3),CGFloat(0.125))
    }
    func testRealPowerable() {
        // Test documents current ** API
        XCTAssertEqual(Int(2)**Double(-3.0),Double(0.125))
        XCTAssertEqual(Int8(2)**Double(-3.0),Double(0.125))
        XCTAssertEqual(Int16(2)**Double(-3.0),Double(0.125))
        XCTAssertEqual(Int32(2)**Double(-3.0),Double(0.125))
        XCTAssertEqual(Int64(2)**Double(-3.0),Double(0.125))
        XCTAssertEqual(UInt(2)**Double(-3.0),Double(0.125))
        XCTAssertEqual(UInt8(2)**Double(-3.0),Double(0.125))
        XCTAssertEqual(UInt16(2)**Double(-3.0),Double(0.125))
        XCTAssertEqual(UInt32(2)**Double(-3.0),Double(0.125))
        XCTAssertEqual(UInt64(2)**Double(-3.0),Double(0.125))
        XCTAssertEqual(Float(2.0)**Double(-3.0),Double(0.125))
        XCTAssertEqual(Double(2.0)**Double(-3.0),Double(0.125))
        XCTAssertEqual(CGFloat(2.0)**Double(-3.0),CGFloat(0.125))
        XCTAssertEqual(CGFloat(2.0)**CGFloat(-3.0),CGFloat(0.125))
    }
    func testRoot() {
        // Test documents current root API
        XCTAssertEqual(root(Int(8),order:Int(3)),Double(2.0))
        XCTAssertEqual(root(Int8(8),order:Int(3)),Double(2.0))
        XCTAssertEqual(root(Int16(8),order:Int(3)),Double(2.0))
        XCTAssertEqual(root(Int32(8),order:Int(3)),Double(2.0))
        XCTAssertEqual(root(Int64(8),order:Int(3)),Double(2.0))
        XCTAssertEqual(root(UInt(8),order:Int(3)),Double(2.0))
        XCTAssertEqual(root(UInt8(8),order:Int(3)),Double(2.0))
        XCTAssertEqual(root(UInt16(8),order:Int(3)),Double(2.0))
        XCTAssertEqual(root(UInt32(8),order:Int(3)),Double(2.0))
        XCTAssertEqual(root(UInt64(8),order:Int(3)),Double(2.0))
        XCTAssertEqual(root(Float(8.0),order:Int(3)),Double(2.0))
        XCTAssertEqual(root(Double(8.0),order:Int(3)),Double(2.0))
        XCTAssertEqual(root(CGFloat(8.0),order:Int(3)),CGFloat(2.0))
    }
}
