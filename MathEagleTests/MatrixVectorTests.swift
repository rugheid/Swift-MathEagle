//
//  MatrixVectorTests.swift
//  MathEagle
//
//  Created by Rugen Heidbuchel on 31/03/15.
//  Copyright (c) 2015 Rugen Heidbuchel. All rights reserved.
//

import Cocoa
import XCTest
import MathEagle

class MatrixVectorTests: XCTestCase {

    func testVectorMatrixProduct() {
        
        var vector = Vector([1, 2, 3])
        var matrix = Matrix([[1, 2, 3], [4, 5, 6], [7, 8, 9]])
        
        XCTAssertEqual(Vector([30, 36, 42]), vector * matrix)
        
        vector = Vector()
        matrix = Matrix()
        
        XCTAssertEqual(Vector<Int>(), vector * matrix)
    }
    
    
    func testMatrixVectorProduct() {
        
        var vector = Vector([1, 2, 3])
        var matrix = Matrix([[1, 2, 3], [4, 5, 6], [7, 8, 9]])
        
        XCTAssertEqual(Vector([14, 32, 50]), matrix * vector)
        
        vector = Vector()
        matrix = Matrix()
        
        XCTAssertEqual(Vector<Int>(), matrix * vector)
    }

}
