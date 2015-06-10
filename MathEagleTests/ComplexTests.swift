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

class ComplexTests: XCTestCase {
    
    let ACCURACY = 10.0 ** -7
    
    
    
    // MARK: General Test
    
    func testGeneralComplexMath() {
        
        let i = Complex.imaginaryUnit
        
        let x = -3.0 + 4.5*i
        let y = -5.0 + 2.8*i
        let z = 1.0 + 2.0*i
        
        print("\n\n\n", appendNewline: false)
        
        print("x = \(x)")
        print("y = \(y)")
        print("z = \(z)")
        print("x + y = \(x+y)")
        print("x * y = \(x*y)")
        print("e^z = \(exp(z))")
        print("sqrt(z) = \(sqrt(z))")
        
        print("\n\n\n", appendNewline: false)
    }

    
    // MARK: Init Tests
    
    func testRealImaginaryInit() {
        
        var z = Complex(1, 2)
        XCTAssertEqual(1, z.real)
        XCTAssertEqual(2, z.imaginary)
        
        z = Complex(-2.3, 23.56)
        XCTAssertEqual(-2.3, z.real)
        XCTAssertEqual(23.56, z.imaginary)
    }
    
    
    func testModulusArgumentInit() {
        
        let z = Complex(modulus: 2.0, argument: PI/2)
        XCTAssertEqualWithAccuracy(0, z.real, accuracy: ACCURACY)
        XCTAssertEqualWithAccuracy(2, z.imaginary, accuracy: ACCURACY)
    }
    
    
//    func testIntegerLiteralInit() {
//        
//        var z: Complex = 2
//        XCTAssertEqual(2, z.real)
//        XCTAssertEqual(0, z.imaginary)
//    }
    
    
    
    // MARK: Basic Properties Tests
    
    func testModulusAndArgument() {
        
        var z = Complex(1, 2)
        XCTAssertEqualWithAccuracy(sqrt(5), z.modulus, accuracy: ACCURACY)
        XCTAssertEqualWithAccuracy(atan(2), z.argument, accuracy: ACCURACY)
        
        z = Complex(-2, -2)
        XCTAssertEqualWithAccuracy(sqrt(8), z.modulus, accuracy: ACCURACY)
        XCTAssertEqualWithAccuracy(5*PI/4, z.argument, accuracy: ACCURACY)
    }
    
    
    func testQuadrant() {
        
        var z = Complex(1, 2)
        XCTAssertEqual(Quadrant.First, z.quadrant)
        
        z = Complex(-1, 2)
        XCTAssertEqual(Quadrant.Second, z.quadrant)
        
        z = Complex(-1, -2)
        XCTAssertEqual(Quadrant.Third, z.quadrant)
        
        z = Complex(1, -2)
        XCTAssertEqual(Quadrant.Fourth, z.quadrant)
    }
    
    
    
    // MARK: Function Extension Tests
    
    func testExp() {
        
        let z = exp(Complex(1, 2))
        
        XCTAssertEqualWithAccuracy(exp(1) * cos(2), z.real, accuracy: ACCURACY)
        XCTAssertEqualWithAccuracy(exp(1) * sin(2), z.imaginary, accuracy: ACCURACY)
    }
    
    
    
    // MARK: Test Operations
    
    func testEquality() {
        
        let z = Complex(1, 2)
        
        XCTAssertEqual(Complex(1, 2), z)
    }
    
    
    func testComparability() {
        
        let z = Complex(1, 2)
        let x = Complex(3, -5)
        
        XCTAssertTrue(z < x)
        XCTAssertTrue(x > z)
        XCTAssertFalse(z > z)
    }
    
    
    func testAddition() {
        
        let z = Complex(1, 2)
        let x = Complex(-1, 3.4)
        
        XCTAssertEqual(Complex(0, 5.4), z + x)
    }
    
    
    func testSubstracion() {
        
        let z = Complex(1, 2)
        let x = Complex(-1, 3.4)
        
        XCTAssertEqual(Complex(2, -1.4), z - x)
    }
    
    
    func testMultiplication() {
        
        let z = Complex(1, 2)
        let x = Complex(-1, 3.4)
        
        XCTAssertEqual(Complex(-7.8, 1.4), z * x)
        XCTAssertEqual(Complex(-7.8, 1.4), x * z)
    }
    
    
    func testDivision() {
        
        let z = Complex(1, 2)
        let x = Complex(-1, 3.4)
        
        XCTAssertTrue(Complex(5.8/12.56, -5.4/12.56).equals(z / x, accuracy: ACCURACY))
    }

}
