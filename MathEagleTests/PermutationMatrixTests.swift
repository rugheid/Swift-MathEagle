//
//  PermutationMatrixTests.swift
//  MathEagle
//
//  Created by Rugen Heidbuchel on 01/06/15.
//  Copyright (c) 2015 Jorestha Solutions. All rights reserved.
//

import XCTest
import MathEagle


class PermutationMatrixTests: XCTestCase {
    
    
    
    // MARK: Initialisers
    
    func testInitWithPermutation() {
        
        var P = PermutationMatrix<Int>(permutation: [1, 0, 3, 2])
        XCTAssertEqual([1, 0, 3, 2], P.permutation)
        
        P = PermutationMatrix(permutation: [])
        XCTAssertEqual([], P.permutation)
    }
    
    
    
    // MARK: Properties
    
    func testDimensions() {
        
        var P = PermutationMatrix<Int>(permutation: [1, 0, 3, 2])
        XCTAssertEqual(Dimensions(size: 4), P.dimensions)
        
        P = PermutationMatrix(permutation: [])
        XCTAssertEqual(Dimensions(size: 0), P.dimensions)
    }
    
    
    func testElementsList() {
        
        var P = PermutationMatrix<Int>(permutation: [1, 0, 3, 2])
        XCTAssertEqual([0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0], P.elementsList)
        
        P = PermutationMatrix(permutation: [])
        XCTAssertEqual([], P.elementsList)
    }
    
    
    func testElements() {
        
        var P = PermutationMatrix<Int>(permutation: [1, 0, 3, 2])
        XCTAssertEqual([[0, 1, 0, 0], [1, 0, 0, 0], [0, 0, 0, 1], [0, 0, 1, 0]], P.elements)
        
        P = PermutationMatrix(permutation: [])
        XCTAssertEqual([[]], P.elements)
    }
    
    
    func testSize() {
        
        var P = PermutationMatrix<Int>(permutation: [1, 0, 3, 2])
        XCTAssertEqual(4, P.size)
        
        P = PermutationMatrix(permutation: [])
        XCTAssertEqual(0, P.size)
    }
    
    
    func testRank() {
        
        var P = PermutationMatrix<Int>(permutation: [1, 0, 3, 2])
        XCTAssertEqual(4, P.rank)
        
        P = PermutationMatrix(permutation: [])
        XCTAssertEqual(0, P.rank)
    }
    
    
    func testDeterminant() {
        
        var P = PermutationMatrix<Int>(permutation: [1, 0, 3, 2])
        XCTAssertEqual(1, P.determinant)
    }
    
    
    func testDiagonalElements() {
        
        var P = PermutationMatrix<Int>(permutation: [1, 0, 3, 2])
        XCTAssertEqual([0, 0, 0, 0], P.diagonalElements)
        
        P = PermutationMatrix(permutation: [])
        XCTAssertEqual([], P.diagonalElements)
    }
}