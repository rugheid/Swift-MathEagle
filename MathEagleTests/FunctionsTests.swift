//
//  FunctionsTests.swift
//  SwiftMath
//
//  Created by Rugen Heidbuchel on 27/01/15.
//  Copyright (c) 2015 Jorestha Solutions. All rights reserved.
//

import Cocoa
import XCTest

class FunctionsTests: XCTestCase {
    
    
    func testSign() {
        
        var x = -1.2
        XCTAssertEqual(-1, sign(x))
        
        x = 3.4
        XCTAssertEqual(1, sign(x))
        
        x = 0
        XCTAssertEqual(0, sign(x))
    }
    
    
    func testDivisors() {
        
        XCTAssertEqual([1, 5], divisors(5))
        XCTAssertEqual([1, 2, 4, 5, 10, 20], divisors(20))
        XCTAssertEqual([1, 2, 4, 5, 8, 10, 20, 25, 40, 50, 100, 125, 200, 250, 500, 1000], divisors(1000))
    }
    
    
    func testProperDivisors() {
        
        XCTAssertEqual([1], properDivisors(5))
        XCTAssertEqual([1, 2, 4, 5, 10], properDivisors(20))
        XCTAssertEqual([1, 2, 4, 5, 8, 10, 20, 25, 40, 50, 100, 125, 200, 250, 500], properDivisors(1000))
    }
    
    
    func testGCD() {
        
        XCTAssertEqual(5, gcd(0, 5))
        XCTAssertEqual(5, gcd(5, 0))
        XCTAssertEqual(0, gcd(0, 0))
        XCTAssertEqual(1, gcd(13, 5))
        XCTAssertEqual(10, gcd(20, 10))
        XCTAssertEqual(5, gcd(34510, 431195))
        XCTAssertEqual(2, gcd(33234, 58798))
    }
    
    
    func testFactorial() {
        
        let fact = Vector(length: 10, generator: factorial)
        let expected = Vector([1, 1, 2, 6, 24, 120, 720, 5_040, 40_320, 362_880])
        
        XCTAssertEqual(expected, fact)
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
        
        println()
        println("Fibonacci: \(a)*n^\(b)")
        println()
    }
    
}