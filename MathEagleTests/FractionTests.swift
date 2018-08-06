//
//  FractionTests.swift
//  MathEagleTests
//
//  Created by Kelly Roach on 7/31/18.
//  Copyright © 2018 Jorestha Solutions. All rights reserved.
//

import XCTest
import MathEagle

class FractionTests: XCTestCase {
    func testFractionInit1() {
        let fraction : Fraction = Fraction(numerator:1, denominator:2)
        XCTAssertEqual(fraction.numerator,1)
        XCTAssertEqual(fraction.denominator,2)
    }
    func testFractionInit2() {
        do {
            let fraction : Fraction = Fraction(string:"1")
            XCTAssertEqual(fraction.numerator,1)
            XCTAssertEqual(fraction.denominator,1)
        }
        do {
            let fraction : Fraction = Fraction(string:"1/2")
            XCTAssertEqual(fraction.numerator,1)
            XCTAssertEqual(fraction.denominator,2)
        }
        do {
            let fraction : Fraction = Fraction(string:"0")
            XCTAssertEqual(fraction.numerator,0)
            XCTAssertEqual(fraction.denominator,1)
        }
        do {
            let fraction : Fraction = Fraction(string:"-1")
            XCTAssertEqual(fraction.numerator,-1)
            XCTAssertEqual(fraction.denominator,1)
        }
    }
    func testFractionCanonicalize() {
        do {
            var fraction : Fraction = Fraction(numerator:2, denominator:4)
            XCTAssertEqual(fraction.numerator,2)
            XCTAssertEqual(fraction.denominator,4)
            fraction.canonicalize()
            XCTAssertEqual(fraction.numerator,1)
            XCTAssertEqual(fraction.denominator,2)
        }
        do {
            var fraction : Fraction = Fraction(numerator:-2, denominator:4)
            XCTAssertEqual(fraction.numerator,-2)
            XCTAssertEqual(fraction.denominator,4)
            fraction.canonicalize()
            XCTAssertEqual(fraction.numerator,-1)
            XCTAssertEqual(fraction.denominator,2)
        }
        do {
            var fraction : Fraction = Fraction(numerator:2, denominator:-4)
            XCTAssertEqual(fraction.numerator,2)
            XCTAssertEqual(fraction.denominator,-4)
            fraction.canonicalize()
            XCTAssertEqual(fraction.numerator,-1)
            XCTAssertEqual(fraction.denominator,2)
        }
        do {
            var fraction : Fraction = Fraction(numerator:-2, denominator:-4)
            XCTAssertEqual(fraction.numerator,-2)
            XCTAssertEqual(fraction.denominator,-4)
            fraction.canonicalize()
            XCTAssertEqual(fraction.numerator,1)
            XCTAssertEqual(fraction.denominator,2)
        }
        do {
            var fraction : Fraction = Fraction(numerator:0, denominator:-4)
            XCTAssertEqual(fraction.numerator,0)
            XCTAssertEqual(fraction.denominator,-4)
            fraction.canonicalize()
            XCTAssertEqual(fraction.numerator,0)
            XCTAssertEqual(fraction.denominator,1)
        }
    }
    func testFractionDescription() {
        // Test documents tests and documents the current behavior
        do {
            let fraction : Fraction = Fraction(numerator:1, denominator:2)
            XCTAssertEqual(fraction.description,"1/2")
        }
        // The current behavior
        do {
            let fraction : Fraction = Fraction(numerator:0, denominator:1)
            XCTAssertEqual(fraction.description,"0/1")
        }
        do {
            let fraction : Fraction = Fraction(numerator:1, denominator:1)
            XCTAssertEqual(fraction.description,"1/1")
        }
        do {
            let fraction : Fraction = Fraction(numerator:2, denominator:-4)
            XCTAssertEqual(fraction.description,"2/-4")
        }
        do {
            let fraction : Fraction = Fraction(numerator:-2, denominator:-4)
            XCTAssertEqual(fraction.description,"-2/-4")
        }
    }
    func testFractionDoubleValue() {
        do {
            let fraction : Fraction = Fraction(numerator:1, denominator:2)
            XCTAssertEqual(fraction.doubleValue,0.5)
            XCTAssert((fraction.doubleValue as Any) is Double)
        }
        do {
            let fraction : Fraction = Fraction(numerator:0, denominator:1)
            XCTAssertEqual(fraction.doubleValue,0.0)
            XCTAssert((fraction.doubleValue as Any) is Double)
        }
        do {
            let fraction : Fraction = Fraction(numerator:1, denominator:1)
            XCTAssertEqual(fraction.doubleValue,1.0)
            XCTAssert((fraction.doubleValue as Any) is Double)
        }
        do {
            let fraction : Fraction = Fraction(numerator:2, denominator:-4)
            XCTAssertEqual(fraction.doubleValue,-0.5)
            XCTAssert((fraction.doubleValue as Any) is Double)
        }
        do {
            let fraction : Fraction = Fraction(numerator:-2, denominator:-4)
            XCTAssertEqual(fraction.doubleValue,0.5)
            XCTAssert((fraction.doubleValue as Any) is Double)
        }
    }
}
