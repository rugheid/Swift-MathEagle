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
        
        var perm = Permutation(arrayRepresentation: [1, 4, 3, 2, 0])
        
        var cycles = Set<Cycle>()
        cycles.insert(Cycle([0, 1, 4]))
        cycles.insert(Cycle([2, 3]))
        
        XCTAssertEqual(cycles, perm.cycles)
        
        
        perm = Permutation(arrayRepresentation: [3, 1, 6, 5, 4, 7, 0, 2])
        
        cycles = []
        cycles.insert(Cycle([0, 3, 5, 7, 2, 6]))
        cycles.insert(Cycle([1]))
        cycles.insert(Cycle([4]))
        
        XCTAssertEqual(cycles, perm.cycles)
    }
    
    
    func testGetFixedPoints() {
        
        var perm = Permutation(arrayRepresentation: [3, 1, 6, 5, 4, 7, 0, 2])
        XCTAssertEqual([1, 4], perm.fixedPoints)
        
        perm = Permutation()
        XCTAssertEqual([], perm.fixedPoints)
        
        perm = Permutation(arrayRepresentation: [1, 4, 3, 2, 0])
        XCTAssertEqual([], perm.fixedPoints)
    }
    
    
    func testGetNumberOfFixedPoints() {
        
        var perm = Permutation(arrayRepresentation: [3, 1, 6, 5, 4, 7, 0, 2])
        XCTAssertEqual(2, perm.numberOfFixedPoints)
        
        perm = Permutation()
        XCTAssertEqual(0, perm.numberOfFixedPoints)
        
        perm = Permutation(arrayRepresentation: [1, 4, 3, 2, 0])
        XCTAssertEqual(0, perm.numberOfFixedPoints)
    }
    
    
    func testGetParity() {
        
        var perm = Permutation(arrayRepresentation: [3, 1, 6, 5, 4, 7, 0, 2])
        XCTAssertEqual(.Odd, perm.parity)
        
        perm = Permutation()
        XCTAssertEqual(.Even, perm.parity)
        
        perm = Permutation(arrayRepresentation: [1, 4, 3, 2, 0])
        XCTAssertEqual(.Odd, perm.parity)
    }
    
    
    func testGetSign() {
        
        var perm = Permutation(arrayRepresentation: [3, 1, 6, 5, 4, 7, 0, 2])
        XCTAssertEqual(-1, perm.sign)
        
        perm = Permutation()
        XCTAssertEqual(1, perm.sign)
        
        perm = Permutation(arrayRepresentation: [1, 4, 3, 2, 0])
        XCTAssertEqual(-1, perm.sign)
    }
}
