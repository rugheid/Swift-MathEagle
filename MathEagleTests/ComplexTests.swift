//
//  ComplexTests.swift
//  MathEagle
//
//  Created by Rugen Heidbuchel on 06/03/15.
//  Copyright (c) 2015 Jorestha Solutions. All rights reserved.
//

import Cocoa
import XCTest
import MathEagle
import Accelerate

class ComplexTests: XCTestCase {
    let ACCURACY = 10.0 ** -7
    // MARK: General Test
    func testGeneralComplexMath() {
        let i = Complex.imaginaryUnit
        let x = -3.0 + 4.5*i
        let y = -5.0 + 2.8*i
        let z = 1.0 + 2.0*i
        print("\n\n\n", terminator: "")
        print("x = \(x)")
        print("y = \(y)")
        print("z = \(z)")
        print("x + y = \(x+y)")
        print("x * y = \(x*y)")
        print("e^z = \(exp(z))")
        print("sqrt(z) = \(sqrt(z))")
        print("\n\n\n", terminator: "")
    }
    // MARK: Initialisation
    func testComplexInit1() {
        let a = Complex(1, 2)
        XCTAssertEqual(1, a.real)
        XCTAssertEqual(2, a.imaginary)
        let b = Complex(-2.3, 23.56)
        XCTAssertEqual(-2.3, b.real)
        XCTAssertEqual(23.56, b.imaginary)
        let c = Complex(b)
        XCTAssertEqual(-2.3, c.real)
        XCTAssertEqual(23.56, c.imaginary)
        
    }
    func testComplexInit2() {
        let z = Complex(modulus: 2.0, argument: PI/2)
        XCTAssertEqual(0, z.real, accuracy: ACCURACY)
        XCTAssertEqual(2, z.imaginary, accuracy: ACCURACY)
    }
    func testComplexInit3() {
        let a:Complex = 2
        XCTAssertEqual(2, a.real)
        XCTAssertEqual(0, a.imaginary)
        let b = Complex(integerLiteral:2)
        XCTAssertEqual(2, b.real)
        XCTAssertEqual(0, b.imaginary)
        XCTAssertEqual(a,b)
    }
    func testComplexInit4() {
        let a:Complex = 2.0
        XCTAssertEqual(2.0, a.real)
        XCTAssertEqual(0.0, a.imaginary)
        let b = Complex(floatLiteral:2.0)
        XCTAssertEqual(2.0, b.real)
        XCTAssertEqual(0.0, b.imaginary)
        XCTAssertEqual(a,b)
        let c = Complex(floatLiteral:2)
        XCTAssertEqual(2.0, c.real)
        XCTAssertEqual(0.0, c.imaginary)
        XCTAssertEqual(a,c)
    }
    func testComplexInit5() {
        let i = Complex.imaginaryUnit
        XCTAssertEqual(0, i.real)
        XCTAssertEqual(1, i.imaginary)
        let j = Complex(0,1)
        XCTAssertEqual(i,j)
    }
    // MARK: Basic Properties
    func testComplexModulus() {
        var z = Complex(1, 2)
        XCTAssertEqual(sqrt(5), z.modulus, accuracy: ACCURACY)
        z = Complex(-2, -2)
        XCTAssertEqual(sqrt(8), z.modulus, accuracy: ACCURACY)
    }
    func testComplexArgument() {
        var z = Complex(1, 2)
        XCTAssertEqual(atan(2), z.argument, accuracy: ACCURACY)
        z = Complex(-2, -2)
        XCTAssertEqual(-3*PI/4, z.argument, accuracy: ACCURACY)
        z = Complex(0, 0)
        XCTAssertEqual(0, z.argument)
    }
    func testComplexConjugate() {
        var z = Complex(1, 2)
        XCTAssertEqual(1, z.conjugate.real)
        XCTAssertEqual(-2, z.conjugate.imaginary)
        XCTAssertNotEqual(z, z.conjugate)
        XCTAssertEqual(1, z.conjugate.conjugate.real)
        XCTAssertEqual(2, z.conjugate.conjugate.imaginary)
        XCTAssertEqual(z, z.conjugate.conjugate)
        z = Complex(1, 0)
        XCTAssertEqual(1, z.conjugate.real)
        XCTAssertEqual(0, z.conjugate.imaginary)
        XCTAssertEqual(z, z.conjugate)
        XCTAssertEqual(z, z.conjugate.conjugate)
    }
    func testComplexQuadrant() {
        XCTAssertEqual(Complex(0,0).quadrant,Quadrant.first)
        XCTAssertEqual(Complex(1,0).quadrant,Quadrant.first)
        XCTAssertEqual(Complex(1,1).quadrant,Quadrant.first)
        XCTAssertEqual(Complex(0,1).quadrant,Quadrant.second)
        XCTAssertEqual(Complex(-1,1).quadrant,Quadrant.second)
        XCTAssertEqual(Complex(-1,0).quadrant,Quadrant.third)
        XCTAssertEqual(Complex(-1,-1).quadrant,Quadrant.third)
        XCTAssertEqual(Complex(0,-1).quadrant,Quadrant.fourth)
        XCTAssertEqual(Complex(1,-1).quadrant,Quadrant.fourth)
        XCTAssertEqual(Complex(1,2).quadrant,Quadrant.first)
        XCTAssertEqual(Complex(-1,2).quadrant,Quadrant.second)
        XCTAssertEqual(Complex(-1,-2).quadrant,Quadrant.third)
        XCTAssertEqual(Complex(1,-2).quadrant,Quadrant.fourth)
    }
    func testComplexDescription() {
        // Test documents current behavior of ".description"
        var z = Complex(1, 2)
        XCTAssertEqual(z.description,"1.0 + 2.0i")
        z = Complex(1, -2)
        XCTAssertEqual(z.description,"1.0 - 2.0i")
        z = Complex(0, 0)
        XCTAssertEqual(z.description,"0.0 + 0.0i")
        z = Complex(0, 1)
        XCTAssertEqual(z.description,"0.0 + 1.0i")
        z = Complex(0, -1)
        XCTAssertEqual(z.description,"0.0 - 1.0i")
        z = Complex(1, 0)
        XCTAssertEqual(z.description,"1.0 + 0.0i")
        z = Complex(-1, 0)
        XCTAssertEqual(z.description,"-1.0 + 0.0i")
    }
    // MARK: SetCompliant Protocol
    func testComplexSetConformance() {
        var z = Complex(1, 2)
        XCTAssertFalse(z.isNatural)
        XCTAssertFalse(z.isInteger)
        XCTAssertFalse(z.isReal)
        z = Complex(3, 0)
        XCTAssert(z.isNatural)
        XCTAssert(z.isInteger)
        XCTAssert(z.isReal)
        z = Complex(-3, 0)
        XCTAssertFalse(z.isNatural)
        XCTAssert(z.isInteger)
        XCTAssert(z.isReal)
        z = Complex(PI, 0)
        XCTAssertFalse(z.isNatural)
        XCTAssertFalse(z.isInteger)
        XCTAssert(z.isReal)
    }
    // MARK: Fuzzy Equality
    func testComplexEquality() {
        let z = Complex(1, 2)
        XCTAssertEqual(Complex(1, 2), z)
        let a = Complex(1, 2)
        let b = Complex(1+ACCURACY/10, 2-ACCURACY/10)
        XCTAssert(a.equals(a))
        XCTAssertFalse(a.equals(b))
        XCTAssert(a.equals(b,accuracy:ACCURACY))
    }
    // MARK: Randomizable Protocol
    func testComplexRandom1() {
        // Mostly proving the API exists
        let z = Complex.random()
        XCTAssert((z.real as Any) is Double)
        XCTAssert((z.imaginary as Any) is Double)
        // Astronomically unlikely to be true:
        XCTAssertFalse(z.isNatural)
        XCTAssertFalse(z.isInteger)
        XCTAssertFalse(z.isReal)
        XCTAssertNotEqual(z.real, 0)
        XCTAssertNotEqual(z.imaginary, 0)
        XCTAssertNotEqual(z.real, z.imaginary)
        // Create another random Complex for comparison
        let u = Complex.random()
        // Astronomically unlikely to be true:
        XCTAssertNotEqual(u,z)
    }
    func testComplexRandom2() {
        let a = Complex.randomArray(0)
        let b = Complex.randomArray(1)
        let c = Complex.randomArray(2)
        let d = Complex.randomArray(3)
        XCTAssert((a as Any) is [Complex])
        XCTAssert((b as Any) is [Complex])
        XCTAssert((c as Any) is [Complex])
        XCTAssert((d as Any) is [Complex])
        XCTAssertEqual(a.count,0)
        XCTAssertEqual(b.count,1)
        XCTAssertEqual(c.count,2)
        XCTAssertEqual(d.count,3)
        XCTAssert((d[0] as Any) is Complex)
        XCTAssert((d[1] as Any) is Complex)
        XCTAssert((d[2] as Any) is Complex)
        // Astronomically unlikely to be true:
        XCTAssertNotEqual(d[0],d[1])
        XCTAssertNotEqual(d[0],d[2])
        XCTAssertNotEqual(d[1],d[2])
    }
    // MARK: Function Extension
    func testComplexExp() {
        let z = exp(Complex(1, 2))
        XCTAssertEqual(exp(1) * cos(2), z.real, accuracy: ACCURACY)
        XCTAssertEqual(exp(1) * sin(2), z.imaginary, accuracy: ACCURACY)
    }
    func testComplexLog() {
        let z = log(Complex(exp(1) * cos(2),exp(1) * sin(2)))
        XCTAssertEqual(1, z.real, accuracy: ACCURACY)
        // For general example z, we should compare modulo 2*PI .
        XCTAssertEqual(2, z.imaginary, accuracy: ACCURACY)
    }
    // MARK: Equatable Protocol
    func testComplexEquatable() {
        let z = Complex(1, 2)
        let x = Complex(3, -5)
        XCTAssert(z == z)
        XCTAssert(x == x)
        XCTAssertFalse(z == x)
        XCTAssertFalse(x == z)
    }
    // MARK: Comparable Protocol
    func testComplexComparable() {
        let z = Complex(1, 2)
        let x = Complex(3, -5)
        XCTAssertFalse(z < x)
        XCTAssertFalse(x > z)
        XCTAssertFalse(z > z)
    }
    // MARK: Addable Protocol
    func testComplexAddable() {
        let z = Complex(1, 2)
        let x = Complex(-1, 3.4)
        XCTAssertEqual(Complex(0, 5.4), z + x)
        XCTAssertEqual(2.0 + z, Complex(3, 2))
        XCTAssertEqual(z + 2.0, Complex(3, 2))
        XCTAssertEqual(2 + z, Complex(3, 2))
        XCTAssertEqual(z + 2, Complex(3, 2))
        var y = z
        y += x
        XCTAssertEqual(Complex(0, 5.4), y)
    }
    // MARK: Negatable Protocol
    func testComplexNegatable() {
        let z = Complex(1, 2)
        XCTAssertEqual(Complex(-1, -2), -z)
        XCTAssertNotEqual(z, -z)
        XCTAssertEqual(z, -(-z))
    }
    // MARK: Subtractable Protocol
    func testComplexSubtractable() {
        let z = Complex(1, 2)
        let x = Complex(-1, 3.4)
        XCTAssertEqual(Complex(2, -1.4), z - x)
        XCTAssertEqual(2.0 - z, Complex(1, -2))
        XCTAssertEqual(z - 2.0, Complex(-1, 2))
        XCTAssertEqual(2 - z, Complex(1, -2))
        XCTAssertEqual(z - 2, Complex(-1, 2))
    }
    // MARK: Multiplicable Protocol
    func testComplexMultiplicable() {
        let z = Complex(1, 2)
        let x = Complex(-1, 3.4)
        XCTAssertEqual(Complex(-7.8, 1.4), z * x)
        XCTAssertEqual(Complex(-7.8, 1.4), x * z)
        XCTAssertEqual(2.0 * z, Complex(2, 4))
        XCTAssertEqual(z * 2.0, Complex(2, 4))
        XCTAssertEqual(2 * z, Complex(2, 4))
        XCTAssertEqual(z * 2, Complex(2, 4))
        XCTAssertEqual(UInt(2) * z, Complex(2, 4))
        XCTAssertEqual(z * UInt(2), Complex(2, 4))
    }
    // MARK: Dividable Protocol
    func testComplexDivision() {
        let z = Complex(1, 2)
        let x = Complex(-1, 3.4)
        XCTAssert(Complex(5.8/12.56, -5.4/12.56).equals(z / x, accuracy: ACCURACY))
    }
    // MARK: Powers
    func testComplexPowers() {
        XCTAssert((Complex(0,0)**Complex(0.5,0)).equals(Complex(0,0), accuracy:ACCURACY))
        XCTAssert((Complex(-1,0)**Complex(0.5,0)).equals(Complex.imaginaryUnit, accuracy:ACCURACY))
        XCTAssert(((-1.0)**Complex(0.5,0)).equals(Complex.imaginaryUnit, accuracy:ACCURACY))
        XCTAssert((Complex.imaginaryUnit**(-1)).equals(Complex(0,-1), accuracy:ACCURACY))
        XCTAssert((Complex.imaginaryUnit**5).equals(Complex.imaginaryUnit, accuracy:ACCURACY))
        XCTAssert((Complex.imaginaryUnit**UInt(5)).equals(Complex.imaginaryUnit, accuracy:ACCURACY))
    }
}
