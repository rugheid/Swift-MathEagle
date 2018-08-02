//
//  BigFloatTests.swift
//  MathEagleTests
//
//  Created by Kelly Roach on 8/1/18.
//  Copyright © 2018 Jorestha Solutions. All rights reserved.
//

import XCTest
import MathEagle

class BigFloatTests: XCTestCase {
    // MARK: Initialisers
    func testBigFloatInit1() {
        var x = BigFloat(string:"1000000000000000000000000000000")
        XCTAssert((x as Any) is BigFloat)
        x = BigFloat(string:"1")
        XCTAssert((x as Any) is BigFloat)
        x = BigFloat(string:"0")
        XCTAssert((x as Any) is BigFloat)
        x = BigFloat(string:"-1")
        XCTAssert((x as Any) is BigFloat)
        x = BigFloat(string:"1234")
        XCTAssert((x as Any) is BigFloat)
        x = BigFloat(string:"1000000000000000000000000000000.123456789")
        XCTAssert((x as Any) is BigFloat)
    }
    func testBigFloatInit2() {
        var x = BigFloat(string:"1000000000000000000000000000000")
        XCTAssert((x as Any) is BigFloat)
        x = BigFloat(x)
        XCTAssert((x as Any) is BigFloat)
        x = BigFloat(int:1)
        XCTAssert((x as Any) is BigFloat)
        x = BigFloat(uint:UInt(1))
        XCTAssert((x as Any) is BigFloat)
        x = BigFloat(double:1.0)
        XCTAssert((x as Any) is BigFloat)
    }
    // MARK: Properties
    func testBigFloatDescription() {
        var x = BigFloat(string:"0")
        XCTAssertEqual(x.description,"0.0")
        x = BigFloat(string:"1000000000000000000000000000000")
        XCTAssertEqual(x.description,"1.e30")
        x = BigFloat(string:"1")
        XCTAssertEqual(x.description,"1.e0")
        x = BigFloat(string:"1.23456789")
        XCTAssertEqual(x.description,"1.23456789e0")
        x = BigFloat(string:"-1000000000000000000000000000000")
        XCTAssertEqual(x.description,"-1.e30")
        x = BigFloat(string:"-1")
        XCTAssertEqual(x.description,"-1.e0")
        x = BigFloat(string:"-1.23456789")
        XCTAssertEqual(x.description,"-1.23456789e0")
    }
    // MARK: Equatable
    func testBigFloatEquatable() {
        let x = BigFloat(string:"1000000000000000000000000000000")
        let y = BigFloat(string:"1000000000000000000000000000000")
        let z = BigFloat(string:"1000000000000000000000000000001")
        XCTAssert(x==x)
        XCTAssert(x==y)
        XCTAssertFalse(x==z)
        let u = BigFloat(x)
        XCTAssert(u==x)
    }
    // MARK: Comparable
    func testBigFloatComparable() {
        let x = BigFloat(string:"1000000000000000000000000000000")
        let y = BigFloat(string:"1000000000000000000000000000000")
        let z = BigFloat(string:"1000000000000000000000000000001")
        XCTAssertFalse(x<x)
        XCTAssertFalse(x<y)
        XCTAssert(x<z)
        XCTAssertFalse(z<x)
        XCTAssertFalse(x>x)
        XCTAssertFalse(x>y)
        XCTAssertFalse(x>z)
        XCTAssert(z>x)
    }
    // MARK: Addable
    func testBigFloatAddable() {
        let x = BigFloat(string:"1000000000000000000000000000000")
        let y = BigFloat(string:"1")
        let z = BigFloat(string:"1000000000000000000000000000001")
        XCTAssertEqual(x+y,z)
    }
    // MARK: Negatable
    func testBigFloatNegatable() {
        let x = BigFloat(string:"1000000000000000000000000000000")
        let y = BigFloat(string:"-1000000000000000000000000000000")
        let z = BigFloat(string:"0")
        XCTAssertEqual(-x,y)
        XCTAssertEqual(-y,x)
        XCTAssertEqual(-z,z)
        XCTAssertEqual(-(-x),x)
    }
    // MARK: Subtractable
    func testBigFloatSubtractable() {
        let x = BigFloat(string:"1000000000000000000000000000000")
        let y = BigFloat(string:"1")
        let z = BigFloat(string:"1000000000000000000000000000001")
        let w = BigFloat(string:"-999999999999999999999999999999")
        XCTAssertEqual(z-y,x)
        XCTAssertEqual(y-x,w)
    }
    // MARK: Multiplicable
    func testBigFloatMultiplicable() {
        let x = BigFloat(string:"100000000")
        let y = BigFloat(string:"10000000000000000000000")
        let z = BigFloat(string:"1000000000000000000000000000000")
        let u = BigFloat(string:"0")
        let v = BigFloat(string:"-100000000")
        let w = BigFloat(string:"-10000000000000000000000")
        XCTAssertEqual(x*y,z)
        XCTAssertEqual(z*u,u)
        XCTAssertEqual(u*u,u)
        XCTAssertEqual(v*w,z)
    }
    // MARK: Dividable
    func testBigFloatDividable() {
        let x = BigFloat(string:"100000000")
        let y = BigFloat(string:"10000000000000000000000")
        let z = BigFloat(string:"1000000000000000000000000000000")
        let u = BigFloat(string:"0")
        let v = BigFloat(string:"-100000000")
        let w = BigFloat(string:"-10000000000000000000000")
        XCTAssertEqual(z/x,y)
        XCTAssertEqual(z/y,x)
        XCTAssertEqual(u/z,u)
        XCTAssertEqual(z/v,w)
        XCTAssertEqual(z/w,v)
    }
    // MARK: Natural Powerable
    func testBigFloatNaturalPowerable() {
        let w = BigFloat(string:"1")
        let x = BigFloat(string:"100000000")
        let y = BigFloat(string:"10000000000000000")
        let z = BigFloat(string:"1000000000000000000000000")
        XCTAssertEqual(x**0,w)
        XCTAssertEqual(x**1,x)
        XCTAssertEqual(x**2,y)
        XCTAssertEqual(x**3,z)
        XCTAssertNotEqual(w,z)
    }
    // MARK: Absolute Value
    func testBigFloatAbsoluteValue() {
        let x = BigFloat(string:"100000000")
        let y = BigFloat(string:"10000000000000000000000")
        let u = BigFloat(string:"0")
        let v = BigFloat(string:"-100000000")
        let w = BigFloat(string:"-10000000000000000000000")
        XCTAssertEqual(abs(x),x)
        XCTAssertEqual(abs(y),y)
        XCTAssertEqual(abs(u),u)
        XCTAssertEqual(abs(v),x)
        XCTAssertEqual(abs(w),y)
    }
    // MARK: Sqrt
    func testBigFloatSqrt() {
        let x = BigFloat(string:"1000")
        let y = BigFloat(string:"1000000")
        let u = BigFloat(string:"1000000000000")
        let v = BigFloat(string:"1000000000000000000000000")
        let w = BigFloat(string:"1000000000000000000000000000000000000000000000000")
        XCTAssertEqual(sqrt(w),v)
        XCTAssertEqual(sqrt(v),u)
        XCTAssertEqual(sqrt(u),y)
        XCTAssertEqual(sqrt(y),x)
    }
}
