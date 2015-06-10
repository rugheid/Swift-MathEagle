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
    
    
    func testDigits() {
        
        XCTAssertEqual(digits(124387), [1, 2, 4, 3, 8, 7])
        XCTAssertEqual(digits(-234), [2, 3, 4])
        XCTAssertEqual(digits(0), [0])
    }
    
}