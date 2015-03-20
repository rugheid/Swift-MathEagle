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
    
    
    func testGCD() {
        
        XCTAssertEqual(1 as UInt, gcd(0, 5))
        XCTAssertEqual(1 as UInt, gcd(13, 5))
        XCTAssertEqual(10 as UInt, gcd(20, 10))
        XCTAssertEqual(5 as UInt, gcd(34510, 431195))
        XCTAssertEqual(2 as UInt, gcd(33234, 58798))
    }
    
    
    func testFactorial() {
        
        let fact = Vector(length: 10, generator: factorial)
        let expected = Vector([1, 1, 2, 6, 24, 120, 720, 5_040, 40_320, 362_880])
        
        XCTAssertEqual(expected, fact)
    }
    
}