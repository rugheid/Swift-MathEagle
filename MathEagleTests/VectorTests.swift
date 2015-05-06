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
    
    
    // MARK: Sort Tests
    
    func testVectorSort() {
        
        var vector = Vector([1, 8, 7, 3, 2, 4, 10, 6, 5, 9])
        vsort(&vector)
        
        let expected = Vector([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
        
        XCTAssertEqual(expected, vector)
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
    
    func testVectorAdditionFloat() {
        
        let left = Vector<Float>([1, 2, 3, 4, 5])
        let right = Vector<Float>([6, 7, 8, 9, 10])
        
        XCTAssertEqual(Vector<Float>([7, 9, 11, 13, 15]), left + right)
    }
    
    func testVectorAdditionFloatPerformance() {
        
        let left = Vector(length: 1000, generator: {i in Float.randomInInterval(-10...10)})
        let right = Vector(length: 1000, generator: {i in Float.randomInInterval(-10...10)})
        
        let timeWithoutAccelerate = 0.0103263401985168
        let time = timeBlock(n: 100){
            
            left + right
        }
        
        println("\nTime without accelerate: \(timeWithoutAccelerate)\nTime with accelerate: \(time)\nWith accelerate is \(timeWithoutAccelerate/time) times faster.\n")
    }
    
    func testVectorAdditionDouble() {
        
        let left = Vector<Double>([1, 2, 3, 4, 5])
        let right = Vector<Double>([6, 7, 8, 9, 10])
        
        XCTAssertEqual(Vector<Double>([7, 9, 11, 13, 15]), left + right)
    }

    func testVectorAdditionDoublePerformance() {
        
        let left = Vector(length: 1000, generator: {i in Double.randomInInterval(-10...10)})
        let right = Vector(length: 1000, generator: {i in Double.randomInInterval(-10...10)})
        
        let timeWithoutAccelerate = 0.0100698000192642
        let time = timeBlock(n: 100){
            
            left + right
        }
        
        println("\nTime without accelerate: \(timeWithoutAccelerate)\nTime with accelerate: \(time)\nWith accelerate is \(timeWithoutAccelerate/time) times faster.\n")
    }

    func testVectorAdditionComplex() {
        
        let i = Complex.imaginaryUnit
        
        let l1 = 1.0 + 2.0*i
        let l2 = 3.0*i
        let l3 = -5.0*i
        let l4: Complex = 4.0
        let left = Vector<Complex>([l1, l2, l3, l4])
        
        let r1: Complex = -3.0
        let r2 = 2.0 + 2.0*i
        let r3 = 2.0*i
        let r4 = -4.0 + 5.0*i
        let right = Vector<Complex>([r1, r2, r3, r4])
        
        let expected = Vector<Complex>([l1 + r1, l2 + r2, l3 + r3, l4 + r4])
        XCTAssertEqual(expected, left + right)
    }
    
    func testVectorAdditionComplexPerformance() {
        
        let left = Vector(length: 1000, generator: {i in Complex.randomInInterval(-10...10)})
        let right = Vector(length: 1000, generator: {i in Complex.randomInInterval(-10...10)})
        
        let timeWithoutAccelerate = 0.0100342969894409
        let time = timeBlock(n: 100){
            
            left + right
        }
        
        println("\nTime without accelerate: \(timeWithoutAccelerate)\nTime with accelerate: \(time)\nWith accelerate is \(timeWithoutAccelerate/time) times faster.\n")
    }

    func testVectorNegation() {
        
        let vector = Vector([1, 2, 3])
        
        let expected = Vector([-1, -2, -3])
        
        XCTAssertEqual(expected, -vector)
    }
    
    func testVectorNegationFloat() {
        
        let vector = Vector<Float>([1, 2, 3])
        
        let expected = Vector<Float>([-1, -2, -3])
        
        XCTAssertEqual(expected, -vector)
    }
    
    func testVectorNegationFloatPerformance() {
        
        let left = Vector(length: 1000, generator: {i in Float.randomInInterval(-10...10)})
        
        let timeWithoutAccelerate = 0.00241095960140228
        let time = timeBlock(n: 100){
            
            -left
        }
        
        println("\nTime without accelerate: \(timeWithoutAccelerate)\nTime with accelerate: \(time)\nWith accelerate is \(timeWithoutAccelerate/time) times faster.\n")
    }
    
    func testVectorNegationDouble() {
        
        let vector = Vector<Double>([1, 2, 3])
        
        let expected = Vector<Double>([-1, -2, -3])
        
        XCTAssertEqual(expected, -vector)
    }
    
    func testVectorNegationDoublePerformance() {
        
        let left = Vector(length: 1000, generator: {i in Double.randomInInterval(-10...10)})
        
        let timeWithoutAccelerate = 0.00239505052566528
        let time = timeBlock(n: 100){
            
            -left
        }
        
        println("\nTime without accelerate: \(timeWithoutAccelerate)\nTime with accelerate: \(time)\nWith accelerate is \(timeWithoutAccelerate/time) times faster.\n")
    }
    
    func testVectorNegationComplex() {
        
        let vector = Vector<Complex>([1, 2, 3])
        
        let expected = Vector<Complex>([-1, -2, -3])
        
        XCTAssertEqual(expected, -vector)
    }
    
    func testVectorNegationComplexPerformance() {
        
        let left = Vector(length: 1000, generator: {i in Complex.randomInInterval(-10...10)})
        
        let timeWithoutAccelerate = 0.00233272016048431
        let time = timeBlock(n: 100){
            
            -left
        }
        
        println("\nTime without accelerate: \(timeWithoutAccelerate)\nTime with accelerate: \(time)\nWith accelerate is \(timeWithoutAccelerate/time) times faster.\n")
    }
    
    func testVectorSubstraction() {
        
        let left = Vector([1, 2, 3, 4])
        let right = Vector([5, 7, 9, 11])
        
        let expected = Vector([-4, -5, -6, -7])
        
        XCTAssertEqual(expected, left - right)
    }
    
    func testVectorSubstractionFloat() {
        
        let left = Vector<Float>([1, 2, 3, 4])
        let right = Vector<Float>([5, 7, 9, 11])
        
        let expected = Vector<Float>([-4, -5, -6, -7])
        
        XCTAssertEqual(expected, left - right)
    }
    
    func testVectorSubstractionFloatPerformance() {
        
        let left = Vector(length: 1000, generator: {i in Float.randomInInterval(-10...10)})
        let right = Vector(length: 1000, generator: {i in Float.randomInInterval(-10...10)})
        
        let timeWithoutAccelerate = 0.0102450299263
        let time = timeBlock(n: 100){
            
            left - right
        }
        
        println("\nTime without accelerate: \(timeWithoutAccelerate)\nTime with accelerate: \(time)\nWith accelerate is \(timeWithoutAccelerate/time) times faster.\n")
    }
    
    func testVectorSubstractionDouble() {
        
        let left = Vector<Double>([1, 2, 3, 4])
        let right = Vector<Double>([5, 7, 9, 11])
        
        let expected = Vector<Double>([-4, -5, -6, -7])
        
        XCTAssertEqual(expected, left - right)
    }
    
    func testVectorSubstractionDoublePerformance() {
        
        let left = Vector(length: 1000, generator: {i in Double.randomInInterval(-10...10)})
        let right = Vector(length: 1000, generator: {i in Double.randomInInterval(-10...10)})
        
        let timeWithoutAccelerate = 0.00998317956924438
        let time = timeBlock(n: 100){
            
            left - right
        }
        
        println("\nTime without accelerate: \(timeWithoutAccelerate)\nTime with accelerate: \(time)\nWith accelerate is \(timeWithoutAccelerate/time) times faster.\n")
    }
    
    func testVectorScalarMultiplication() {
        
        let vector = Vector([1, 2, 3, 4])
        
        XCTAssertEqual(Vector([2, 4, 6, 8]), vector*2)
        XCTAssertEqual(Vector([2, 4, 6, 8]), 2*vector)
    }
    
    func testVectorScalarMultiplicationFloat() {
        
        let vector = Vector<Float>([1, 2, 3, 4])
        
        XCTAssertEqual(Vector<Float>([2, 4, 6, 8]), vector*2)
        XCTAssertEqual(Vector<Float>([2, 4, 6, 8]), 2*vector)
    }
    
    func testVectorScalarMultiplicationFloatPerformance() {
        
        let vector = Vector(length: 1000, generator: {i in Float.randomInInterval(-10...10)})
        let scalar = Float.randomInInterval(-10...10)
        
        let timeWithoutAccelerate = 0.00380656003952026
        let time = timeBlock(n: 100){
            
            scalar * vector
        }
        
        println("\nTime without accelerate: \(timeWithoutAccelerate)\nTime with accelerate: \(time)\nWith accelerate is \(timeWithoutAccelerate/time) times faster.\n")
    }
    
    func testVectorScalarMultiplicationDouble() {
        
        let vector = Vector<Double>([1, 2, 3, 4])
        
        XCTAssertEqual(Vector<Double>([2, 4, 6, 8]), vector*2)
        XCTAssertEqual(Vector<Double>([2, 4, 6, 8]), 2*vector)
    }
    
    func testVectorScalarMultiplicationDoublePerformance() {
        
        let vector = Vector(length: 1000, generator: {i in Double.randomInInterval(-10...10)})
        let scalar = Double.randomInInterval(-10...10)
        
        let timeWithoutAccelerate = 0.00379452049732208
        let time = timeBlock(n: 100){
            
            scalar * vector
        }
        
        println("\nTime without accelerate: \(timeWithoutAccelerate)\nTime with accelerate: \(time)\nWith accelerate is \(timeWithoutAccelerate/time) times faster.\n")
    }
    
    func testVectorScalarDivision() {
        
        let vector = Vector([2, 4, 6, 8])
        
        XCTAssertEqual(Vector([1, 2, 3, 4]), vector/2)
    }

    func testVectorScalarDivisionFloat() {
        
        let vector = Vector<Float>([2, 4, 6, 8])
        
        XCTAssertEqual(Vector<Float>([1, 2, 3, 4]), vector/2)
    }
    
    func testVectorScalarDivisionFloatPerformance() {
        
        let vector = Vector(length: 1000, generator: {i in Float.randomInInterval(-10...10)})
        let scalar = Float.randomInInterval(-10...10)
        
        let timeWithoutAccelerate = 0.00381205022335052
        let time = timeBlock(n: 100){
            
            vector / scalar
        }
        
        println("\nTime without accelerate: \(timeWithoutAccelerate)\nTime with accelerate: \(time)\nWith accelerate is \(timeWithoutAccelerate/time) times faster.\n")
    }
    
    func testVectorScalarDivisionDouble() {
        
        let vector = Vector<Double>([2, 4, 6, 8])
        
        XCTAssertEqual(Vector<Double>([1, 2, 3, 4]), vector/2)
    }
    
    func testVectorScalarDivisionDoublePerformance() {
        
        let vector = Vector(length: 1000, generator: {i in Double.randomInInterval(-10...10)})
        let scalar = Double.randomInInterval(-10...10)
        
        let timeWithoutAccelerate = 0.00373631000518799
        let time = timeBlock(n: 100){
            
            vector / scalar
        }
        
        println("\nTime without accelerate: \(timeWithoutAccelerate)\nTime with accelerate: \(time)\nWith accelerate is \(timeWithoutAccelerate/time) times faster.\n")
    }
    
    func testDotProduct() {
        
        let left = Vector([1, 2, 3])
        let right = Vector([4, 5, 6])
        
        let expected = 32
        
        XCTAssertEqual(expected, left.dotProduct(right))
        XCTAssertEqual(expected, vectorDotProduct(left, right))
    }
    
    func testDotProductFloat() {
        
        let left = Vector<Float>([1, 2, 3])
        let right = Vector<Float>([4, 5, 6])
        
        let expected: Float = 32
        
        XCTAssertEqual(expected, left.dotProduct(right))
        XCTAssertEqual(expected, vectorDotProduct(left, right))
    }
    
    func testVectorDotProductFloatPerformance() {
        
        let left = Vector(length: 1000, generator: {i in Float.randomInInterval(-10...10)})
        let right = Vector(length: 1000, generator: {i in Float.randomInInterval(-10...10)})
        
        compareBaseline(1.01983547210693e-06, title: "Vector dot product of 2 1000 element vectors (Float)", n: 100){
            
            vectorDotProduct(left, right)
        }
    }
    
    func testDotProductDouble() {
        
        let left = Vector<Double>([1, 2, 3])
        let right = Vector<Double>([4, 5, 6])
        
        let expected: Double = 32
        
        XCTAssertEqual(expected, left.dotProduct(right))
        XCTAssertEqual(expected, vectorDotProduct(left, right))
    }
    
    func testVectorDotProductDoublePerformance() {
        
        let left = Vector(length: 1000, generator: {i in Double.randomInInterval(-10...10)})
        let right = Vector(length: 1000, generator: {i in Double.randomInInterval(-10...10)})
        
        compareBaseline(1.11997127532959e-06, title: "Vector dot product of 2 1000 element vectors (Double)", n: 100){
            
            vectorDotProduct(left, right)
        }
    }
    
    func testVectorDirectProduct() {
        
        var left = Vector([1, 2, 3])
        var right = Vector([4, 5, 6])
        
        var expected = Matrix([[4, 5, 6], [8, 10, 12], [12, 15, 18]])
        
        XCTAssertEqual(expected, left*right)
        XCTAssertEqual(expected, left.directProduct(right))
        XCTAssertEqual(expected, vectorDirectProduct(left, right))
        
        
        left = Vector()
        right = Vector()
        
        expected = Matrix()
        
        XCTAssertEqual(expected, left*right)
        XCTAssertEqual(expected, left.directProduct(right))
        XCTAssertEqual(expected, vectorDirectProduct(left, right))
    }
    
    func testVectorDirectProductFloat() {
        
        var left = Vector<Float>([1, 2, 3])
        var right = Vector<Float>([4, 5, 6])
        
        var expected = Matrix<Float>([[4, 5, 6], [8, 10, 12], [12, 15, 18]])
        
        XCTAssertEqual(expected, left*right)
        XCTAssertEqual(expected, left.directProduct(right))
        XCTAssertEqual(expected, vectorDirectProduct(left, right))
        
        
        left = Vector()
        right = Vector()
        
        expected = Matrix()
        
        XCTAssertEqual(expected, left*right)
        XCTAssertEqual(expected, left.directProduct(right))
        XCTAssertEqual(expected, vectorDirectProduct(left, right))
    }
    
    func testVectorDirectProductFloatPerformance() {
        
        let left = Vector(length: 1000, generator: {i in Float.randomInInterval(-10...10)})
        let right = Vector(length: 1000, generator: {i in Float.randomInInterval(-10...10)})
        
        let timeWithoutAccelerate = 2.53886300325394
        let time = timeBlock(n: 1){
            
            vectorDirectProduct(left, right)
        }
        
        println("\nTime without accelerate: \(timeWithoutAccelerate)\nTime with accelerate: \(time)\nWith accelerate is \(timeWithoutAccelerate/time) times faster.\n")
    }
    
    func testVectorDirectProductDouble() {
        
        var left = Vector<Double>([1, 2, 3])
        var right = Vector<Double>([4, 5, 6])
        
        var expected = Matrix<Double>([[4, 5, 6], [8, 10, 12], [12, 15, 18]])
        
        XCTAssertEqual(expected, left*right)
        XCTAssertEqual(expected, left.directProduct(right))
        XCTAssertEqual(expected, vectorDirectProduct(left, right))
        
        
        left = Vector()
        right = Vector()
        
        expected = Matrix()
        
        XCTAssertEqual(expected, left*right)
        XCTAssertEqual(expected, left.directProduct(right))
        XCTAssertEqual(expected, vectorDirectProduct(left, right))
    }
    
    func testVectorDirectProductDoublePerformance() {
        
        let left = Vector(length: 1000, generator: {i in Double.randomInInterval(-10...10)})
        let right = Vector(length: 1000, generator: {i in Double.randomInInterval(-10...10)})
        
        let timeWithoutAccelerate = 440.336444020271
        let time = timeBlock(n: 1){
            
            vectorDirectProduct(left, right)
        }
        
        println("\nTime without accelerate: \(timeWithoutAccelerate)\nTime with accelerate: \(time)\nWith accelerate is \(timeWithoutAccelerate/time) times faster.\n")
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