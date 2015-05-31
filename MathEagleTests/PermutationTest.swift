//
//  PermutationTest.swift
//  MathEagle
//
//  Created by Rugen Heidbuchel on 29/05/15.
//  Copyright (c) 2015 Jorestha Solutions. All rights reserved.
//

import XCTest
import MathEagle

class PermutationTest: XCTestCase {

    
    // MARK: Initialisers
    
    func testInit() {
        
        let perm = Permutation()
        XCTAssertEqual(0, perm.length)
        XCTAssertEqual([], perm.arrayRepresentation)
        XCTAssertEqual("", perm.wordRepresentation)
    }
    
    
    func testInitArrayRepresentation() {
        
        let array = [0, 3, 2, 1]
        
        let perm = Permutation(arrayRepresentation: array)
        XCTAssertEqual(array, perm.arrayRepresentation)
    }
    
    
    
    // MARK: Properties
    
    func testGetCycles() {
        
//        var perm = Permutation(arrayRepresentation: [1, 4, 3, 2, 0])
//        
//        let cycle1 = Cycle(cycleRepresentation: [0, 1, 4])
//        let cycle2 = Cycle(cycleRepresentation: [2, 3])
//        var cycles = Set<Cycle>()
//        cycles.insert(cycle1)
//        cycles.insert(cycle2)
//        
//        XCTAssertEqual(cycles, perm.cycles)
    }
}
