//
//  FunctionsTests.swift
//  SwiftMath
//
//  Created by Rugen Heidbuchel on 27/01/15.
//  Copyright (c) 2015 Jorestha Solutions. All rights reserved.
//

import Cocoa
import XCTest
import MathEagle

class FunctionsTests: XCTestCase {
    
    
    func testSign() {
        
        var x = -1.2
        XCTAssertEqual(-1, sign(x))
        
        x = 3.4
        XCTAssertEqual(1, sign(x))
        
        x = 0
        XCTAssertEqual(0, sign(x))
    }
    
    
    func testAbs() {
        
        XCTAssertEqualWithAccuracy(2.3, abs(2.3), accuracy: 0)
        XCTAssertEqualWithAccuracy(2.3, abs(-2.3), accuracy: 0)
        XCTAssertEqualWithAccuracy(0.0, abs(0.0), accuracy: 0)
        var x = 2
        XCTAssertEqual(2, abs(x))
        XCTAssertEqual(2, abs(-x))
        x = 0
        XCTAssertEqual(0, abs(x))
        
        var y: Float = 2.3
        XCTAssertEqualWithAccuracy(2.3, abs(y), accuracy: 0)
        y = -2.3
        XCTAssertEqualWithAccuracy(2.3, abs(y), accuracy: 0)
        y = 0
        XCTAssertEqual(0, abs(y))
    }
    
    
    func testFactorial() {
        
        let fact = Vector(length: 10, generator: factorial)
        let expected = Vector([1, 1, 2, 6, 24, 120, 720, 5_040, 40_320, 362_880])
        
        XCTAssertEqual(expected, fact)
    }
    
    
    func testFactorialsUpTo() {
        
        XCTAssertEqual([1, 1, 2, 6, 24, 120, 720, 5_040, 40_320, 362_880], factorialsUpTo(9))
        XCTAssertEqual([1.0, 1, 2, 6, 24, 120, 720, 5_040, 40_320, 362_880], factorialsUpTo(9.5))
        XCTAssertEqual([1], factorialsUpTo(0))
        XCTAssertEqual([], factorialsUpTo(-1))
        XCTAssertEqual([], factorialsUpTo(-1.23))
    }
    
    
    func testFib() {
        
        let fibonacci = Vector(length: 11, generator: fib)
        let expected = Vector([0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55])
        
        XCTAssertEqual(expected, fibonacci)
        
        XCTAssertEqual(832_040, fib(30))
    }
    
    
    func testFibPerformance() {
        
        let (a, b) = getCoefficients(n0: 5, numberOfIterations: 4){ x in
            
            return timeBlock(n: 40){
                
                fib(x)
            }
        }
        
        print("")
        print("Fibonacci: \(a)*n^\(b)")
        print("")
    }
    
    
    func testGamma() {
        
        XCTAssertEqualWithAccuracy(gamma(3.0), 2.0, accuracy: 10 ** -7)
        XCTAssertEqualWithAccuracy(gamma(2.5), 1.3293403881791370204736256125058588870981620920917903, accuracy: 10 ** -7)
        XCTAssertEqualWithAccuracy(gamma(-2.3749), -1.17168614897932682180740075479679861986782655946903, accuracy: 10 ** -7)
    }
    
    
    func testEulerTotient() {
        
        let values: [UInt] = [0, 1, 1, 2, 2, 4, 2, 6, 4, 6, 4, 10, 4, 12, 6, 8, 8, 16, 6, 18, 8, 12, 10, 22, 8, 20, 12, 18, 12, 28, 8, 30, 16, 20, 16, 24, 12, 36, 18, 24, 16, 40, 12, 42, 20, 24, 22, 46, 16, 42, 20, 32, 24, 52, 18, 40, 24, 36, 28, 58, 16, 60, 30, 36, 32, 48, 20, 66, 32, 44]
        for (n, phi) in values.enumerated() {
            XCTAssertEqual(eulerTotient(UInt(n)), phi)
        }
    }
    
}
