//
//  BigFracTests.swift
//  MathEagleTests
//
//  Created by Kelly Roach on 8/1/18.
//  Copyright © 2018 Jorestha Solutions. All rights reserved.
//

import XCTest
import MathEagle

class BigFracTests: XCTestCase {
    // MARK: Initialisers
    func testBigFracInit1() {
        var x = BigFrac(string:"1000000000000000000000000000000/1000000000000000000000000000001")
        XCTAssert((x as Any) is BigFrac)
        x = BigFrac(string:"1/2")
        XCTAssert((x as Any) is BigFrac)
        x = BigFrac(string:"-1/2")
        XCTAssert((x as Any) is BigFrac)
        x = BigFrac(string:"-1000000000000000000000000000000/1000000000000000000000000000001")
        XCTAssert((x as Any) is BigFrac)
        x = BigFrac(numerator:1000000000,denominator:1000000001)
        XCTAssert((x as Any) is BigFrac)
        x = BigFrac(int:1000000000)
        x = BigFrac(numerator:UInt(1000000000),denominator:UInt(1000000001))
        XCTAssert((x as Any) is BigFrac)
        x = BigFrac(uint:UInt(1000000000))
        XCTAssert((x as Any) is BigFrac)
        x = BigFrac(string:"1")
        XCTAssert((x as Any) is BigFrac)
        x = BigFrac(string:"0")
        XCTAssert((x as Any) is BigFrac)
        x = BigFrac(string:"-1")
        XCTAssert((x as Any) is BigFrac)
        x = BigFrac(string:"1234")
        XCTAssert((x as Any) is BigFrac)
    }
    // MARK: Properties
    func testBigFracDescription() {
        var x = BigFrac(string:"1000000000000000000000000000000/1000000000000000000000000000001")
        XCTAssertEqual(x.description,"1000000000000000000000000000000/1000000000000000000000000000001")
        x = BigFrac(string:"1/2")
        XCTAssertEqual(x.description,"1/2")
        x = BigFrac(string:"-1/2")
        XCTAssertEqual(x.description,"-1/2")
        x = BigFrac(string:"-1000000000000000000000000000000/1000000000000000000000000000001")
        XCTAssertEqual(x.description,"-1000000000000000000000000000000/1000000000000000000000000000001")
        x = BigFrac(numerator:1000000000,denominator:1000000001)
        XCTAssertEqual(x.description,"1000000000/1000000001")
        x = BigFrac(int:1000000000)
        XCTAssertEqual(x.description,"1000000000")
        x = BigFrac(numerator:UInt(1000000000),denominator:UInt(1000000001))
        XCTAssertEqual(x.description,"1000000000/1000000001")
        x = BigFrac(uint:UInt(1000000000))
        XCTAssertEqual(x.description,"1000000000")
        // Curiousities (denom = 1 or not "canonicalized" yet)
        x = BigFrac(string:"1/1")
        XCTAssertEqual(x.description,"1")
        x = BigFrac(string:"2/2")
        XCTAssertEqual(x.description,"2/2")
        x = BigFrac(string:"-3/6")
        XCTAssertEqual(x.description,"-3/6")
        x = BigFrac(string:"0/1000")
        XCTAssertEqual(x.description,"0/1000")
        x = BigFrac(numerator:0,denominator:1000)
        XCTAssertEqual(x.description,"0")
        x = BigFrac(numerator:10,denominator:1000)
        XCTAssertEqual(x.description,"10/1000")
    }
    // MARK: Equatable
    func testBigFracEquatable() {
        let x = BigFrac(string:"1000000000000000000000000000000/1000000000000000000000000000001")
        let y = BigFrac(string:"1")
        let z = BigFrac(string:"1000000000000000000000000000000/1000000000000000000000000000000")
        XCTAssert(x==x)
        XCTAssert(y==y)
        XCTAssert(z==z)
        XCTAssert(y==z)
        XCTAssertFalse(x==y)
        XCTAssertFalse(x==z)
    }
    // MARK: Comparable
    func testBigFracComparable() {
        let x = BigFrac(string:"999999999999999999999999999999/1000000000000000000000000000001")
        let y = BigFrac(string:"1000000000000000000000000000000/1000000000000000000000000000001")
        let z = BigFrac(string:"1")
        XCTAssert(x<y)
        XCTAssert(y<z)
        XCTAssert(x<z)
        XCTAssert(y>x)
        XCTAssert(z>y)
        XCTAssert(z>x)
    }
    // MARK: Addable
    func testBigFracAddable1() {
        let x = BigFrac(string:"1000000000000000000000000000000/1000000000000000000000000000001")
        let y = BigFrac(string:"1")
        let z = BigFrac(string:"2000000000000000000000000000001/1000000000000000000000000000001")
        XCTAssertEqual(x+y,z)
    }
    func testBigFracAddable2() {
        // Adding two fractions whose unequal denominators have a nontrivial gcd
        let x = BigFrac(string:"1/6000000000000")
        let y = BigFrac(string:"1/9000000000000")
        let z = BigFrac(string:"1/3600000000000")
        XCTAssertEqual(x+y,z)
    }
    // MARK: Negatable
    func testBigFracNegatable() {
        let x = BigFrac(string:"1000000000000000000000000000000/1000000000000000000000000000001")
        let y = BigFrac(string:"-1000000000000000000000000000000/1000000000000000000000000000001")
        XCTAssertNotEqual(x,y)
        XCTAssertEqual(-x,y)
        XCTAssertEqual(-(-x),x)
    }
    // MARK: Subtractable
    func testBigFracSubtractable1() {
        let x = BigFrac(string:"1000000000000000000000000000000/1000000000000000000000000000001")
        let y = BigFrac(string:"1")
        let z = BigFrac(string:"2000000000000000000000000000001/1000000000000000000000000000001")
        XCTAssertEqual(z-x,y)
        XCTAssertEqual(z-y,x)
    }
    func testBigFracSubtractable2() {
        // Adding two fractions whose unequal denominators have a nontrivial gcd
        let x = BigFrac(string:"1/6000000000000")
        let y = BigFrac(string:"1/9000000000000")
        let z = BigFrac(string:"1/3600000000000")
        XCTAssertEqual(z-x,y)
        XCTAssertEqual(z-y,x)
    }
    // MARK: Multiplicable
    func testBigFracMultiplicable() {
        let x = BigFrac(string:"11/1000000000000")
        let y = BigFrac(string:"6000000000000/66000000000011")
        let z = BigFrac(string:"6/6000000000001")
        XCTAssertEqual(x*y,z)
    }
    // MARK: Dividable
    func testBigFracDividable() {
        let x = BigFrac(string:"11/1000000000000")
        let y = BigFrac(string:"6000000000000/66000000000011")
        let z = BigFrac(string:"6/6000000000001")
        XCTAssertEqual(z/x,y)
        XCTAssertEqual(z/y,x)
    }
    // MARK: Absolute Value
    func testBigFracAbsoluteValue() {
        let x = BigFrac(string:"1000000000000000000000000000000/1000000000000000000000000000001")
        let y = BigFrac(string:"-1000000000000000000000000000000/1000000000000000000000000000001")
        XCTAssertEqual(abs(y),x)
    }
}
