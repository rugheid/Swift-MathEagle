//
//  VectorTests.swift
//  SwiftMath
//
//  Created by Rugen Heidbuchel on 30/12/14.
//  Copyright (c) 2014 Jorestha Solutions. All rights reserved.
//

import Cocoa
import XCTest

class VectorTests: XCTestCase {
    
    // MARK: Initialisation Tests
    
    func testElementsInit() {
    
        let vector = Vector([1, 2, 3, 4, 5])
        
        XCTAssertEqual([1, 2, 3, 4, 5], vector.elements)
        
        let vector2: Vector<Int> = Vector()
        
        XCTAssertEqual([Int](), vector2.elements)
    }
    
    func testArrayLiteralInit() {
        
        var vector: Vector<Int> = [1, 2, 3, 4]
        
        XCTAssertEqual([1, 2, 3, 4], vector.elements)
        
        vector = []
        
        XCTAssertEqual([], vector.elements)
    }
    
    func testGeneratorInit() {
        
        let vector = Vector(length: 4){ $0 }
        
        let expected = Vector([0, 1, 2, 3])
        
        XCTAssertEqual(expected, vector)
    }
    
    func testFilledWithInit() {
        
        let vector = Vector(filledWith: 5, length: 4)
        
        XCTAssertEqual(Vector([5, 5, 5, 5]), vector)
    }
    
    
    // MARK: Subscript Tests
    
    func testSubscriptGet() {
        
        let vector = Vector([1, 2, 3, 4])
        
        XCTAssertEqual(3, vector[2])
    }
    
    func testSubscriptSet() {
        
        var vector = Vector([1, 2, 3])
        
        vector[1] = 4
    }
    
    func testSubscriptRangeGet() {
        
        let vector = Vector([1, 2, 3, 4, 5, 6])
        
        XCTAssertEqual(Vector([2, 3, 4]), vector[1...3])
        XCTAssertEqual(Vector(), vector[1..<1])
    }
    
    
    // MARK: SequenceType Tests
    
    func testVectorSequenceTypeGenerator() {
        
        let vector = Vector([1, 2, 3, 4])
        
        var str = ""
        
        for element in vector {
            
            str += "\(element)"
        }
        
        XCTAssertEqual("1234", str)
    }
    
    func testVectorMap() {
        
        let vector = Vector([1, 2, 3, 4])
        
        let mapped = vmap(vector){ $0 * $0 }
        
        XCTAssertEqual(Vector([1, 4, 9, 16]), mapped)
    }
    
    func testVectorReduce() {
        
        let vector = Vector([1, 2, 3, 4])
        
        let reduced = vreduce(vector, ""){ $0 + "\($1)" }
        
        XCTAssertEqual("1234", reduced)
    }
    
    func testVectorCombine() {
        
        let left = Vector([1, 2, 3, 4])
        let right = Vector([5, 6, 7, 8])
        
        let combined = vcombine(left, right){ $0 + $1 }
        
        XCTAssertEqual(left + right, combined)
    }
    
    
    // MARK: Computed Properties Tests
    
    func testLength() {
        
        let vector = Vector([1, 2, 3, 4])
        
        XCTAssertEqual(vector.length, 4)
    }
    
    func testNorm() {
        
        let vector = Vector([1, 2, 3, 4])
        
        XCTAssertEqual(vector.norm, sqrt(30.0))
    }
    
    func testNormPerformace() {
        
        let vector = randomDoubleVector(ofLength: 1000, min: -2, max: 2)
        
        self.measureBlock(){
            
            let norm = vector.norm
        }
    }
    
    
    // MARK: Operator Function Tests
    
    func testDotProduct() {
        
        let left = Vector([1, 2, 3])
        let right = Vector([4, 5, 6])
        
        let expected = 32
        
        XCTAssertEqual(32, left.dotProduct(right))
    }
    
    
    // MARK: Operator Tests
    
    func testVectorEquality() {
        
        var vector = Vector([1, 2, 3, 4])
        
        // different length
        let test1 = Vector([1, 2, 3])
        
        XCTAssertNotEqual(vector, test1)
        
        // different elements
        let test2 = Vector([1, 2, 3, 5])
        
        XCTAssertNotEqual(vector, test2)
        
        // equal
        let test3 = Vector([1, 2, 3, 4])
        
        XCTAssertEqual(vector, test3)
    }
    
    func testVectorAddition() {
        
        let left = Vector([1, 2, 3])
        let right = Vector([4, 5, 6])
        
        let expected = Vector([5, 7, 9])
        
        XCTAssertEqual(expected, left + right)
    }
    
    func testVectorNegation() {
        
        let vector = Vector([1, 2, 3])
        
        let expected = Vector([-1, -2, -3])
        
        XCTAssertEqual(expected, -vector)
    }
    
    func testVectorSubstraction() {
        
        let left = Vector([1, 2, 3, 4])
        let right = Vector([5, 6, 7, 8])
        
        let expected = Vector([-4, -4, -4, -4])
        
        XCTAssertEqual(expected, left - right)
    }
    
    func testVectorScalarMultiplication() {
        
        let vector = Vector([1, 2, 3, 4])
        
        XCTAssertEqual(Vector([2, 4, 6, 8]), vector*2)
        XCTAssertEqual(Vector([2, 4, 6, 8]), 2*vector)
    }
    
    func testVectorScalarDivision() {
        
        let vector = Vector([2, 4, 6, 8])
        
        XCTAssertEqual(Vector([1, 2, 3, 4]), vector/2)
    }
    
    func testVectorDirectProduct() {
        
        var left = Vector([1, 2, 3])
        var right = Vector([4, 5, 6])
        
        var expected = Matrix([[4, 5, 6], [8, 10, 12], [12, 15, 18]])
        
        XCTAssertEqual(expected, left*right)
        
        
        left = Vector()
        right = Vector()
        
        expected = Matrix()
        
        XCTAssertEqual(expected, left*right)
    }
    
    
    // MARK: Generator Tests
    
    func testRandomDoubleVectorMinMax() {
        
        var vector = randomDoubleVector(ofLength: 10, min: -1000.0, max: 1000.0)
        
        for element in vector {
            
            XCTAssert(element >= -1000.0 && element <= 1000.0, "\(element) not in boundaries")
        }
        
        
        vector = randomDoubleVector(ofLength: 10, min: 200, max: 201)
        
        for element in vector {
            
            XCTAssert(element >= 200.0 && element <= 201.0, "\(element) not in boundaries")
        }
    }
}