//
//  MatrixTests.swift
//  SwiftMath
//
//  Created by Rugen Heidbuchel on 22/12/14.
//  Copyright (c) 2014 Rugen Heidbuchel. All rights reserved.
//

import Cocoa
import XCTest
import MathEagle

class MatrixTests: XCTestCase {
    
    var cmatrix: Matrix<Complex> = []
    
    override func setUp() {
        
        let i = Complex.imaginaryUnit
        let a = 1.0 + 2.0 * i
        let b = 2.0 * i
        let c = -4.0 - 2.0 * i
        let d = 3.0 * i
        cmatrix = Matrix([[a, b], [c, d]])
    }
    
    
    
    // MARK: Initialisation Tests
    
    func testElementsInit() {
        
        let initElements: [[UInt]] = [[1, 2], [3, 4]]
        let matrix = Matrix(initElements)
        
        XCTAssertEqual(initElements, matrix.elements)
    }

    func testArrayLiterableInit() {
        
        let matrix: Matrix = [[1, 2], [3, 4]]
        
        XCTAssertEqual([[1, 2], [3, 4]], matrix.elements)
    }
    
    func testDimensionsGeneratorInit() {
        
        let matrix = Matrix(dimensions: Dimensions(2, 3)){ $0.row + $0.column }
        
        let expected = Matrix([[0, 1, 2], [1, 2, 3]])
        
        XCTAssertEqual(expected, matrix)
    }
    
    func testRandowWithDimensionsIntervalGeneratorInit() {
        
        let matrix = Matrix<Int>(randomWithDimensions: Dimensions(20, 30), intervals: -10...10)
        
        for element in matrix {
            XCTAssertTrue(element <= 10 && element >= -10)
        }
    }
    
    func testSymmetricalInit() {
        
        // 2 x 2 matrix
        var matrix = Matrix(symmetrical: [1, 2, 3])
        
        XCTAssertEqual([[1, 2], [2, 3]], matrix.elements)
        
        // empty matrix
        matrix = Matrix(symmetrical: [])
        
        XCTAssertTrue(matrix.isEmpty)
    }
    
    func testSymmetricalInitPerformance() {
        
        let diagonalElements = [Int](count: 50, repeatedValue: 4)
        
        self.measureBlock(){
            
            _ = Matrix(symmetrical: diagonalElements)
        }
    }
    
    func testFilledWithSizeInit() {
        
        // 3 x 3 matrix filled with "a"
        var matrix = Matrix(filledWith: 5, size: 3)
        
        let expected = Matrix([[5, 5, 5], [5, 5, 5], [5, 5, 5]])
        
        XCTAssertEqual(expected, matrix)
        
        // empty matrix
        matrix = Matrix(filledWith: 5, size: 0)
        
        XCTAssertTrue(matrix.isEmpty)
    }
    
    func testFilledWithSizeInitPerformance() {
        
        self.measureBlock(){
            
            _ = Matrix(filledWith: 4, size: 10000)
        }
    }
    
    func testFilledWithDimensionsInit() {
        
        // 3 x 3 matrix filled with "a"
        var matrix = Matrix(filledWith: 5, dimensions: Dimensions(3, 3))
        
        XCTAssertEqual([[5, 5, 5], [5, 5, 5], [5, 5, 5]], matrix.elements)
        
        // empty matrix
        matrix = Matrix(filledWith: 5, dimensions: Dimensions(0, 0))
        
        XCTAssertTrue(matrix.isEmpty)
        
        // 2 x 3 matrix filled with 5
        
        let matrix2 = Matrix(filledWith: 5, dimensions: Dimensions(2, 3))
        
        let expected2 = Matrix([[5, 5, 5], [5, 5, 5]])
        
        XCTAssertEqual(expected2, matrix2)
    }
    
    func testIdentityInit() {
        
        // 3 x 3 identity matrix with strings
        let matrix = Matrix<Int>(identityOfSize: 3)
        
        XCTAssertEqual([[1, 0, 0], [0, 1, 0], [0, 0, 1]], matrix.elements)
    }
    
    func testIdentityPerformance() {
        
        self.measureBlock(){
            
            _ = Matrix<Int>(identityOfSize: 1000)
        }
    }
    
    
    // MARK: Subscript Tests
    
    func testElementsSubscript() {
        
        let initElements = [[1, 2], [3, 4]]
        let matrix = Matrix(initElements)
        
        XCTAssertEqual(3, matrix.elements[1][0])
    }
    
    func testSubscriptGet() {
        
        let initElements = [[1, 2], [3, 4]]
        let matrix = Matrix(initElements)
        
        XCTAssertEqual(Vector([1, 2]), matrix[0])
        XCTAssertEqual(Vector([3, 4]), matrix[1])
    }
    
    func testSubscriptSet() {
        
        let initElements = [[1, 2], [3, 4]]
        let matrix = Matrix(initElements)
        matrix[0] = [5, 6]
        
        XCTAssertEqual(Vector([5, 6]), matrix[0])
    }
    
    func testSubscriptRangeGet() {
        
        let matrix = Matrix([[1, 2], [3, 4], [5,6]])
        
        var expected = Matrix([[3, 4], [5, 6]])
        
        XCTAssertEqual(expected, matrix[1...2])
        
        expected = Matrix([[3, 4]])
        
        XCTAssertEqual(expected, matrix[1..<2])
        
        expected = Matrix()
        
        XCTAssertEqual(expected, matrix[1..<1])
    }
    
    func testSubscriptRangeSet() {
        
        var matrix = Matrix([[1, 2], [3, 4], [5,6]])
        
        // replace 2 rows
        matrix[0...1] = Matrix([[7, 8], [9, 10]])
        
        var expected = Matrix([[7, 8], [9, 10], [5,6]])
        
        XCTAssertEqual(expected, matrix)
        
        
        // replace 1 row
        matrix[1...1] = Matrix([[11, 12]])
        
        expected = Matrix([[7, 8], [11, 12], [5,6]])
        
        XCTAssertEqual(expected, matrix)
        
        
        // empty range
        matrix[1..<1] = Matrix([[1, 2]])
        
        XCTAssertEqual(expected, matrix)
        
        
        matrix = [[1, 2], [3, 4], [5,6]]
        
        // replace 2 rows with 1 row
        matrix[1...2] = Matrix([[7, 8]])
        
        expected = [[1, 2], [7, 8]] // this initialises the matrix using array literal since the type is already set
        
        XCTAssertEqual(expected, matrix)
        
        
        matrix = [[1, 2], [3, 4], [5,6]]
        
        // remove rows
        matrix[1...2] = Matrix()
        
        expected = [[1, 2]]
        
        XCTAssertEqual(expected, matrix)
    }
    
    func testSubscriptRowRangeColumnRangeGet() {
        
        let matrix = Matrix([[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12]])
        
        XCTAssertEqual(Matrix([[6, 7], [10, 11]]), matrix[1...2, 1...2])
        XCTAssertEqual(Matrix([[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12]]), matrix[0...2, 0...3])
        XCTAssertEqual(Matrix([[2]]), matrix[0..<1, 1..<2])
    }
    
    func testSubscriptRowRangeColumnRangeSet() {
        
        let matrix = Matrix([[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12]])
        
        matrix[1...2, 2...3] = Matrix([[13, 14], [15, 16]])
        
        XCTAssertEqual(Matrix([[1, 2, 3, 4], [5, 6, 13, 14], [9, 10, 15, 16]]), matrix)
    }
    
    func testSubscriptRowRangeColumnGet() {
        
        let matrix = Matrix([[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12]])
        
        XCTAssertEqual(Vector([6, 10]), matrix[1...2, 1])
        XCTAssertEqual(Vector([4, 8, 12]), matrix[0...2, 3])
    }
    
    func testSubscriptRowRangeColumnSet() {
        
        let matrix = Matrix([[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12]])
        
        matrix[1...2, 2] = Vector([13, 14])
        
        XCTAssertEqual(Matrix([[1, 2, 3, 4], [5, 6, 13, 8], [9, 10, 14, 12]]), matrix)
    }
    
    func testSubscriptRowColumnRangeGet() {
        
        let matrix = Matrix([[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12]])
        
        XCTAssertEqual(Vector([6, 7]), matrix[1, 1...2])
        XCTAssertEqual(Vector([9, 10, 11, 12]), matrix[2, 0...3])
    }
    
    func testSubscriptRowColumnRangeSet() {
        
        let matrix = Matrix([[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12]])
        
        matrix[1, 1...2] = Vector([13, 14])
        
        XCTAssertEqual(Matrix([[1, 2, 3, 4], [5, 13, 14, 8], [9, 10, 11, 12]]), matrix)
    }
    
    
    // MARK: Sequence Type Tests
    
    func testMatrixSequenceTypeGenerator() {
        
        let matrix = Matrix([[1, 2, 3], [4, 5, 6]])
        
        var str = ""
        
        for element in matrix {
            
            str += "\(element)"
        }
        
        XCTAssertEqual("123456", str)
    }
    
    func testMatrixMap() {
        
        let matrix = Matrix<Int>(randomWithSize: 3)
        
        let negative = mmap(matrix){ -$0 }
        
        let expected = -matrix
        
        XCTAssertEqual(expected, negative)
    }
    
    func testMatrixMapPerformance() {
        
        let (_, b) = getCoefficients(n0: 2, numberOfIterations: 5){
            
            let matrix = Matrix<Int>(randomWithSize: $0, intervals: 0 ... 10)
            
            return timeBlock(){
                
                mmap(matrix){ $0 + 1 }
            }
        }
        
        print("\nb for matrix map = \(b)")
        
        let matrix = Matrix<Int>(randomWithSize: 100, intervals: 0 ... 10)
        
        compareBaseline(0.0023840069770813, title: "Mapping 100x100 matrix", n: 10){
            
            mmap(matrix){ $0 + 1 }
        }
    }
    
    func testMatrixReduce() {
        
        let matrix = Matrix([[1, 2, 3], [4, 5, 6]])
        
        let totalSum = mreduce(matrix, initial: 0){ $0 + $1 }
        
        XCTAssertEqual(21, totalSum)
    }
    
    func testMatrixReducePerformance() {
        
        let (_, b) = getCoefficients(n0: 2, numberOfIterations: 5){
            
            let matrix = Matrix<Int>(randomWithSize: $0, intervals: -2 ... 2)
            
            return timeBlock(){
                
                mreduce(matrix, initial: 0, combine: +)
            }
        }
        
        print("\nb for matrix reduce = \(b)")
        
        let matrix = Matrix<Int>(randomWithSize: 100, intervals: -2 ... 2)
        
        compareBaseline(0.00280898809432983, title: "Reducing 100x100 matrix using +", n: 10){
            
            mreduce(matrix, initial: 0, combine: +)
        }
    }
    
    func testMatrixCombine() {
        
        let left = Matrix([[1, 2, 3], [4, 5, 6]])
        let right = Matrix([[7, 8, 9], [10, 11, 12]])
        
        let combined = mcombine(left, right){ $0 + $1 }
        
        let expected = left + right
        
        XCTAssertEqual(expected, combined)
    }
    
    func testMatrixCombinePerformance() {
        
        let (_, b) = getCoefficients(n0: 2, numberOfIterations: 5){
            
            let left = Matrix<Int>(randomWithSize: $0, intervals: 0 ... 10)
            let right = Matrix<Int>(randomWithSize: $0, intervals: -10 ... 0)
            
            return timeBlock(){
                
                mcombine(left, right, combine: +)
            }
        }
        
        print("\nb for matrix reduce = \(b)")
        
        let left = Matrix<Int>(randomWithSize: 100, intervals: 0 ... 10)
        let right = Matrix<Int>(randomWithSize: 100, intervals: -10 ... 0)
        
        compareBaseline(0.00611197948455811, title: "Combining 2 100x100 matrices using +", n: 10){
            
            mcombine(left, right, combine: +)
        }
    }
    
    
    // MARK: Computed Properties Tests
    
    func testDescription() {
        
        // 2 x 3 matrix
        var matrix = Matrix([[1, 2], [3, 4], [5, 6]])
        
        XCTAssertEqual("[[1, 2], [3, 4], [5, 6]]", matrix.description)
        
        // empty matrix
        matrix = Matrix()
        
        XCTAssertEqual("[[]]", matrix.description)
    }
    
    func testDimensions() {
        
        // 2 x 2 matrix
        var initElements = [[1, 2], [3, 4]]
        var matrix = Matrix(initElements)
        var expected = Dimensions(2, 2)
        
        XCTAssertEqual(expected, matrix.dimensions)
        
        // 3 x 1 matrix, column vector
        initElements = [[1],[2],[3]]
        matrix = Matrix(initElements)
        expected = Dimensions(3, 1)
        
        XCTAssertEqual(expected, matrix.dimensions)
        
        // empty matrix
        initElements = [[]]
        matrix = Matrix(initElements)
        expected = Dimensions(0, 0)
        
        XCTAssertEqual(expected, matrix.dimensions)
    }
    
    func testSetDimensions() {
        
        let A = Matrix([[1, 2, 3], [4, 5, 6], [7, 8, 9]])
        A.dimensions = Dimensions(size: 4)
        XCTAssertEqual([[1, 2, 3, 0], [4, 5, 6, 0], [7, 8, 9, 0], [0, 0, 0, 0]], A.elements)
        XCTAssertEqual(Dimensions(size: 4), A.dimensions)
        
        A.dimensions = Dimensions(size: 2)
        XCTAssertEqual([[1, 2], [4, 5]], A.elements)
        XCTAssertEqual(Dimensions(size: 2), A.dimensions)
        
        A.dimensions = Dimensions(2, 4)
        XCTAssertEqual([[1, 2, 0, 0], [4, 5, 0, 0]], A.elements)
        XCTAssertEqual(Dimensions(2, 4), A.dimensions)
        
        A.dimensions = Dimensions(size: 4)
        XCTAssertEqual([[1, 2, 0, 0], [4, 5, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0]], A.elements)
        XCTAssertEqual(Dimensions(size: 4), A.dimensions)
        
        A.dimensions = Dimensions(4, 2)
        XCTAssertEqual([[1, 2], [4, 5], [0, 0], [0, 0]], A.elements)
        XCTAssertEqual(Dimensions(4, 2), A.dimensions)
        
        A.dimensions = Dimensions(size: 2)
        XCTAssertEqual([[1, 2], [4, 5]], A.elements)
        XCTAssertEqual(Dimensions(size: 2), A.dimensions)
    }
    
    func testTrace() {
        
        var matrix = Matrix<Int>(identityOfSize: 10)
        XCTAssertEqual(10, matrix.trace!)
        
        matrix = Matrix(filledWith: 5, size: 3)
        XCTAssertEqual(15, matrix.trace!)
        
        let i = Complex.imaginaryUnit
        XCTAssertEqual(1.0 + 5.0 * i, cmatrix.trace!)
        
        matrix = Matrix()
        XCTAssertNil(matrix.trace)
    }
    
    func testMatrixDeterminant() {
        
        var matrix = Matrix<Double>(identityOfSize: 10)
        XCTAssertEqual(1.0, matrix.determinant)
        
        matrix = Matrix([[2, 4], [3, 7]])
        XCTAssertEqualWithAccuracy(2.0, matrix.determinant, accuracy: ACCURACY)
        
        matrix = Matrix([[6, 7, -3, 2], [5, -2, -2, 3], [8, 6, 5, 5], [-8, -8, 0, 3]])
        XCTAssertEqualWithAccuracy(-2759.0, matrix.determinant, accuracy: ACCURACY)
        
        let i = Complex.imaginaryUnit
        XCTAssertTrue((-10.0 + 11.0 * i).equals(cmatrix.determinant, accuracy: ACCURACY))
    }

    func testGetDiagonalElements() {
        
        // 2 x 2 matrix
        var initElements = [[1, 2], [3, 4]]
        var matrix = Matrix(initElements)
        var expected = [1, 4]
        
        XCTAssertEqual(expected, matrix.diagonalElements)
        
        // 3 x 1 matrix, column vector
        initElements = [[1],[2],[3]]
        matrix = Matrix(initElements)
        expected = [1]
        
        XCTAssertEqual(expected, matrix.diagonalElements)
        
        // 2 x 3 matrix
        initElements = [[1, 2, 3], [4, 5, 6]]
        matrix = Matrix(initElements)
        expected = [1, 5]
        
        XCTAssertEqual(expected, matrix.diagonalElements)
    }
    
    func testSetDiagonalElements() {
        
        // 2 x 2 matrix
        var initElements = [[1, 2], [3, 4]]
        var matrix = Matrix(initElements)
        matrix.diagonalElements = [5, 6]
        
        XCTAssertEqual([[5, 2], [3, 6]], matrix.elements)
        
        // 3 x 1 matrix, column vector
        initElements = [[1],[2],[3]]
        matrix = Matrix(initElements)
        matrix.diagonalElements = [4]
        
        XCTAssertEqual([[4], [2], [3]], matrix.elements)
        
        // 2 x 3 matrix
        initElements = [[1, 2, 3], [4, 5, 6]]
        matrix = Matrix(initElements)
        matrix.diagonalElements = [7, 8]
        
        XCTAssertEqual([[7, 2, 3], [4, 8, 6]], matrix.elements)
    }
    
    func testGetDiagonalElementsFunction() {
        let matrix = Matrix([[1, 2, 3], [4, 5, 6]])
        XCTAssertEqual([1, 5], matrix.diagonalElements())
        XCTAssertEqual([4], matrix.diagonalElements(-1))
        XCTAssertEqual([2, 6], matrix.diagonalElements(1))
        XCTAssertEqual([3], matrix.diagonalElements(2))
    }
    
    func testGetUpperTriangle() {
        
        var matrix = Matrix([[1, 2, 3], [4, 5, 6]])
        XCTAssertEqual(Matrix([[1, 2, 3], [0, 5, 6]]), matrix.upperTriangle)
        
        matrix = []
        XCTAssertEqual(Matrix<Int>(), matrix.upperTriangle)
    }
    
    func testGetUpperTriangleFunction() {
        
        var matrix = Matrix([[1, 2, 3], [4, 5, 6]])
        XCTAssertEqual(Matrix([[1, 2, 3], [0, 5, 6]]), try! matrix.upperTriangle())
        XCTAssertEqual(Matrix([[1, 2, 3], [4, 5, 6]]), try! matrix.upperTriangle(-1))
        XCTAssertEqual(Matrix([[0, 2, 3], [0, 0, 6]]), try! matrix.upperTriangle(1))
        XCTAssertEqual(Matrix([[0, 0, 3], [0, 0, 0]]), try! matrix.upperTriangle(2))
        
        matrix = []
        XCTAssertEqual(Matrix<Int>(), try! matrix.upperTriangle())
        
        do {
            try matrix.upperTriangle(1)
            XCTAssert(false)
        } catch {
            XCTAssert(true)
        }
    }
    
    func testGetUpperTriangleFunctionPerformance() {
        
        let matrix = Matrix<Int>(randomWithSize: 100, intervals: -10...10)
        
        let diagonalBaseline = 0.00145101547241211
        let diagonalTime = timeBlock(){
            
            try! matrix.upperTriangle()
        }
        
        print("\nDiagonal time = \(diagonalTime), this is \(diagonalBaseline/diagonalTime) times faster than baseline.")
        
        let superDiagonalBaseline = 0.00230699777603149
        let superDiagonalTime = timeBlock(){
            
            try! matrix.upperTriangle(25)
        }
        
        print("\nSuper diagonal time = \(superDiagonalTime), this is \(superDiagonalBaseline/superDiagonalTime) times faster than baseline.")
        
        let subDiagonalBaseline = 0.000886976718902588
        let subDiagonalTime = timeBlock(){
            
            try! matrix.upperTriangle(-25)
        }
        
        print("\nSub diagonal time = \(subDiagonalTime), this is \(subDiagonalBaseline/subDiagonalTime) times faster than baseline.\n")
    }
    
    func testGetLowerTriangle() {
        
        var matrix = Matrix([[1, 2, 3], [4, 5, 6]])
        XCTAssertEqual(Matrix([[1, 0, 0], [4, 5, 0]]), matrix.lowerTriangle)
        
        matrix = []
        XCTAssertEqual(Matrix<Int>(), matrix.lowerTriangle)
    }
    
    func testGetLowerTriangleFunction() {
        
        var matrix = Matrix([[1, 2, 3], [4, 5, 6]])
        XCTAssertEqual(Matrix([[1, 0, 0], [4, 5, 0]]), matrix.lowerTriangle())
        XCTAssertEqual(Matrix([[0, 0, 0], [4, 0, 0]]), matrix.lowerTriangle(-1))
        XCTAssertEqual(Matrix([[1, 2, 0], [4, 5, 6]]), matrix.lowerTriangle(1))
        XCTAssertEqual(Matrix([[1, 2, 3], [4, 5, 6]]), matrix.lowerTriangle(2))
        
        matrix = []
        XCTAssertEqual(Matrix<Int>(), matrix.lowerTriangle())
    }
    
    func testGetLowerTriangleFunctionPerformance() {
        
        let matrix = Matrix<Int>(randomWithSize: 100, intervals: -10...10)
        
        let diagonalBaseline = 0.001708984375
        let diagonalTime = timeBlock(){
            
            matrix.lowerTriangle()
        }
        
        print("\nDiagonal time = \(diagonalTime), this is \(diagonalBaseline/diagonalTime) times faster than baseline.")
        
        let superDiagonalBaseline = 0.00111198425292969
        let superDiagonalTime = timeBlock(){
            
            matrix.lowerTriangle(25)
        }
        
        print("\nSuper diagonal time = \(superDiagonalTime), this is \(superDiagonalBaseline/superDiagonalTime) times faster than baseline.")
        
        let subDiagonalBaseline = 0.00196701288223267
        let subDiagonalTime = timeBlock(){
            
            matrix.lowerTriangle(-25)
        }
        
        print("\nSub diagonal time = \(subDiagonalTime), this is \(subDiagonalBaseline/subDiagonalTime) times faster than baseline.\n")
    }
    
    func testMaxValue() {
        
        var matrix = Matrix([[1, 2, 3], [6, 5, 4]])
        
        XCTAssertEqual(6, matrix.maxElement!)
        
        matrix = Matrix(filledWith: 5, dimensions: Dimensions(5, 8))
        
        XCTAssertEqual(5, matrix.maxElement!)
    }
    
    func testMaxValuePerformance() {
        
        getCoefficients(n0: 10, numberOfIterations: 5){
            
            let matrix = Matrix<Int>(randomWithSize: $0, intervals: -1000 ... 1000)
            
            return timeBlock(){
                
                matrix.maxElement
            }
        }
    }
    
    func testMaxValueTime() {
        
        let matrix = Matrix<Int>(randomWithSize: 100, intervals: -1000 ... 1000)
        
        self.measureBlock(){
            
            matrix.maxElement
        }
    }
    
    func testMinValue() {
        
        var matrix = Matrix([[1, 2, 3], [6, 5, 4]])
        
        XCTAssertEqual(1, matrix.minElement!)
        
        matrix = Matrix(filledWith: 5, dimensions: Dimensions(5, 8))
        
        XCTAssertEqual(5, matrix.minElement!)
    }
    
    func testTranspose() {
        
        // Normal matrix
        var matrix = Matrix([[1, 2, 3], [4, 5, 6]])
        
        var expected = Matrix([[1, 4], [2, 5], [3, 6]])
        
        XCTAssertEqual(expected, matrix.transpose)
        
        // Empty matrix
        matrix = Matrix()
        
        expected = Matrix()
        
        XCTAssertEqual(expected, matrix.transpose)
    }
    
    func testConjugate() {
        
        let matrix = Matrix([[1, 2, 3], [4, 5, 6]])
        XCTAssertEqual(matrix, matrix.conjugate)
        
        let a = cmatrix[0, 0].conjugate
        let b = cmatrix[0, 1].conjugate
        let c = cmatrix[1, 0].conjugate
        let d = cmatrix[1, 1].conjugate
        XCTAssertEqual(Matrix([[a, b], [c, d]]), cmatrix.conjugate)
    }
    
    func testConjugateTranspose() {
        
        var matrix = Matrix([[1, 2, 3], [4, 5, 6]])
        var expected = Matrix([[1, 4], [2, 5], [3, 6]])
        XCTAssertEqual(expected, matrix.conjugateTranspose)
        
        matrix = Matrix()
        expected = Matrix()
        XCTAssertEqual(expected, matrix.conjugateTranspose)
        
        let a = cmatrix[0, 0].conjugate
        let b = cmatrix[0, 1].conjugate
        let c = cmatrix[1, 0].conjugate
        let d = cmatrix[1, 1].conjugate
        XCTAssertEqual(Matrix([[a, c], [b, d]]), cmatrix.conjugateTranspose)
    }
    
    func testConjugateTransposePerformance() {
        
        let baseline = 0.000351011753082275
        let time = timeBlock(){
            
            self.cmatrix.conjugateTranspose
        }
        
        print("\nTime for conjugate transpose = \(time), this is \(baseline/time) times faster than baseline.\n")
    }
    
    func testIsEmpty() {
        
        // 2 x 2 matrix
        var initElements = [[1, 2], [3, 4]]
        var matrix = Matrix(initElements)
        
        XCTAssertFalse(matrix.isEmpty)
        
        // empty matrix
        initElements = [[]]
        matrix = Matrix(initElements)
        
        XCTAssertTrue(matrix.isEmpty)
        
        // init matrix
        let matrix2 = Matrix<Int>()
        
        XCTAssertTrue(matrix2.isEmpty)
    }
    
    func testIsZero() {
        
        XCTAssertTrue(Matrix<Int>().isZero)
        XCTAssertTrue(Matrix([[0, 0], [0, 0]]).isZero)
        
        XCTAssertFalse(Matrix([[1, 0], [3, 4]]).isZero)
    }
    
    func testIsSquare() {
        
        // 2 x 2 matrix
        var initElements = [[1, 2], [3, 4]]
        var matrix = Matrix(initElements)
        
        XCTAssertTrue(matrix.isSquare)
        
        // 3 x 1 matrix, column vector
        initElements = [[1],[2],[3]]
        matrix = Matrix(initElements)
        
        XCTAssertFalse(matrix.isSquare)
    }
    
    func testIsDiagonal() {
        
        var matrix = Matrix([[2, 0], [0, 3]])
        XCTAssertTrue(matrix.isDiagonal)
        
        matrix = Matrix([[0, 3], [4, 4]])
        XCTAssertFalse(matrix.isDiagonal)
    }
    
    func testIsSymmetrical() {
        
        // 2 x 3 matrix
        var matrix = Matrix([[1, 2, 3], [4, 5, 6]])
        XCTAssertFalse(matrix.isSymmetrical)
        
        // 3 x 3 matrix, not symmetrical
        matrix = Matrix([[1, 2, 3], [4, 5, 6], [7, 8, 9]])
        XCTAssertFalse(matrix.isSymmetrical)
        
        // 3 x 3 matrix, symmetrical
        matrix = Matrix([[1, 2, 3], [2, 3, 4], [3, 4, 5]])
        XCTAssertTrue(matrix.isSymmetrical)
        
        // 3 x 3 matrix, symmetrical
        matrix = [[1, 2, 3], [2, 4, 5], [3, 5, 6]]
        XCTAssertTrue(matrix.isSymmetrical)
    }
    
    func testIsSymmetricalPerformance() {
        
        let (_, b) = getCoefficients(n0: 10, numberOfIterations: 5){
            
            let matrixElements = [Int](count: 2*$0 - 1, repeatedValue: 2)
            
            let matrix = Matrix(symmetrical: matrixElements)
            
            return timeBlock(){
                
                matrix.isSymmetrical
            }
        }
        
        print("Symmetrical performance \n b = \(b)")
    }
    
    func testIsUpperTriangular() {
        
        // non square -> false
        var matrix = Matrix([[1, 2, 3], [4, 5, 6]])
        XCTAssertFalse(matrix.isUpperTriangular)
        
        // square, but not upper triangular -> false
        matrix = [[1, 2], [3, 4]]
        XCTAssertFalse(matrix.isUpperTriangular)
        
        // square and upper triangular -> true
        matrix = [[1, 2], [0, 3]]
        XCTAssertTrue(matrix.isUpperTriangular)
    }
    
    func testIsUpperTriangularFunction() {
        
        // non square -> false
        var matrix = Matrix([[1, 2, 3], [4, 5, 6]])
        XCTAssertFalse(matrix.isUpperTriangular())
        
        // square, but not upper triangular -> false
        matrix = [[1, 2], [3, 4]]
        XCTAssertFalse(matrix.isUpperTriangular())
        
        // square and upper triangular -> true
        matrix = [[1, 2], [0, 3]]
        XCTAssertTrue(matrix.isUpperTriangular())
        
        // square, upper triangular for index 2 -> true for all indexes less than or equal to 2
        matrix = [[0, 0, 1, 2], [0, 0, 0, 3], [0, 0, 0, 0], [0, 0, 0, 0]]
        XCTAssertTrue(matrix.isUpperTriangular())
        XCTAssertTrue(matrix.isUpperTriangular(-1))
        XCTAssertTrue(matrix.isUpperTriangular(-2))
        XCTAssertTrue(matrix.isUpperTriangular(-3))
        XCTAssertTrue(matrix.isUpperTriangular(1))
        XCTAssertTrue(matrix.isUpperTriangular(2))
        XCTAssertFalse(matrix.isUpperTriangular(3))
        
        // non square, upper triangular, mustBeSquare false -> true
        matrix = [[1, 2, 3], [0, 4, 5]]
        XCTAssertTrue(matrix.isUpperTriangular(mustBeSquare: false))
        
        // non square, upper triangular for index 1, mustBeSquare false -> true for indexes less than or equal to 1
        matrix = [[0, 1, 2], [0, 0, 3]]
        XCTAssertTrue(matrix.isUpperTriangular(mustBeSquare: false))
        XCTAssertTrue(matrix.isUpperTriangular(-1, mustBeSquare: false))
        XCTAssertTrue(matrix.isUpperTriangular(1, mustBeSquare: false))
        XCTAssertFalse(matrix.isUpperTriangular(2, mustBeSquare: false))
    }
    
    func testIsUpperHessenberg() {
        
        // square, not upper Hessenberg -> false
        var matrix = Matrix([[1, 2, 3], [4, 5, 6], [7, 8, 9]])
        XCTAssertFalse(matrix.isUpperHessenberg)
        
        // square, upper Hessenberg -> true
        matrix = [[1, 2, 3], [4, 5, 6], [0, 7, 8]]
        XCTAssertTrue(matrix.isUpperHessenberg)
        
        // non-square -> false
        matrix = [[1, 2, 3], [4, 5, 6]]
        XCTAssertFalse(matrix.isUpperHessenberg)
    }
    
    func testIsLowerTriangular() {
        
        // non square -> false
        var matrix = Matrix([[1, 2, 3], [4, 5, 6]])
        XCTAssertFalse(matrix.isLowerTriangular)
        
        // square, but not lower triangular -> false
        matrix = [[1, 2], [3, 4]]
        XCTAssertFalse(matrix.isLowerTriangular)
        
        // square and lower triangular -> true
        matrix = [[1, 0], [2, 3]]
        XCTAssertTrue(matrix.isLowerTriangular)
    }
    
    func testIsLowerTriangularFunction() {
        
        // non square -> false
        var matrix = Matrix([[1, 2, 3], [4, 5, 6]])
        XCTAssertFalse(matrix.isLowerTriangular())
        
        // square, but not lower triangular -> false
        matrix = [[1, 2], [3, 4]]
        XCTAssertFalse(matrix.isLowerTriangular())
        
        // square and lower triangular -> true
        matrix = [[1, 0], [2, 3]]
        XCTAssertTrue(matrix.isLowerTriangular())
        
        // square, lower triangular for index -2 -> true for all indexes higher than or equal to -2
        matrix = [[0, 0, 0, 0], [0, 0, 0, 0], [1, 0, 0, 0], [2, 3, 0, 0]]
        XCTAssertTrue(matrix.isLowerTriangular())
        XCTAssertTrue(matrix.isLowerTriangular(-1))
        XCTAssertTrue(matrix.isLowerTriangular(-2))
        XCTAssertFalse(matrix.isLowerTriangular(-3))
        XCTAssertTrue(matrix.isLowerTriangular(1))
        XCTAssertTrue(matrix.isLowerTriangular(2))
        XCTAssertTrue(matrix.isLowerTriangular(3))
        
        // non square, lower triangular, mustBeSquare false -> true
        matrix = [[1, 0, 0], [3, 4, 0]]
        XCTAssertTrue(matrix.isLowerTriangular(mustBeSquare: false))
        
        // non square, upper triangular, mustBeSquare false -> true for indexes higher than or equal to 0
        matrix = [[1, 0, 0], [2, 3, 0]]
        XCTAssertTrue(matrix.isLowerTriangular(mustBeSquare: false))
        XCTAssertFalse(matrix.isLowerTriangular(-1, mustBeSquare: false))
        XCTAssertTrue(matrix.isLowerTriangular(1, mustBeSquare: false))
        XCTAssertTrue(matrix.isLowerTriangular(2, mustBeSquare: false))
    }
    
    func testIsLowerHessenberg() {
        
        // square, not lower Hessenberg -> false
        var matrix = Matrix([[1, 2, 3] ,[4, 5, 6], [7, 8, 9]])
        XCTAssertFalse(matrix.isLowerHessenberg)
        
        // square, lower Hessenberg -> true
        matrix = [[1, 2, 0], [3, 4, 5], [6, 7, 8]]
        XCTAssertTrue(matrix.isLowerHessenberg)
        
        // non-square -> false
        matrix = [[1, 2, 0], [3, 4, 5]]
        XCTAssertFalse(matrix.isLowerHessenberg)
    }
    
    func testIsHermitian() {
        
        XCTAssertFalse(cmatrix.isHermitian)
        
        var A = Matrix<Float>(randomWithDimensions: Dimensions(34, 65))
        XCTAssertFalse(A.isHermitian)
        
        A = Matrix<Float>(randomWithSize: 50)
        XCTAssertFalse(A.isHermitian)
        
        A = [[1, 2, 3], [2, 4, 5], [3, 5, 6]]
        XCTAssertTrue(A.isHermitian)
    }
    
    
    
    // MARK: Method tests
    
    func testElement() {
        
        let initElements = [[1, 2], [3, 4]]
        let matrix = Matrix(initElements)
        
        XCTAssertEqual(2, matrix.element(0, 1))
    }
    
    func testSetElementAtRowAtColumn() {
        
        let initElements = [[1, 2], [3, 4]]
        let matrix = Matrix(initElements)
        
        matrix.setElement(atRow: 0, atColumn: 1, toElement: 5)
        
        XCTAssertEqual(5, matrix.element(0, 1))
    }
    
    func testSetElementAtIndex() {
        
        let initElements = [[1, 2], [3, 4]]
        let matrix = Matrix(initElements)
        
        matrix.setElement(atIndex: (0, 1), toElement: 5)
        
        XCTAssertEqual(5, matrix.element(0, 1))
    }
    
    func testRow() {
        
        // 2 x 3 matrix
        let initElements = [[1, 2, 3], [4, 5, 6]]
        let matrix = Matrix(initElements)
        
        XCTAssertEqual(Vector([4,5,6]), matrix.row(1))
    }
    
    func testSetRow() {
        
        // 2 x 3 matrix
        let initElements = [[1, 2, 3], [4, 5, 6]]
        let matrix = Matrix(initElements)
        
        matrix.setRow(atIndex: 0, toRow: [7, 8, 9])
        
        XCTAssertEqual(Vector([7, 8, 9]), matrix[0])
    }
    
    func testSwitchRows() {
        
        let initElements = [[1, 2, 3], [4, 5, 6]]
        let matrix = Matrix(initElements)
        
        matrix.switchRows(0, 1)
        
        XCTAssertEqual(Vector([4, 5, 6]), matrix[0])
        XCTAssertEqual(Vector([1, 2, 3]), matrix[1])
    }
    
    func testColumn() {
        
        // 2 x 3 matrix
        let initElements = [[1, 2, 3], [4, 5, 6]]
        let matrix = Matrix(initElements)
        
        XCTAssertEqual(Vector([2,5]), matrix.column(1))
    }
    
    func testSetColumn() {
        
        // 2 x 3 matrix
        let initElements = [[1, 2, 3], [4, 5, 6]]
        let matrix = Matrix(initElements)
        
        matrix.setColumn(atIndex: 1, toColumn: [7, 8])
        
        XCTAssertEqual(Vector([7, 8]), matrix.column(1))
        XCTAssertEqual(Vector([1, 7, 3]), matrix[0])
        XCTAssertEqual(Vector([4, 8, 6]), matrix[1])
    }
    
    func testRemoveColumn() {
        
        var matrix = Matrix([[1, 2, 3], [4, 5, 6]])
        matrix.removeColumn(atIndex: 1)
        XCTAssertEqual(Matrix([[1, 3], [4, 6]]), matrix)
        
        matrix = [[1], [2]]
        matrix.removeColumn(atIndex: 0)
        XCTAssertEqual(Matrix<Int>(), matrix)
    }
    
    func testSwitchColumns() {
        
        // 2 x 3 matrix
        let initElements = [[1, 2, 3], [4, 5, 6]]
        let matrix = Matrix(initElements)
        
        matrix.switchColumns(1, 2)
        
        XCTAssertEqual(Vector([2, 5]), matrix.column(2))
        XCTAssertEqual(Vector([3, 6]), matrix.column(1))
    }
    
    func testSubmatrix() {
        
        let matrix = Matrix([[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12]])
        
        XCTAssertEqual(Matrix([[6, 7], [10, 11]]), matrix.submatrix(1...2, 1...2))
        XCTAssertEqual(Matrix([[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12]]), matrix.submatrix(0...2, 0...3))
        XCTAssertEqual(Matrix([[2]]), matrix.submatrix(0..<1, 1..<2))
    }
    
    func testSetSubmatrix() {
        
        let matrix = Matrix([[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12]])
        
        matrix.setSubmatrix(1...2, 2...3, toMatrix: Matrix([[13, 14], [15, 16]]))
        
        XCTAssertEqual(Matrix([[1, 2, 3, 4], [5, 6, 13, 14], [9, 10, 15, 16]]), matrix)
    }
    
    func testSubvectorRowRange() {
        
        let matrix = Matrix([[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12]])
        
        XCTAssertEqual(Vector([6, 10]), matrix.subvector(1...2, 1))
        XCTAssertEqual(Vector([4, 8, 12]), matrix.subvector(0...2, 3))
    }
    
    func testSetSubvectorRowRange() {
        
        let matrix = Matrix([[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12]])
        
        matrix.setSubvector(1...2, 2, toVector: Vector([13, 14]))
        
        XCTAssertEqual(Matrix([[1, 2, 3, 4], [5, 6, 13, 8], [9, 10, 14, 12]]), matrix)
    }
    
    func testSubvectorColumnRange() {
        
        let matrix = Matrix([[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12]])
        
        XCTAssertEqual(Vector([6, 7]), matrix.subvector(1, 1...2))
        XCTAssertEqual(Vector([9, 10, 11, 12]), matrix.subvector(2, 0...3))
    }
    
    func testSetSubvectorColumnRange() {
        
        let matrix = Matrix([[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12]])
        
        matrix.setSubvector(1, 1...2, toVector: Vector([13, 14]))
        
        XCTAssertEqual(Matrix([[1, 2, 3, 4], [5, 13, 14, 8], [9, 10, 11, 12]]), matrix)
    }
    
    func testFillDiagonal() {
        
        // 2 x 2 zeros matrix
        var matrix = Matrix([[0, 0], [0, 0]])
        matrix.fillDiagonal(1)
        
        XCTAssertEqual([[1, 0], [0, 1]], matrix.elements)
        
        // 2 x 3 zeros matrix
        matrix = Matrix([[0, 0, 0], [0, 0, 0]])
        matrix.fillDiagonal(1)
        
        XCTAssertEqual([[1, 0, 0], [0, 1, 0]], matrix.elements)
    }
    
    
    
    // MARK: Factorisation Tests
    
    func testLUDecomposition() {
        
        let matrix = Matrix<Double>([[1, 2, 1], [2, 6, 5], [3, 14, 19]])
        
        let (L, U, P) = matrix.LUDecomposition
        
        XCTAssertEqual(P*matrix, L*U)
        
        let (cL, cU, cP) = cmatrix.LUDecomposition
        
        XCTAssertEqual(cP*cmatrix, cL*cU)
    }
    
    func testLUDecompositionPerformance() {
        
//        let (a,b) = self.getCoefficients(n0: 5, numberOfIterations: 3, timeBlock: {
//            
//            let matrix = randomFloatMatrix(withSize: $0)
//            
//            return self.timeBlock({
//                
//                matrix.LUDecomposition
//            })
//        })
        
        
        let matrix = Matrix<Double>([[1, 2, 1], [2, 6, 5], [3, 14, 19]])
        
        let start = NSDate()
        
        for _ in 0 ..< 100 {
            
            matrix.LUDecomposition
        }
        
        let elapsed = NSDate().timeIntervalSinceDate(start)
        let python = 0.011
        let slower = elapsed/python
        
        print("Swift time = \(elapsed)\nPython time = \(python)\nSwift is still \(slower) times slower than python...")
    }
    
    
    
    // MARK: Operator Tests
    
    func testMatrixEquality() {
        
        let matrix1 = Matrix([[1,2], [3, 4]])
        let matrix2 = Matrix([[1, 2, 3], [4, 5, 6], [7, 8, 9]])
        let matrix3 = Matrix([[1, 2], [3, 5]])
        let matrix4 = Matrix([[1, 2], [3, 4]])
        
        XCTAssertNotEqual(matrix1, matrix2)
        XCTAssertNotEqual(matrix1, matrix3)
        XCTAssertEqual(matrix1, matrix4)
        
        // 2 empty matrices
        let matrix5 = Matrix<Int>()
        let matrix6 = Matrix<Int>()
        
        XCTAssertEqual(matrix5, matrix6)
    }
    
    func testMatrixEqualtiyPerformance() {
        
        let A = Matrix<Int>(randomWithSize: 1000)
        let B = Matrix<Int>(randomWithSize: 1000)
        
        compareBaseline(0.000926479697227478, title: "Testing equality of 2 1000x1000 matrices (Int)", n: 100){
            
            A == B
        }
    }
    
    func testMatrixAddition() {
        
        let left = Matrix([[1, 2], [3, 4]])
        let right = Matrix([[5, 6], [7, 8]])
        
        let expected = Matrix([[6, 8], [10, 12]])
        
        XCTAssertEqual(expected, left + right)
    }
    
    func testMatrixAdditionFloat() {
        
        let left = Matrix<Float>([[1, 2], [3, 4]])
        let right = Matrix<Float>([[5, 6], [7, 8]])
        
        let expected = Matrix<Float>([[6, 8], [10, 12]])
        
        XCTAssertEqual(expected, left + right)
    }
    
    func testMatrixAdditionFloatPerformance() {
        
        let left = Matrix<Float>(randomWithSize: 1000)
        let right = Matrix<Float>(randomWithSize: 1000)
        
        compareBaseline(0.616482019424438, title: "Adding 2 1000x1000 matrices (Float)", n: 1){
            
            left + right
        }
    }
    
    func testMatrixAdditionFloatBenchmarking() {
        
        calculateBenchmarkingTimes(10, maxPower: 3){
            
            let left = Matrix<Float>(randomWithSize: $0)
            let right = Matrix<Float>(randomWithSize: $0)
            
            return timeBlock(n: $0 <= 1000 ? 10 : 1){
                
                left + right
            }
        }
    }
    
    func testMatrixNegation() {
        
        let matrix = Matrix([[1, 2], [3, 4]])
        let expected = Matrix([[-1, -2], [-3, -4]])
        XCTAssertEqual(expected, -matrix)
    }
    
    func testMatrixSubstraction() {
        
        let left = Matrix([[1, 2], [3, 4]])
        let right = Matrix([[0, 2], [-1, 10]])
        
        let expected = Matrix([[1, 0], [4, -6]])
        
        XCTAssertEqual(expected, left - right)
    }
    
    func testMatrixScalarMultiplication() {
        
        var scalar = 3
        let matrix = Matrix([[1, 2], [3, 4]])
        
        var expected = Matrix([[3, 6], [9, 12]])
        
        XCTAssertEqual(expected, scalar * matrix)
        XCTAssertEqual(expected, matrix * scalar)
        
        scalar = 0
        
        expected = Matrix(filledWith: 0, size: 2)
        
        XCTAssertEqual(expected, scalar * matrix)
        XCTAssertEqual(expected, matrix * scalar)
    }
    
    func testMatrixMultiplication() {
        
        let left = Matrix([[1, 2, 3], [4, 5, 6]])
        let right = Matrix([[1, 2, 3], [4, 5, 6], [7, 8, 9]])
        
        let expected = Matrix([[30, 36, 42], [66, 81, 96]])
        
        XCTAssertEqual(expected, left * right)
    }
    
    func testMatrixMultiplicationPerformance() {
        
        getCoefficients(n0: 3, numberOfIterations: 3){
            
            let left = Matrix<Int>(randomWithSize: $0, intervals: 0 ... 10)
            let right = Matrix<Int>(randomWithSize: $0, intervals: 0 ... 10)
            
            return timeBlock(){
                
                left * right
            }
        }
    }
    
    
    // MARK: High Performance Function Tests
    
    func testTransposeFloat() {
        
        var A = Matrix<Float>([[1, 2, 3, 4] ,[5, 6, 7, 8] ,[9, 10, 11, 12]])
        XCTAssertEqual(Matrix<Float>([[1, 5, 9], [2, 6, 10], [3, 7, 11], [4, 8, 12]]), transpose(A))
        
        A = Matrix()
        XCTAssertEqual(Matrix<Float>(), transpose(A))
    }
    
    
    func testTransposeFloatPerformance() {
        
        let A = Matrix<Float>(randomWithSize: 10_000)
        
        compareBaseline(61.5537649989128, title: "10_000x10_000 Float Matrix Tranpose Performance", n: 1){
            
            transpose(A)
        }
    }
    
    
    func testTransposeDouble() {
        
        var A = Matrix<Double>([[1, 2, 3, 4] ,[5, 6, 7, 8] ,[9, 10, 11, 12]])
        XCTAssertEqual(Matrix<Double>([[1, 5, 9], [2, 6, 10], [3, 7, 11], [4, 8, 12]]), transpose(A))
        
        A = Matrix()
        XCTAssertEqual(Matrix<Double>(), transpose(A))
    }
    
    
    func testTransposeDoublePerformance() {
        
        let A = Matrix<Double>(randomWithSize: 10_000)
        
        compareBaseline(61.5537649989128, title: "10_000x10_000 Float Matrix Tranpose Performance", n: 1){
            
            transpose(A)
        }
    }
    
    
    
    // MARK: - Objective-C Bridged Function Tests
    
    func testBridgedLUDecompositionFloat() {
        
        var matrix = Matrix<Float>([[1, 2], [3, 4]])
        var (L, U, P) = LUDecomposition(matrix)!
        XCTAssertEqual(matrix, P*L*U)
        
        matrix = [[1, 2, -3, 1], [2, 4, 0, 7], [-1, 3, 2, 0]]
        (L, U, P) = LUDecomposition(matrix)!
        XCTAssertEqual(matrix, P*L*U)
    }
    
    
    
    // MARK: - Dimension Tests
    
    func testDimensionsSizeInit() {
        
        let dimensions = Dimensions(size: 3)
        
        XCTAssertTrue(dimensions.isSquare)
        XCTAssertEqual(3, dimensions.rows)
        XCTAssertEqual(3, dimensions.columns)
    }
    
    func testDimensionMinimum() {
        
        let dimensions = Dimensions(1, 3)
        
        XCTAssertEqual(1, dimensions.minimum)
    }
    
    func testDimensionIsSquare() {
        
        var dimensions = Dimensions(2, 2)
        
        XCTAssertTrue(dimensions.isSquare)
        
        dimensions = Dimensions(2, 5)
        
        XCTAssertFalse(dimensions.isSquare)
    }
    
    func testDimensionEquality() {
        
        let firstDimensions = Dimensions(1, 4)
        var secondDimensions = Dimensions(3, 5)
        
        XCTAssertNotEqual(firstDimensions, secondDimensions)
        
        secondDimensions = Dimensions(3, 4)
        
        XCTAssertNotEqual(firstDimensions, secondDimensions)
        
        secondDimensions = Dimensions(1, 4)
        
        XCTAssertEqual(firstDimensions, secondDimensions)
    }
    
    func testDimensionTupleEqualityRight() {
        
        let dimensions = Dimensions(1, 4)
        
        XCTAssertFalse(dimensions == (3, 5))
        
        XCTAssertFalse(dimensions == (3, 4))
        
        XCTAssertTrue(dimensions == (1, 4))
    }
    
    func testDimensionTupleEqualityLeft() {
        
        let dimensions = Dimensions(1, 4)
        
        XCTAssertFalse((3, 5) == dimensions)
        
        XCTAssertFalse((3, 4) == dimensions)
        
        XCTAssertTrue((1, 4) == dimensions)
    }
    
    func testDimensionAddition() {
        
        let firstDimensions = Dimensions(1, 4)
        let secondDimensions = Dimensions(3, 5)
        let expected = Dimensions(4, 9)
        
        XCTAssertEqual(expected, firstDimensions + secondDimensions)
    }
    
    func testDimensionNegation() {
        
        let dimensions = Dimensions(2, 3)
        let expected = Dimensions(-2, -3)
        
        XCTAssertEqual(expected, -dimensions)
    }
    
    func testDimensionSubstraction() {
        
        let firstDimensions = Dimensions(1, 5)
        let secondDimensions = Dimensions(3, 4)
        let expected = Dimensions(-2, 1)
        let result = firstDimensions - secondDimensions
        
        XCTAssertEqual(expected, result)
    }
    
}
