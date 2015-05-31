//
//  ArrayGeneratorsTest.swift
//  MathEagle
//
//  Created by Rugen Heidbuchel on 31/05/15.
//  Copyright (c) 2015 Jorestha Solutions. All rights reserved.
//

import XCTest
import MathEagle

class ArrayGeneratorTest: XCTestCase {
    
    
    func testRampedArray() {
        
        XCTAssertEqual([2, 5, 8, 11], rampedArray(initialValue: 2, increment: 3, length: 4))
        XCTAssertEqual([], rampedArray(initialValue: 2, increment: 3, length: 0))
        XCTAssertEqual([2.0, 5.0, 8.0, 11.0], rampedArray(initialValue: 2.0, increment: 3.0, length: 4))
        XCTAssertEqual([10, 9, 8, 7, 6], rampedArray(initialValue: 10, increment: -1, length: 5))
    }
    
}