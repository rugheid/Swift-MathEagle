//
//  ExtensionsTests.swift
//  SwiftMath
//
//  Created by Rugen Heidbuchel on 27/01/15.
//  Copyright (c) 2015 Jorestha Solutions. All rights reserved.
//

import Cocoa
import XCTest
import MathEagle

class ExtensionsTests: XCTestCase {
    
    
    func testIsNatural() {
        
        XCTAssertTrue(2.0.isNatural)
        XCTAssertTrue(0.0.isNatural)
        XCTAssertTrue(1023432.0.isNatural)
        XCTAssertFalse(1.4532.isNatural)
        XCTAssertFalse((-1.4532).isNatural)
        XCTAssertFalse((-1.0).isNatural)
    }
    
    func testIsInteger() {
        
        XCTAssertTrue(2.0.isInteger)
        XCTAssertTrue(0.0.isInteger)
        XCTAssertTrue((-2.0).isInteger)
        XCTAssertFalse(2.12.isInteger)
        XCTAssertFalse((-2.12).isInteger)
    }
    
}