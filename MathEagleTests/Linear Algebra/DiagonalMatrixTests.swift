//
//  DiagonalMatrixTests.swift
//  MathEagle
//
//  Created by Rugen Heidbuchel on 01/06/15.
//  Copyright (c) 2015 Jorestha Solutions. All rights reserved.
//

import XCTest
import MathEagle


class DiagonalMatrixTests: XCTestCase {
    
    
    // MARK: Initialisers
    
    func testInitDiagonal() {
        
        let D = DiagonalMatrix(diagonal: [1, 2, 3, 4])
        XCTAssertEqual(4, D.size!)
        XCTAssertEqual([1, 2, 3, 4], D.diagonalElements)
        XCTAssertEqual([1, 2, 3, 4], D.diagonalElements(0))
    }
    
    
    func testInitDiagonalDimensions() {
        
        let D = DiagonalMatrix(diagonal: [1, 2, 3, 4], dimensions: Dimensions(4, 6))
        XCTAssertEqual(Dimensions(4, 6), D.dimensions)
        XCTAssertEqual([1, 2, 3, 4], D.diagonalElements)
        XCTAssertEqual([1, 2, 3, 4], D.diagonalElements(0))
    }
    
    
    func testInitDimensionsGenerator() {
        
        let D = DiagonalMatrix(dimensions: Dimensions(2, 3)){ $0.row }
        XCTAssertEqual(Dimensions(2, 3), D.dimensions)
        XCTAssertEqual([0, 1], D.diagonalElements)
        XCTAssertEqual([0, 1], D.diagonalElements(0))
        XCTAssertEqual([[0, 0, 0], [0, 1, 0]], D.elements)
    }
    
    
    func testInitFilledWithDimensions() {
        
        let D = DiagonalMatrix(filledWith: 3, dimensions: Dimensions(2, 3))
        XCTAssertEqual(Dimensions(2, 3), D.dimensions)
        XCTAssertEqual([[3, 0, 0], [0, 3, 0]], D.elements)
    }
    
    
    
    // MARK: Properties
    
    func testRank() {
        
        var D = DiagonalMatrix(filledWith: 3, dimensions: Dimensions(2, 4))
        XCTAssertEqual(2, D.rank)
        
        D = DiagonalMatrix(diagonal: [1, 2, 3, 0, 5])
        XCTAssertEqual(4, D.rank)
    }
    
    
    func testDeterminant() {
        
        var D = DiagonalMatrix(diagonal: [1, 2, 3])
        XCTAssertEqual(6, D.determinant)
        
        D = DiagonalMatrix(diagonal: [4, 2, 0, 5])
        XCTAssertEqual(0, D.determinant)
    }
    
    
    func testDiagonalElements() {
        
        var D = DiagonalMatrix(diagonal: [1, 2, 3])
        XCTAssertEqual([1, 2, 3], D.diagonalElements)
        
        D = DiagonalMatrix(filledWith: 5, dimensions: Dimensions(size: 2))
        XCTAssertEqual([5, 5], D.diagonalElements)
    }
    
    
    func testSetDiagonalElements() {
        
        var D = DiagonalMatrix(diagonal: [1, 2, 3, 4])
        D.diagonalElements = [2, 3, 5]
        XCTAssertEqual([2, 3, 5], D.diagonalElements)
        XCTAssertEqual(Dimensions(size: 3), D.dimensions)
        
        D = DiagonalMatrix(filledWith: 5, dimensions: Dimensions(3, 4))
        D.diagonalElements = [1, 2, 3, 4]
        XCTAssertEqual([1, 2, 3, 4], D.diagonalElements)
        XCTAssertEqual(Dimensions(size: 4), D.dimensions)
        
        D = DiagonalMatrix(filledWith: 5, dimensions: Dimensions(3, 4))
        D.diagonalElements = [1, 2, 3, 4, 5]
        XCTAssertEqual([1, 2, 3, 4, 5], D.diagonalElements)
        XCTAssertEqual(Dimensions(size: 5), D.dimensions)
        
        D = DiagonalMatrix(filledWith: 5, dimensions: Dimensions(2, 4))
        D.diagonalElements = [1, 2, 3]
        XCTAssertEqual([1, 2, 3], D.diagonalElements)
        XCTAssertEqual(Dimensions(3, 4), D.dimensions)
        
        D = DiagonalMatrix(filledWith: 5, dimensions: Dimensions(4, 2))
        D.diagonalElements = [1, 2, 3]
        XCTAssertEqual([1, 2, 3], D.diagonalElements)
        XCTAssertEqual(Dimensions(4, 3), D.dimensions)
        
        D = DiagonalMatrix(filledWith: 5, dimensions: Dimensions(3, 4))
        D.diagonalElements = [1, 2]
        XCTAssertEqual([1, 2], D.diagonalElements)
        XCTAssertEqual(Dimensions(2, 4), D.dimensions)
        
        D = DiagonalMatrix(filledWith: 5, dimensions: Dimensions(4, 3))
        D.diagonalElements = [1, 2]
        XCTAssertEqual([1, 2], D.diagonalElements)
        XCTAssertEqual(Dimensions(4, 2), D.dimensions)
        
        D = DiagonalMatrix(filledWith: 5, dimensions: Dimensions(4, 4))
        D.diagonalElements = [1, 2]
        XCTAssertEqual([1, 2], D.diagonalElements)
        XCTAssertEqual(Dimensions(size: 2), D.dimensions)
    }
    
    
    func testIsUpperTriangular() {
        
        var D = DiagonalMatrix(filledWith: 3, dimensions: Dimensions(2, 4))
        XCTAssertFalse(D.isUpperTriangular())
        
        D = DiagonalMatrix(diagonal: [1, 2, 3, 0, 5])
        XCTAssert(D.isUpperTriangular())
        
        D = DiagonalMatrix(diagonal: [0, 0, 0, 0, 0])
        XCTAssert(D.isUpperTriangular(3))
        
        D = DiagonalMatrix(diagonal: [1, 2, 3, 0, 0])
        XCTAssert(D.isUpperTriangular(-3))
    }


    func testIsLowerTriangular() {
        
        var D = DiagonalMatrix(filledWith: 3, dimensions: Dimensions(2, 4))
        XCTAssertFalse(D.isLowerTriangular())
        
        D = DiagonalMatrix(diagonal: [1, 2, 3, 0, 5])
        XCTAssert(D.isLowerTriangular())
        
        D = DiagonalMatrix(diagonal: [0, 0, 0, 0, 0])
        XCTAssert(D.isLowerTriangular(-3))
        
        D = DiagonalMatrix(diagonal: [1, 2, 3, 0, 0])
        XCTAssert(D.isLowerTriangular(3))
    }
    
    
    func testIsUpperHessenberg() {
        
        var D = DiagonalMatrix(filledWith: 3, dimensions: Dimensions(2, 4))
        XCTAssertFalse(D.isUpperHessenberg)
        
        D = DiagonalMatrix(diagonal: [1, 2, 3, 0, 5])
        XCTAssert(D.isUpperHessenberg)
    }
    
    
    func testIsLowerHessenberg() {
        
        var D = DiagonalMatrix(filledWith: 3, dimensions: Dimensions(2, 4))
        XCTAssertFalse(D.isLowerHessenberg)
        
        D = DiagonalMatrix(diagonal: [1, 2, 3, 0, 5])
        XCTAssert(D.isLowerHessenberg)
    }
    
    
    func testMaxElement() {
        
        var D = DiagonalMatrix(filledWith: 3, dimensions: Dimensions(2, 4))
        XCTAssertEqual(D.maxElement, 3)
        
        D = DiagonalMatrix(diagonal: [1, 2, 3, 0, 5])
        XCTAssertEqual(D.maxElement, 5)
        
        D = DiagonalMatrix(diagonal: [0, 0, 0, 0, 0])
        XCTAssertEqual(D.maxElement, 0)
    }
    
    
    func testMinElement() {
        
        var D = DiagonalMatrix(filledWith: 3, dimensions: Dimensions(2, 4))
        // Off diagonal elements are 0
        XCTAssertEqual(D.minElement, 0)
        
        D = DiagonalMatrix(diagonal: [1, 2, 3, 0, 5])
        XCTAssertEqual(D.minElement, 0)
        
        D = DiagonalMatrix(diagonal: [0, 0, 0, 0, 0])
        XCTAssertEqual(D.minElement, 0)
    }
    
    
    func testIsZero() {
        
        var D = DiagonalMatrix(filledWith: 3, dimensions: Dimensions(2, 4))
        XCTAssertFalse(D.isZero)
        
        D = DiagonalMatrix(diagonal: [1, 2, 3, 0, 5])
        XCTAssertFalse(D.isZero)
        
        D = DiagonalMatrix(diagonal: [0, 0, 0, 0, 0])
        XCTAssert(D.isZero)
    }
    
    
    func testIsDiagonal() {
        
        var D = DiagonalMatrix(filledWith: 3, dimensions: Dimensions(2, 4))
        XCTAssert(D.isDiagonal)
        
        D = DiagonalMatrix(diagonal: [1, 2, 3, 0, 5])
        XCTAssert(D.isDiagonal)
    }
    
    
    func testIsSymmetrical() {
        
        var D = DiagonalMatrix(filledWith: 3, dimensions: Dimensions(2, 4))
        XCTAssertFalse(D.isSymmetrical)
        
        D = DiagonalMatrix(diagonal: [1, 2, 3, 0, 5])
        XCTAssert(D.isSymmetrical)
    }
    
    
    // MARK: Element Methods
    
    func testElement() {
        
        var D = DiagonalMatrix(filledWith: 3, dimensions: Dimensions(2, 4))
        XCTAssertEqual(D.element(0,0),3)
        XCTAssertEqual(D.element(0,1),0)
        XCTAssertEqual(D.element(1,0),0)
        XCTAssertEqual(D.element(1,1),3)
        
        D = DiagonalMatrix(diagonal: [1, 2, 3, 0, 5])
        XCTAssertEqual(D.element(0,0),1)
        XCTAssertEqual(D.element(0,1),0)
        XCTAssertEqual(D.element(1,0),0)
        XCTAssertEqual(D.element(1,1),2)
    }

    
    func testSetElement() {
        
        let D = DiagonalMatrix(diagonal: [1, 2, 3, 0, 5])
        D.setElement(atRow:0, atColumn:0, toElement:6)
        XCTAssertEqual(D, DiagonalMatrix(diagonal: [6, 2, 3, 0, 5]))
        D.setElement(atRow:1, atColumn:1, toElement:7)
        XCTAssertEqual(D, DiagonalMatrix(diagonal: [6, 7, 3, 0, 5]))
    }
    
    
    func testRow() {
        
        let D = DiagonalMatrix(diagonal: [1, 2, 3, 0, 5])
        XCTAssertEqual(D.row(0), [1, 0, 0, 0, 0])
        XCTAssertEqual(D.row(1), [0, 2, 0, 0, 0])
    }


    func testSetRow() {
        
        let D = DiagonalMatrix(diagonal: [1, 2, 3, 0, 5])
        D.setRow(atIndex:0, toRow:[6, 0, 0, 0, 0])
        D.setRow(atIndex:1, toRow:[0, 7, 0, 0, 0])
        XCTAssertEqual(D, DiagonalMatrix(diagonal: [6, 7, 3, 0, 5]))
    }
    
    
    func testColumn() {
        
        let D = DiagonalMatrix(diagonal: [1, 2, 3, 0, 5])
        XCTAssertEqual(D.column(0), [1, 0, 0, 0, 0])
        XCTAssertEqual(D.column(1), [0, 2, 0, 0, 0])
    }
    
    
    func testSetColumn() {
        
        let D = DiagonalMatrix(diagonal: [1, 2, 3, 0, 5])
        D.setColumn(atIndex:0, toColumn:[6, 0, 0, 0, 0])
        D.setColumn(atIndex:1, toColumn:[0, 7, 0, 0, 0])
        XCTAssertEqual(D, DiagonalMatrix(diagonal: [6, 7, 3, 0, 5]))
    }
    
    
    // MARK: DiagonalMatrix Equality
    
    func testDiagonalMatrixEquality() {
        let C = DiagonalMatrix(diagonal: [1, 2, 3, 0, 5])
        let D = DiagonalMatrix(diagonal: [5, -1, 2, -1, -5])
        XCTAssert(C==C)
        XCTAssert(D==D)
        XCTAssertFalse(C==D)
    }


    // MARK: Matrix Addition
    
    func testDiagonalMatrixAddition() {
        let C = DiagonalMatrix(diagonal: [1, 2, 3, 0, 5])
        let D = DiagonalMatrix(diagonal: [5, -1, 2, -1, -5])
        XCTAssertEqual(C+D, DiagonalMatrix(diagonal: [6, 1, 5, -1, 0]))
    }
}
