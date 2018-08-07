//
//  CastableTests.swift
//  MathEagleTests
//
//  Created by Kelly Roach on 7/31/18.
//  Copyright © 2018 Jorestha Solutions. All rights reserved.
//

import XCTest

class CastableTests: XCTestCase {
    func testIntCastable() {
        XCTAssertEqual(Int(1).asInt,Int(1))
        XCTAssertEqual(Int8(1).asInt,Int(1))
        XCTAssertEqual(Int16(1).asInt,Int(1))
        XCTAssertEqual(Int32(1).asInt,Int(1))
        XCTAssertEqual(Int64(1).asInt,Int(1))
        XCTAssertEqual(UInt(1).asInt,Int(1))
        XCTAssertEqual(UInt8(1).asInt,Int(1))
        XCTAssertEqual(UInt16(1).asInt,Int(1))
        XCTAssertEqual(UInt32(1).asInt,Int(1))
        XCTAssertEqual(UInt64(1).asInt,Int(1))
        XCTAssertEqual(Float(1.0).asInt,Int(1))
        XCTAssertEqual(Double(1.0).asInt,Int(1))
        XCTAssertEqual(CGFloat(1.0).asInt,Int(1))
        XCTAssert((Int(1).asInt as Any) is Int)
        XCTAssert((Int8(1).asInt as Any) is Int)
        XCTAssert((Int16(1).asInt as Any) is Int)
        XCTAssert((Int32(1).asInt as Any) is Int)
        XCTAssert((Int64(1).asInt as Any) is Int)
        XCTAssert((UInt(1).asInt as Any) is Int)
        XCTAssert((UInt8(1).asInt as Any) is Int)
        XCTAssert((UInt16(1).asInt as Any) is Int)
        XCTAssert((UInt32(1).asInt as Any) is Int)
        XCTAssert((UInt64(1).asInt as Any) is Int)
        XCTAssert((Float(1.0).asInt as Any) is Int)
        XCTAssert((Double(1.0).asInt as Any) is Int)
        XCTAssert((CGFloat(1.0).asInt as Any) is Int)
    }
}
