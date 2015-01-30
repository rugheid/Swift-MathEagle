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
    
    
    func testFactorial() {
        
        let fact = Vector(length: 10, generator: factorial)
        let expected = Vector([1, 1, 2, 6, 24, 120, 720, 5_040, 40_320, 362_880])
        
        XCTAssertEqual(expected, fact)
    }
    
}