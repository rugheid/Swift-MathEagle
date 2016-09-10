//
//  CycleTest.swift
//  MathEagle
//
//  Created by Rugen Heidbuchel on 31/05/15.
//  Copyright (c) 2015 Jorestha Solutions. All rights reserved.
//

import Cocoa
import XCTest
import MathEagle

class CycleTest: XCTestCase {

    
    // MARK: Properties
    
    func testDictionaryRepresentation() {
        
        var cycle = Cycle([3, 4, 7])
        XCTAssertEqual([3: 4, 4: 7, 7: 3], cycle.dictionaryRepresentation)
        
        cycle = Cycle()
        XCTAssertEqual([Int: Int](), cycle.dictionaryRepresentation)
        
        cycle = Cycle([5])
        XCTAssertEqual([5: 5], cycle.dictionaryRepresentation)
    }
    
    
    func testLength() {
        
        var cycle = Cycle([3, 4, 7])
        XCTAssertEqual(3, cycle.length)
        
        cycle = Cycle()
        XCTAssertEqual(0, cycle.length)
        
        cycle = Cycle([5])
        XCTAssertEqual(1, cycle.length)
    }
    
    
    func testParity() {
        
        var cycle = Cycle([3, 4, 7])
        XCTAssertEqual(Parity.even, cycle.parity)
        
        cycle = Cycle()
        XCTAssertEqual(Parity.odd, cycle.parity)
        
        cycle = Cycle([5])
        XCTAssertEqual(Parity.even, cycle.parity)

    }
    
    
    func testDescription() {
        
        var cycle = Cycle([3, 4, 7])
        XCTAssertEqual("(3 4 7)", cycle.description)
        
        cycle = Cycle()
        XCTAssertEqual("()", cycle.description)
        
        cycle = Cycle([5])
        XCTAssertEqual("(5)", cycle.description)
    }
    
    
    
    // MARK: Operators
    
    func testEquality() {
        
        var a = Cycle([3, 4, 7])
        var b = Cycle([3, 4, 7])
        XCTAssertEqual(a, b)
        
        b = Cycle()
        XCTAssertNotEqual(a, b)
        
        a = Cycle()
        XCTAssertEqual(a, b)
    }

}
