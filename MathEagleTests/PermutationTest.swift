//
//  PermutationTest.swift
//  MathEagle
//
//  Created by Rugen Heidbuchel on 29/05/15.
//  Copyright (c) 2015 Jorestha Solutions. All rights reserved.
//

import Cocoa
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
        
        let perm = Permutation(array)
        XCTAssertEqual(array, perm.arrayRepresentation)
    }
}
