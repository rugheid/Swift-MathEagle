//
//  MatrixTests.swift
//  SwiftMath
//
//  Created by Rugen Heidbuchel on 22/12/14.
//  Copyright (c) 2014 Jorestha Solutions. All rights reserved.
//

import Cocoa
import XCTest

class MatrixTests: XCTestCase {
    
    // MARK: Initialisation Tests
    
    func testElementsInit() {
        
        let initElements = [[1, 2], [3, 4]]
        var matrix = Matrix(initElements)
        
        XCTAssertEqual(initElements, matrix.elements)
    }
    
    func testArrayLiterableInit() {
        
        var matrix: Matrix = [[1, 2], [3, 4]]
        
        XCTAssertEqual([[1, 2], [3, 4]], matrix.elements)
    }
    
    func testDimensionsGeneratorInit() {
        
        let matrix = Matrix(dimensions: Dimensions(2, 3)){ $0.row + $0.column }
        
        let expected = Matrix([[0, 1, 2], [1, 2, 3]])
        
        XCTAssertEqual(expected, matrix)
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
            
            let matrix = Matrix(symmetrical: diagonalElements)
        }
    }
    
    func testFilledWithSizeInit() {
        
        // 3 x 3 matrix filled with "a"
        var matrix = Matrix(filledWith: 5, size: 3)
        
        var expected = Matrix([[5, 5, 5], [5, 5, 5], [5, 5, 5]])
        
        XCTAssertEqual(expected, matrix)
        
        // empty matrix
        matrix = Matrix(filledWith: 5, size: 0)
        
        XCTAssertTrue(matrix.isEmpty)
    }
    
    func testFilledWithSizeInitPerformance() {
        
        self.measureBlock(){
            
            let matrix = Matrix(filledWith: 4, size: 10000)
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
        
        var matrix2 = Matrix(filledWith: 5, dimensions: Dimensions(2, 3))
        
        var expected2 = Matrix([[5, 5, 5], [5, 5, 5]])
        
        XCTAssertEqual(expected2, matrix2)
    }
    
    func testIdentityInit() {
        
        // 3 x 3 identity matrix with strings
        var matrix = Matrix<Int>(identityOfSize: 3)
        
        XCTAssertEqual([[1, 0, 0], [0, 1, 0], [0, 0, 1]], matrix.elements)
    }
    
    func testIdentityPerformance() {
        
        self.measureBlock(){
            
            let matrix = Matrix<Int>(identityOfSize: 1000)
        }
    }
    
    func testDiagonalInit() {
        
        let matrix = Matrix(diagonal: [1, 2, 3])
        
        XCTAssertEqual(Matrix([[1, 0, 0], [0, 2, 0], [0, 0, 3]]), matrix)
    }
    
    
    // MARK: Subscript Tests
    
    func testElementsSubscript() {
        
        let initElements = [[1, 2], [3, 4]]
        var matrix = Matrix(initElements)
        
        XCTAssertEqual(3, matrix.elements[1][0])
    }
    
    func testSubscriptGet() {
        
        var initElements = [[1, 2], [3, 4]]
        var matrix = Matrix(initElements)
        
        XCTAssertEqual(Vector([1, 2]), matrix[0])
        XCTAssertEqual(Vector([3, 4]), matrix[1])
    }
    
    func testSubscriptSet() {
        
        var initElements = [[1, 2], [3, 4]]
        var matrix = Matrix(initElements)
        matrix[0] = [5, 6]
        
        XCTAssertEqual(Vector([5, 6]), matrix[0])
    }
    
    func testSubscriptRangeGet() {
        
        var matrix = Matrix([[1, 2], [3, 4], [5,6]])
        
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
        
        var matrix = Matrix([[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12]])
        
        XCTAssertEqual(Matrix([[6, 7], [10, 11]]), matrix[1...2, 1...2])
        XCTAssertEqual(Matrix([[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12]]), matrix[0...2, 0...3])
        XCTAssertEqual(Matrix([[2]]), matrix[0..<1, 1..<2])
    }
    
    func testSubscriptRowRangeColumnRangeSet() {
        
        var matrix = Matrix([[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12]])
        
        matrix[1...2, 2...3] = Matrix([[13, 14], [15, 16]])
        
        XCTAssertEqual(Matrix([[1, 2, 3, 4], [5, 6, 13, 14], [9, 10, 15, 16]]), matrix)
    }
    
    func testSubscriptRowRangeColumnGet() {
        
        var matrix = Matrix([[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12]])
        
        XCTAssertEqual(Vector([6, 10]), matrix[1...2, 1])
        XCTAssertEqual(Vector([4, 8, 12]), matrix[0...2, 3])
    }
    
    func testSubscriptRowRangeColumnSet() {
        
        var matrix = Matrix([[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12]])
        
        matrix[1...2, 2] = Vector([13, 14])
        
        XCTAssertEqual(Matrix([[1, 2, 3, 4], [5, 6, 13, 8], [9, 10, 14, 12]]), matrix)
    }
    
    func testSubscriptRowColumnRangeGet() {
        
        var matrix = Matrix([[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12]])
        
        XCTAssertEqual(Vector([6, 7]), matrix[1, 1...2])
        XCTAssertEqual(Vector([9, 10, 11, 12]), matrix[2, 0...3])
    }
    
    func testSubscriptRowColumnRangeSet() {
        
        var matrix = Matrix([[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12]])
        
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
        
        let matrix = randomIntMatrix(withSize: 3)
        
        let negative = mmap(matrix){ -$0 }
        
        let expected = -matrix
        
        XCTAssertEqual(expected, negative)
    }
    
    func testMatrixMapPerformance() {
        
        let (a, b) = getCoefficients(n0: 2, numberOfIterations: 5){
            
            let matrix = randomIntMatrix(intRange: 0 ... 10, size: $0)
            
            return self.timeBlock(){
                
                mmap(matrix){ $0 + 1 }
            }
        }
        
        println("\nb for matrix map = \(b)")
        
        let matrix = randomIntMatrix(intRange: 0 ... 10, size: 100)
        
        let time = timeBlock(){
            
            mmap(matrix){ $0 + 1 }
        }
        
        let baseline = 0.0261270403862
        println("Time to map 100x100 matrix = \(time) seconds\nThis is \(baseline/time) times faster than baseline.\n")
    }
    
    func testMatrixReduce() {
        
        let matrix = Matrix([[1, 2, 3], [4, 5, 6]])
        
        let totalSum = mreduce(matrix, 0){ $0 + $1 }
        
        XCTAssertEqual(21, totalSum)
    }
    
    func testMatrixReducePerformance() {
        
        let (a, b) = getCoefficients(n0: 2, numberOfIterations: 5){
            
            let matrix = randomIntMatrix(intRange: -2 ... 2, size: $0)
            
            return self.timeBlock(){
                
                mreduce(matrix, 0, +)
            }
        }
        
        println("\nb for matrix reduce = \(b)")
        
        let matrix = randomIntMatrix(intRange: -2 ... 2, size: 100)
        
        let time = timeBlock(){
            
            mreduce(matrix, 0, +)
        }
        
        let baseline = 0.0323160290718079
        println("Time to reduce 100x100 matrix = \(time) seconds\nThis is \(baseline/time) times faster than baseline.\n")
    }
    
    func testMatrixCombine() {
        
        let left = Matrix([[1, 2, 3], [4, 5, 6]])
        let right = Matrix([[7, 8, 9], [10, 11, 12]])
        
        let combined = mcombine(left, right){ $0 + $1 }
        
        let expected = left + right
        
        XCTAssertEqual(expected, combined)
    }
    
    func testMatrixCombinePerformance() {
        
        let (a, b) = getCoefficients(n0: 2, numberOfIterations: 5){
            
            let left = randomIntMatrix(intRange: 0 ... 10, size: $0)
            let right = randomIntMatrix(intRange: -10 ... 0, size: $0)
            
            return self.timeBlock(){
                
                mcombine(left, right, +)
            }
        }
        
        println("\nb for matrix reduce = \(b)")
        
        let left = randomIntMatrix(intRange: 0 ... 10, size: 100)
        let right = randomIntMatrix(intRange: -10 ... 0, size: 100)
        
        let time = timeBlock(){
            
            mcombine(left, right, +)
        }
        
        let baseline = 0.222007989883423
        println("Time to reduce 100x100 matrix = \(time) seconds\nThis is \(baseline/time) times faster than baseline.\n")
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
    
    func testTrace() {
        
        var matrix = Matrix<Int>(identityOfSize: 10)
        
        XCTAssertEqual(10, matrix.trace)
        
        matrix = Matrix(filledWith: 5, size: 3)
        
        XCTAssertEqual(15, matrix.trace)
    }
    
    func testMatrixDeterminant() {
        
        var matrix = Matrix<Double>(identityOfSize: 10)
        XCTAssertEqual(1.0, matrix.determinant)
        
        matrix = Matrix([[2.0, 4.0], [3.0, 7.0]])
        XCTAssertEqualWithAccuracy(2.0, matrix.determinant, ACCURACY)
        
        matrix = Matrix<Double>([[6, 7, -3, 2], [5, -2, -2, 3], [8, 6, 5, 5], [-8, -8, 0, 3]])
        XCTAssertEqualWithAccuracy(-2759.0, matrix.determinant, ACCURACY)
    }
    
    func testDiagonalElements() {
        
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
    
    func testMaxValue() {
        
        var matrix = Matrix([[1, 2, 3], [6, 5, 4]])
        
        XCTAssertEqual(6, matrix.maxElement)
        
        matrix = Matrix(filledWith: 5, dimensions: Dimensions(5, 8))
        
        XCTAssertEqual(5, matrix.maxElement)
    }
    
    func testMaxValuePerformance() {
        
        let (a, b) = getCoefficients(n0: 10, numberOfIterations: 5){
            
            let matrix = randomIntMatrix(intRange: -1000...1000, size: $0)
            
            return self.timeBlock(){
                
                matrix.maxElement
            }
        }
    }
    
    func testMaxValueTime() {
        
        let matrix = randomIntMatrix(intRange: -1000...1000, size: 100)
        
        self.measureBlock(){
            
            let max = matrix.maxElement
        }
    }
    
    func testMinValue() {
        
        var matrix = Matrix([[1, 2, 3], [6, 5, 4]])
        
        XCTAssertEqual(1, matrix.minElement)
        
        matrix = Matrix(filledWith: 5, dimensions: Dimensions(5, 8))
        
        XCTAssertEqual(5, matrix.minElement)
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
        var matrix2 = Matrix<Int>()
        
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
    }
    
    func testIsSymmetricalPerformance() {
        
        var (a, b) = getCoefficients(n0: 10, numberOfIterations: 5){
            
            let matrixElements = [Int](count: 2*$0 - 1, repeatedValue: 2)
            
            let matrix = Matrix(symmetrical: matrixElements)
            
            return self.timeBlock(){
                
                matrix.isSymmetrical
            }
        }
        
        println("Symmetrical performance \n b = \(b)")
    }
    
    
    
    // MARK: Method tests
    
    func testElement() {
        
        var initElements = [[1, 2], [3, 4]]
        var matrix = Matrix(initElements)
        
        XCTAssertEqual(2, matrix.element(0, 1))
    }
    
    func testSetElementAtRowAtColumn() {
        
        var initElements = [[1, 2], [3, 4]]
        var matrix = Matrix(initElements)
        
        matrix.setElement(atRow: 0, atColumn: 1, toElement: 5)
        
        XCTAssertEqual(5, matrix.element(0, 1))
    }
    
    func testSetElementAtIndex() {
        
        var initElements = [[1, 2], [3, 4]]
        var matrix = Matrix(initElements)
        
        matrix.setElement(atIndex: (0, 1), toElement: 5)
        
        XCTAssertEqual(5, matrix.element(0, 1))
    }
    
    func testRow() {
        
        // 2 x 3 matrix
        var initElements = [[1, 2, 3], [4, 5, 6]]
        var matrix = Matrix(initElements)
        
        XCTAssertEqual(Vector([4,5,6]), matrix.row(1))
    }
    
    func testSetRow() {
        
        // 2 x 3 matrix
        var initElements = [[1, 2, 3], [4, 5, 6]]
        var matrix = Matrix(initElements)
        
        matrix.setRow(atIndex: 0, toRow: [7, 8, 9])
        
        XCTAssertEqual(Vector([7, 8, 9]), matrix[0])
    }
    
    func testSwitchRows() {
        
        var initElements = [[1, 2, 3], [4, 5, 6]]
        var matrix = Matrix(initElements)
        
        matrix.switchRows(0, 1)
        
        XCTAssertEqual(Vector([4, 5, 6]), matrix[0])
        XCTAssertEqual(Vector([1, 2, 3]), matrix[1])
    }
    
    func testColumn() {
        
        // 2 x 3 matrix
        var initElements = [[1, 2, 3], [4, 5, 6]]
        var matrix = Matrix(initElements)
        
        XCTAssertEqual(Vector([2,5]), matrix.column(1))
    }
    
    func testSetColumn() {
        
        // 2 x 3 matrix
        var initElements = [[1, 2, 3], [4, 5, 6]]
        var matrix = Matrix(initElements)
        
        matrix.setColumn(atIndex: 1, toColumn: [7, 8])
        
        XCTAssertEqual(Vector([7, 8]), matrix.column(1))
        XCTAssertEqual(Vector([1, 7, 3]), matrix[0])
        XCTAssertEqual(Vector([4, 8, 6]), matrix[1])
    }
    
    func testSwitchColumns() {
        
        // 2 x 3 matrix
        var initElements = [[1, 2, 3], [4, 5, 6]]
        var matrix = Matrix(initElements)
        
        matrix.switchColumns(1, 2)
        
        XCTAssertEqual(Vector([2, 5]), matrix.column(2))
        XCTAssertEqual(Vector([3, 6]), matrix.column(1))
    }
    
    func testSubmatrix() {
        
        var matrix = Matrix([[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12]])
        
        XCTAssertEqual(Matrix([[6, 7], [10, 11]]), matrix.submatrix(1...2, 1...2))
        XCTAssertEqual(Matrix([[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12]]), matrix.submatrix(0...2, 0...3))
        XCTAssertEqual(Matrix([[2]]), matrix.submatrix(0..<1, 1..<2))
    }
    
    func testSetSubmatrix() {
        
        var matrix = Matrix([[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12]])
        
        matrix.setSubmatrix(1...2, 2...3, toMatrix: Matrix([[13, 14], [15, 16]]))
        
        XCTAssertEqual(Matrix([[1, 2, 3, 4], [5, 6, 13, 14], [9, 10, 15, 16]]), matrix)
    }
    
    func testSubvectorRowRange() {
        
        var matrix = Matrix([[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12]])
        
        XCTAssertEqual(Vector([6, 10]), matrix.subvector(1...2, 1))
        XCTAssertEqual(Vector([4, 8, 12]), matrix.subvector(0...2, 3))
    }
    
    func testSetSubvectorRowRange() {
        
        var matrix = Matrix([[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12]])
        
        matrix.setSubvector(1...2, 2, toVector: Vector([13, 14]))
        
        XCTAssertEqual(Matrix([[1, 2, 3, 4], [5, 6, 13, 8], [9, 10, 14, 12]]), matrix)
    }
    
    func testSubvectorColumnRange() {
        
        var matrix = Matrix([[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12]])
        
        XCTAssertEqual(Vector([6, 7]), matrix.subvector(1, 1...2))
        XCTAssertEqual(Vector([9, 10, 11, 12]), matrix.subvector(2, 0...3))
    }
    
    func testSetSubvectorColumnRange() {
        
        var matrix = Matrix([[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12]])
        
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
        
        for i in 0 ..< 100 {
            
            let (L, U, P) = matrix.LUDecomposition
        }
        
        let elapsed = NSDate().timeIntervalSinceDate(start)
        let python = 0.011
        let slower = elapsed/python
        
        println("Swift time = \(elapsed)\nPython time = \(python)\nSwift is still \(slower) times slower than python...")
    }
    
    
    
    // MARK: Operator Tests
    
    func testMatrixEquality() {
        
        var matrix1 = Matrix([[1,2], [3, 4]])
        var matrix2 = Matrix([[1, 2, 3], [4, 5, 6], [7, 8, 9]])
        var matrix3 = Matrix([[1, 2], [3, 5]])
        var matrix4 = Matrix([[1, 2], [3, 4]])
        
        XCTAssertNotEqual(matrix1, matrix2)
        XCTAssertNotEqual(matrix1, matrix3)
        XCTAssertEqual(matrix1, matrix4)
        
        // 2 empty matrices
        var matrix5 = Matrix<Int>()
        var matrix6 = Matrix<Int>()
        
        XCTAssertEqual(matrix5, matrix6)
    }
    
    func testMatrixAddition() {
        
        var left = Matrix([[1, 2], [3, 4]])
        var right = Matrix([[5, 6], [7, 8]])
        
        var expected = Matrix([[6, 8], [10, 12]])
        
        XCTAssertEqual(expected, left + right)
    }
    
    func testMatrixNegation() {
        
        var matrix = Matrix([[1, 2], [3, 4]])
        
        var expected = Matrix([[-1, -2], [-3, -4]])
        var negative = -matrix
        
        XCTAssertEqual(expected, -matrix)
    }
    
    func testMatrixSubstraction() {
        
        var left = Matrix([[1, 2], [3, 4]])
        var right = Matrix([[0, 2], [-1, 10]])
        
        var expected = Matrix([[1, 0], [4, -6]])
        
        XCTAssertEqual(expected, left - right)
    }
    
    func testMatrixScalarMultiplication() {
        
        var scalar = 3
        var matrix = Matrix([[1, 2], [3, 4]])
        
        var expected = Matrix([[3, 6], [9, 12]])
        
        XCTAssertEqual(expected, scalar * matrix)
        XCTAssertEqual(expected, matrix * scalar)
        
        scalar = 0
        
        expected = Matrix(filledWith: 0, size: 2)
        
        XCTAssertEqual(expected, scalar * matrix)
        XCTAssertEqual(expected, matrix * scalar)
    }
    
    func testMatrixMultiplication() {
        
        var left = Matrix([[1, 2, 3], [4, 5, 6]])
        var right = Matrix([[1, 2, 3], [4, 5, 6], [7, 8, 9]])
        
        var expected = Matrix([[30, 36, 42], [66, 81, 96]])
        
        XCTAssertEqual(expected, left * right)
    }
    
    func testMatrixMultiplicationPerformance() {
        
        let (a, b) = getCoefficients(n0: 3, numberOfIterations: 3){
            
            let left = randomIntMatrix(intRange: 0...10, size: $0)
            let right = randomIntMatrix(intRange: 0...10, size: $0)
            
            return self.timeBlock(){
                
                left * right
            }
        }
    }
    
    
    // MARK: Matrix Generator Tests
    
    func testRandomIntMatrixWithDimensionsWithGenerator() {
        
        // 3 x 4 matrix filled with 6
        var matrix = randomIntMatrix(withDimensions: Dimensions(3, 4)){ 6 }
        
        var expected = Matrix(filledWith: 6, dimensions: Dimensions(3, 4))
        
        XCTAssertEqual(expected, matrix)
        
        // empty matrix
        matrix = randomIntMatrix(withDimensions: Dimensions(0, 0)){ 4 }
        
        XCTAssertTrue(matrix.isEmpty)
    }
    
    func testRandomIntMatrixWithSizeWithGenerator() {
        
        //5 x 5 matrix filled with 6
        var matrix = randomIntMatrix(withSize: 5){ 6 }
        
        var expected = Matrix(filledWith: 6, size: 5)
        
        XCTAssertEqual(expected, matrix)
    }
    
    func testRandomIntMatrixWithDimensions() {
        
        let matrix = randomIntMatrix(withDimensions: Dimensions(2, 3))
        
        XCTAssertEqual(2, matrix.dimensions.rows)
        XCTAssertEqual(3, matrix.dimensions.columns)
    }
    
    func testRandomIntMatrixWithSize() {
        
        let matrix = randomIntMatrix(withSize: 5)
        
        XCTAssertEqual(5, matrix.dimensions.rows)
        XCTAssertEqual(5, matrix.dimensions.columns)
    }
    
    func testRandomIntMatrixWithRangeWithDimensions() {
        
        let matrix = randomIntMatrix(intRange: 0...10, dimensions: Dimensions(5, 7))
        
        XCTAssertEqual(5, matrix.dimensions.rows)
        XCTAssertEqual(7, matrix.dimensions.columns)
        XCTAssertTrue(matrix.maxElement <= 10)
    }
    
    
    
    // MARK: - Dimension Tests
    
    func testDimensionsSizeInit() {
        
        var dimensions = Dimensions(size: 3)
        
        XCTAssertTrue(dimensions.isSquare)
        XCTAssertEqual(3, dimensions.rows)
        XCTAssertEqual(3, dimensions.columns)
    }
    
    func testDimensionMinimum() {
        
        var dimensions = Dimensions(1, 3)
        
        XCTAssertEqual(1, dimensions.minimum)
    }
    
    func testDimensionIsSquare() {
        
        var dimensions = Dimensions(2, 2)
        
        XCTAssertTrue(dimensions.isSquare)
        
        dimensions = Dimensions(2, 5)
        
        XCTAssertFalse(dimensions.isSquare)
    }
    
    func testDimensionEquality() {
        
        var firstDimensions = Dimensions(1, 4)
        var secondDimensions = Dimensions(3, 5)
        
        XCTAssertNotEqual(firstDimensions, secondDimensions)
        
        secondDimensions = Dimensions(3, 4)
        
        XCTAssertNotEqual(firstDimensions, secondDimensions)
        
        secondDimensions = Dimensions(1, 4)
        
        XCTAssertEqual(firstDimensions, secondDimensions)
    }
    
    func testDimensionTupleEqualityRight() {
        
        var dimensions = Dimensions(1, 4)
        
        XCTAssertFalse(dimensions == (3, 5))
        
        XCTAssertFalse(dimensions == (3, 4))
        
        XCTAssertTrue(dimensions == (1, 4))
    }
    
    func testDimensionTupleEqualityLeft() {
        
        var dimensions = Dimensions(1, 4)
        
        XCTAssertFalse((3, 5) == dimensions)
        
        XCTAssertFalse((3, 4) == dimensions)
        
        XCTAssertTrue((1, 4) == dimensions)
    }
    
    func testDimensionAddition() {
        
        var firstDimensions = Dimensions(1, 4)
        var secondDimensions = Dimensions(3, 5)
        var expected = Dimensions(4, 9)
        
        XCTAssertEqual(expected, firstDimensions + secondDimensions)
    }
    
    func testDimensionNegation() {
        
        var dimensions = Dimensions(2, 3)
        var expected = Dimensions(-2, -3)
        
        XCTAssertEqual(expected, -dimensions)
    }
    
    func testDimensionSubstraction() {
        
        var firstDimensions = Dimensions(1, 5)
        var secondDimensions = Dimensions(3, 4)
        var expected = Dimensions(-2, 1)
        var result = firstDimensions - secondDimensions
        
        XCTAssertEqual(expected, result)
    }
    
    
    
    // MARK: - Helper Timing Methods
    
    func getCoefficients(#n0: Int, numberOfIterations k: Int, timeBlock: Int -> Double) -> (Double, Double) {
        
        var prev: Double = 0
        var a: Double = 0, b: Double = 0
        
        for i in 0 ... k {
            
            let n = n0 * Int(pow(2, Double(i)))
            
            let time = timeBlock(n)
            
            if i > 0 {
                
                let ratio = time/prev
                
                b = log2(ratio)
                a = time / pow(Double(n), b)
                
                println("a = \(a), b = \(b) ->  \(a) * n ^ \(b)")
            }
            
            prev = time
        }
        
        return (a, b)
    }
    
    func timeBlock(block: Void -> Any) -> Double {
        
        var start = NSDate()
        
        block()
        
        var end = NSDate()
        
        return end.timeIntervalSinceDate(start)
    }
    
}
