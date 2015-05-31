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

    
    // MARK: Initialisers
    
    
    
    // MARK: Overriden from Permutation
    
    func testOverridenArrayRepresentation() {
        
        var cycle = Cycle(cycleRepresentation: [0, 1, 2])
        XCTAssertEqual([1, 2, 0], cycle.arrayRepresentation)
        
        cycle = Cycle(cycleRepresentation: [2, 0, 1])
        XCTAssertEqual([1, 2, 0], cycle.arrayRepresentation)
    }
    

}
