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
    
    func testInitIntLiteral() {
        var bigInt = BigInt()
        bigInt = 2897
        XCTAssertEqual(BigInt(int: 2897), bigInt)
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
        XCTAssertEqual(a.compare(b), ComparisonResult.orderedSame)
        XCTAssertEqual(a.compare(c), ComparisonResult.orderedDescending)
        XCTAssertEqual(c.compare(a), ComparisonResult.orderedAscending)
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
    
    func testAddInPlace() {
        var a = BigInt(int: 53103)
        var b = BigInt(int: 53103)
        let c = BigInt(int: -47801842)
        a.addInPlace(b)
        b.addInPlace(c)
        XCTAssertEqual(BigInt(int: 106206), a)
        XCTAssertEqual(BigInt(int: -47748739), b)
    }
    
    func testAdditionOperator() {
        let a = BigInt(int: 53103)
        let b = BigInt(int: 53103)
        let c = BigInt(int: -47801842)
        XCTAssertEqual(BigInt(int: 106206), a + b)
        XCTAssertEqual(BigInt(int: 106206), a + a)
        XCTAssertEqual(BigInt(int: -47748739), a + c)
    }
    
    func testAdditionAssignOperator() {
        var a = BigInt(int: 53103)
        var b = BigInt(int: 53103)
        let c = BigInt(int: -47801842)
        a += b
        b += c
        XCTAssertEqual(BigInt(int: 106206), a)
        XCTAssertEqual(BigInt(int: -47748739), b)
    }
    
    func testNegation() {
        let a = BigInt(int: 53103)
        let b = BigInt(int: -47801842)
        XCTAssertEqual(BigInt(int: -53103), a.negation)
        XCTAssertEqual(BigInt(int: 47801842), b.negation)
    }
    
    func testNegateInPlace() {
        var a = BigInt(int: 53103)
        var b = BigInt(int: -47801842)
        a.negateInPlace()
        b.negateInPlace()
        XCTAssertEqual(BigInt(int: -53103), a)
        XCTAssertEqual(BigInt(int: 47801842), b)
    }
    
    func testNegationOperator() {
        let a = BigInt(int: 53103)
        let b = BigInt(int: -47801842)
        XCTAssertEqual(BigInt(int: -53103), -a)
        XCTAssertEqual(BigInt(int: 47801842), -b)
    }
    
    func testSubtract() {
        let a = BigInt(int: 53103)
        let b = BigInt(int: 53103)
        let c = BigInt(int: -47801842)
        XCTAssertEqual(BigInt(int: 0), a.subtract(b))
        XCTAssertEqual(BigInt(int: 0), a.subtract(a))
        XCTAssertEqual(BigInt(int: 47854945), a.subtract(c))
    }
    
    func testSubtractInPlace() {
        var a = BigInt(int: 53103)
        var b = BigInt(int: 53103)
        let c = BigInt(int: -47801842)
        a.subtractInPlace(b)
        b.subtractInPlace(c)
        XCTAssertEqual(BigInt(int: 0), a)
        XCTAssertEqual(BigInt(int: 47854945), b)
    }
    
    func testSubtractionOperator() {
        let a = BigInt(int: 53103)
        let b = BigInt(int: 53103)
        let c = BigInt(int: -47801842)
        XCTAssertEqual(BigInt(int: 0), a - b)
        XCTAssertEqual(BigInt(int: 0), a - a)
        XCTAssertEqual(BigInt(int: 47854945), a - c)
    }
    
    func testSubtractionAssignOperator() {
        var a = BigInt(int: 53103)
        var b = BigInt(int: 53103)
        let c = BigInt(int: -47801842)
        a -= b
        b -= c
        XCTAssertEqual(BigInt(int: 0), a)
        XCTAssertEqual(BigInt(int: 47854945), b)
    }
    
    func testMultiply() {
        let a = BigInt(int: 53103)
        let b = BigInt(int: 0)
        let c = BigInt(int: -47801842)
        XCTAssertEqual(BigInt(int: 0), a.multiply(b))
        XCTAssertEqual(BigInt(int: 2819928609), a.multiply(a))
        XCTAssertEqual(BigInt(int: -2538421215726), a.multiply(c))
    }
    
    func testMultiplyInPlace() {
        var a = BigInt(int: 53103)
        let b = BigInt(int: 0)
        var c = BigInt(int: -47801842)
        let d = BigInt(int: 53103)
        a.multiplyInPlace(b)
        c.multiplyInPlace(d)
        XCTAssertEqual(BigInt(int: 0), a)
        XCTAssertEqual(BigInt(int: -2538421215726), c)
    }
    
    func testMultiplicationOperator() {
        let a = BigInt(int: 53103)
        let b = BigInt(int: 0)
        let c = BigInt(int: -47801842)
        XCTAssertEqual(BigInt(int: 0), a * b)
        XCTAssertEqual(BigInt(int: 2819928609), a * a)
        XCTAssertEqual(BigInt(int: -2538421215726), a * c)
    }
    
    func testMultiplicationAssignOperator() {
        var a = BigInt(int: 53103)
        let b = BigInt(int: 0)
        var c = BigInt(int: -47801842)
        let d = BigInt(int: 53103)
        a *= b
        c *= d
        XCTAssertEqual(BigInt(int: 0), a)
        XCTAssertEqual(BigInt(int: -2538421215726), c)
    }
    
    func testDivide() {
        let a = BigInt(int: 53103)
        let b = BigInt(int: 0)
        let c = BigInt(int: -47801842)
        XCTAssertEqual(BigInt(int: 0), b.divide(a))
        XCTAssertEqual(BigInt(int: 1), a.divide(a))
        XCTAssertEqual(BigInt(int: -1), a.divide(c))
        XCTAssertEqual(BigInt(int: -901), c.divide(a))
    }
    
    func testDivideInPlace() {
        let a = BigInt(int: 53103)
        var b = BigInt(int: 0)
        var c = BigInt(int: -47801842)
        c.divideInPlace(a)
        b.divideInPlace(a)
        XCTAssertEqual(BigInt(int: -901), c)
        XCTAssertEqual(BigInt(int: 0), b)
    }
    
    func testDivisionOperator() {
        let a = BigInt(int: 53103)
        let b = BigInt(int: 0)
        let c = BigInt(int: -47801842)
        XCTAssertEqual(BigInt(int: 0), b / a)
        XCTAssertEqual(BigInt(int: 1), a / a)
        XCTAssertEqual(BigInt(int: -1), a / c)
        XCTAssertEqual(BigInt(int: -901), c / a)
    }
    
    func testDivisionAssignOperator() {
        let a = BigInt(int: 53103)
        var b = BigInt(int: 0)
        var c = BigInt(int: -47801842)
        c /= a
        b /= a
        XCTAssertEqual(BigInt(int: -901), c)
        XCTAssertEqual(BigInt(int: 0), b)
    }
    
    func testAbsoluteValue() {
        let a = BigInt(int: 53103)
        let b = BigInt(int: 0)
        let c = BigInt(int: -47801842)
        XCTAssertEqual(BigInt(int: 53103), a.absoluteValue)
        XCTAssertEqual(BigInt(int: 0), b.absoluteValue)
        XCTAssertEqual(BigInt(int: 47801842), c.absoluteValue)
    }
    
    func testAbsoluteValueInPlace() {
        var a = BigInt(int: 53103)
        var b = BigInt(int: 0)
        var c = BigInt(int: -47801842)
        a.absoluteValueInPlace()
        b.absoluteValueInPlace()
        c.absoluteValueInPlace()
        XCTAssertEqual(BigInt(int: 53103), a)
        XCTAssertEqual(BigInt(int: 0), b)
        XCTAssertEqual(BigInt(int: 47801842), c)
    }
    
    func testAbs() {
        let a = BigInt(int: 53103)
        let b = BigInt(int: 0)
        let c = BigInt(int: -47801842)
        XCTAssertEqual(BigInt(int: 53103), abs(a))
        XCTAssertEqual(BigInt(int: 0), abs(b))
        XCTAssertEqual(BigInt(int: 47801842), abs(c))
    }
    
    func testSquareRoot() {
        var a = BigInt(int: 53103)
        XCTAssertEqual(a.squareRoot, BigInt(int: 230))
        
        a = 0
        XCTAssertEqual(a.squareRoot, BigInt(int: 0))
    }
    
    func testSquareRootInPlace() {
        var a = BigInt(int: 53103)
        a.squareRootInPlace()
        XCTAssertEqual(a, BigInt(int: 230))
        
        a = 0
        a.squareRootInPlace()
        XCTAssertEqual(a, BigInt(int: 0))
    }
    
    func testPowerModulo() {
        let a = BigInt(int: 53103)
        let b = BigInt(int: 234311)
        let mod = BigInt(int: 1_000_000_000_000)
        XCTAssertEqual(BigInt(uint: 919_447_180_047), a.power(b, modulo: mod))
    }
    
    func testPowerModuloInPlace() {
        var a = BigInt(int: 53103)
        let b = BigInt(int: 234311)
        let mod = BigInt(int: 1_000_000_000_000)
        a.powerInPlace(b, modulo: mod)
        XCTAssertEqual(BigInt(uint: 919_447_180_047), a)
    }
    
    func testPower() {
        let a = BigInt(int: 53103)
        XCTAssertEqual(a.power(32), BigInt(string: "15988577176268060579004931089547253337461076707270626303439766786870881752448879429300926345888658367621823487912941530168589176115215538579849129034241"))
    }
    
    func testPowerInPlace() {
        var a = BigInt(int: 53103)
        a.powerInPlace(32)
        XCTAssertEqual(a, BigInt(string: "15988577176268060579004931089547253337461076707270626303439766786870881752448879429300926345888658367621823487912941530168589176115215538579849129034241"))
    }
    
    func testFactorial() {
        for (n, f_n) in [1, 1, 2, 6, 24, 120, 720, 5040, 40320, 362880, 3628800, 39916800, 479001600, 6227020800, 87178291200, 1307674368000, 20922789888000, 355687428096000, 6402373705728000, 121645100408832000, 2432902008176640000].enumerated() {
            XCTAssertEqual(BigInt.factorial(UInt(n)), BigInt(int: f_n))
        }
        XCTAssertEqual(BigInt.factorial(21), BigInt(string: "51090942171709440000"))
        XCTAssertEqual(BigInt.factorial(22), BigInt(string: "1124000727777607680000"))
    }
    
    func testDoubleFactorial() {
        for (n, f_n) in [1, 1, 2, 3, 8, 15, 48, 105, 384, 945, 3840, 10395, 46080, 135135, 645120, 2027025, 10321920, 34459425, 185794560, 654729075, 3715891200, 13749310575, 81749606400, 316234143225, 1961990553600, 7905853580625, 51011754393600].enumerated() {
            XCTAssertEqual(BigInt.doubleFactorial(UInt(n)), BigInt(int: f_n))
        }
    }
    
    func testMultiFactorial() {
        for (n, f_n) in [1, 1, 2, 3, 4, 10, 18, 28, 80, 162, 280, 880, 1944, 3640, 12320, 29160, 58240, 209440, 524880, 1106560, 4188800, 11022480, 24344320, 96342400, 264539520, 608608000, 2504902400, 7142567040, 17041024000, 72642169600].enumerated() {
            XCTAssertEqual(BigInt.factorial(UInt(n), multi: 3), BigInt(int: f_n))
        }
        for (n, f_n) in [1, 1, 2, 3, 4, 5, 12, 21, 32, 45, 120, 231, 384, 585, 1680, 3465, 6144, 9945, 30240, 65835, 122880, 208845, 665280, 1514205, 2949120, 5221125, 17297280, 40883535, 82575360, 151412625, 518918400, 1267389585, 2642411520, 4996616625].enumerated() {
            XCTAssertEqual(BigInt.factorial(UInt(n), multi: 4), BigInt(int: f_n))
        }
    }
    
    func testGCD() {
        XCTAssertEqual(BigInt.gcd(0, 0), BigInt(int: 0))
        XCTAssertEqual(BigInt.gcd(20, 10), BigInt(int: 10))
        XCTAssertEqual(BigInt.gcd(20, -10), BigInt(int: 10))
        XCTAssertEqual(BigInt.gcd(123123123123, 123123123123123123), BigInt(int: 123123))
        XCTAssertEqual(BigInt.gcd(-123123123123, 123123123123123123), BigInt(int: 123123))
        XCTAssertEqual(BigInt.gcd(37279462087332, 366983722766), BigInt(int: 564958))
    }
    
    func testGCDInPlace() {
        var a = BigInt(int: 0)
        a.gcdInPlace(0)
        XCTAssertEqual(a, BigInt(int: 0))
        
        a = 20
        a.gcdInPlace(10)
        XCTAssertEqual(a, BigInt(int: 10))
        
        a = -20
        a.gcdInPlace(10)
        XCTAssertEqual(a, BigInt(int: 10))
        
        a = 37279462087332
        a.gcdInPlace(366983722766)
        XCTAssertEqual(a, BigInt(int: 564958))
    }
    
    
    // MARK: SetCompliant tests
    
    func testIsNatural() {
        let a = BigInt(int: 53103)
        let b = BigInt(int: 0)
        let c = BigInt(int: -47801842)
        XCTAssertTrue(a.isNatural)
        XCTAssertTrue(b.isNatural)
        XCTAssertFalse(c.isNatural)
    }
    
}
