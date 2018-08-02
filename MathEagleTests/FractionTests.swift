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
        repeat {
            let fraction : Fraction = Fraction(string:"1")
            XCTAssertEqual(fraction.numerator,1)
            XCTAssertEqual(fraction.denominator,1)
        } while false
        repeat {
            let fraction : Fraction = Fraction(string:"1/2")
            XCTAssertEqual(fraction.numerator,1)
            XCTAssertEqual(fraction.denominator,2)
        } while false
        repeat {
            let fraction : Fraction = Fraction(string:"0")
            XCTAssertEqual(fraction.numerator,0)
            XCTAssertEqual(fraction.denominator,1)
        } while false
        repeat {
            let fraction : Fraction = Fraction(string:"-1")
            XCTAssertEqual(fraction.numerator,-1)
            XCTAssertEqual(fraction.denominator,1)
        } while false
    }
    func testFractionCanonicalize() {
        repeat {
            var fraction : Fraction = Fraction(numerator:2, denominator:4)
            XCTAssertEqual(fraction.numerator,2)
            XCTAssertEqual(fraction.denominator,4)
            fraction.canonicalize()
            XCTAssertEqual(fraction.numerator,1)
            XCTAssertEqual(fraction.denominator,2)
        } while false
        repeat {
            var fraction : Fraction = Fraction(numerator:-2, denominator:4)
            XCTAssertEqual(fraction.numerator,-2)
            XCTAssertEqual(fraction.denominator,4)
            fraction.canonicalize()
            XCTAssertEqual(fraction.numerator,-1)
            XCTAssertEqual(fraction.denominator,2)
        } while false
        repeat {
            var fraction : Fraction = Fraction(numerator:2, denominator:-4)
            XCTAssertEqual(fraction.numerator,2)
            XCTAssertEqual(fraction.denominator,-4)
            fraction.canonicalize()
            XCTAssertEqual(fraction.numerator,-1)
            XCTAssertEqual(fraction.denominator,2)
        } while false
        repeat {
            var fraction : Fraction = Fraction(numerator:-2, denominator:-4)
            XCTAssertEqual(fraction.numerator,-2)
            XCTAssertEqual(fraction.denominator,-4)
            fraction.canonicalize()
            XCTAssertEqual(fraction.numerator,1)
            XCTAssertEqual(fraction.denominator,2)
        } while false
        repeat {
            var fraction : Fraction = Fraction(numerator:0, denominator:-4)
            XCTAssertEqual(fraction.numerator,0)
            XCTAssertEqual(fraction.denominator,-4)
            fraction.canonicalize()
            XCTAssertEqual(fraction.numerator,0)
            XCTAssertEqual(fraction.denominator,1)
        } while false
    }
    func testFractionDescription() {
        // Test documents tests and documents the current behavior
        repeat {
            let fraction : Fraction = Fraction(numerator:1, denominator:2)
            XCTAssertEqual(fraction.description,"1/2")
        } while false
        // The current behavior
        repeat {
            let fraction : Fraction = Fraction(numerator:0, denominator:1)
            XCTAssertEqual(fraction.description,"0/1")
        } while false
        repeat {
            let fraction : Fraction = Fraction(numerator:1, denominator:1)
            XCTAssertEqual(fraction.description,"1/1")
        } while false
        repeat {
            let fraction : Fraction = Fraction(numerator:2, denominator:-4)
            XCTAssertEqual(fraction.description,"2/-4")
        } while false
        repeat {
            let fraction : Fraction = Fraction(numerator:-2, denominator:-4)
            XCTAssertEqual(fraction.description,"-2/-4")
        } while false
    }
    func testFractionDoubleValue() {
        repeat {
            let fraction : Fraction = Fraction(numerator:1, denominator:2)
            XCTAssertEqual(fraction.doubleValue,0.5)
            XCTAssert((fraction.doubleValue as Any) is Double)
        } while false
        repeat {
            let fraction : Fraction = Fraction(numerator:0, denominator:1)
            XCTAssertEqual(fraction.doubleValue,0.0)
            XCTAssert((fraction.doubleValue as Any) is Double)
        } while false
        repeat {
            let fraction : Fraction = Fraction(numerator:1, denominator:1)
            XCTAssertEqual(fraction.doubleValue,1.0)
            XCTAssert((fraction.doubleValue as Any) is Double)
        } while false
        repeat {
            let fraction : Fraction = Fraction(numerator:2, denominator:-4)
            XCTAssertEqual(fraction.doubleValue,-0.5)
            XCTAssert((fraction.doubleValue as Any) is Double)
        } while false
        repeat {
            let fraction : Fraction = Fraction(numerator:-2, denominator:-4)
            XCTAssertEqual(fraction.doubleValue,0.5)
            XCTAssert((fraction.doubleValue as Any) is Double)
        } while false
    }
}
