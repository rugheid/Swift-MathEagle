//
//  ConjugatableTests.swift
//  MathEagleTests
//
//  Created by Kelly Roach on 7/31/18.
//  Copyright © 2018 Jorestha Solutions. All rights reserved.
//

import XCTest

class ConjugatableTests: XCTestCase {
    func testIntConjugatable() {
        XCTAssertEqual(Int(1).conjugate,Int(1))
        XCTAssertEqual(Int8(1).conjugate,Int8(1))
        XCTAssertEqual(Int16(1).conjugate,Int16(1))
        XCTAssertEqual(Int32(1).conjugate,Int32(1))
        XCTAssertEqual(Int64(1).conjugate,Int64(1))
        XCTAssertEqual(UInt(1).conjugate,UInt(1))
        XCTAssertEqual(UInt8(1).conjugate,UInt8(1))
        XCTAssertEqual(UInt16(1).conjugate,UInt16(1))
        XCTAssertEqual(UInt32(1).conjugate,UInt32(1))
        XCTAssertEqual(UInt64(1).conjugate,UInt64(1))
        XCTAssertEqual(Float(1.0).conjugate,Float(1))
        XCTAssertEqual(Double(1.0).conjugate,Double(1))
        XCTAssertEqual(CGFloat(1.0).conjugate,CGFloat(1))
        XCTAssert((Int(1).conjugate as Any) is Int)
        XCTAssert((Int8(1).conjugate as Any) is Int8)
        XCTAssert((Int16(1).conjugate as Any) is Int16)
        XCTAssert((Int32(1).conjugate as Any) is Int32)
        XCTAssert((Int64(1).conjugate as Any) is Int64)
        XCTAssert((UInt(1).conjugate as Any) is UInt)
        XCTAssert((UInt8(1).conjugate as Any) is UInt8)
        XCTAssert((UInt16(1).conjugate as Any) is UInt16)
        XCTAssert((UInt32(1).conjugate as Any) is UInt32)
        XCTAssert((UInt64(1).conjugate as Any) is UInt64)
        XCTAssert((Float(1.0).conjugate as Any) is Float)
        XCTAssert((Double(1.0).conjugate as Any) is Double)
        XCTAssert((CGFloat(1.0).conjugate as Any) is CGFloat)
    }
}
