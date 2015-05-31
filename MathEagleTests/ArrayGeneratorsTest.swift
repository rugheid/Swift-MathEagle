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
        
        XCTAssertEqual([2, 5, 8, 11], rampedArray(length: 4, initialValue: 2, increment: 3))
        XCTAssertEqual([], rampedArray(length: 0, initialValue: 2, increment: 3))
        XCTAssertEqual([2.0, 5.0, 8.0, 11.0], rampedArray(length: 4, initialValue: 2.0, increment: 3.0))
        XCTAssertEqual([10, 9, 8, 7, 6], rampedArray(length: 5, initialValue: 10, increment: -1))
        XCTAssertEqual([3, 4, 5, 6], rampedArray(length: 4, initialValue: 3))
    }
    
}