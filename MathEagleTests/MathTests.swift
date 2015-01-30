//
//  MathTests.swift
//  SwiftMath
//
//  Created by Rugen Heidbuchel on 26/01/15.
//  Copyright (c) 2015 Jorestha Solutions. All rights reserved.
//

import Cocoa
import XCTest

class MathTests: XCTestCase {
    
    
    // MARK: Basic Functions Tests
    
    func testSignFunction() {
        
        var x = -1.2
        XCTAssertEqual(-1, sign(x))
        
        x = 3.4
        XCTAssertEqual(1, sign(x))
        
        x = 0
        XCTAssertEqual(0, sign(x))
    }
    
}