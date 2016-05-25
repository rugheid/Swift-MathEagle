//
//  DiagonalMatrix.swift
//  MathEagle
//
//  Created by Rugen Heidbuchel on 26/05/15.
//  Copyright (c) 2015 Rugen Heidbuchel. All rights reserved.
//

import Foundation
import Accelerate


/**
    A class representing a diagonal matrix. This matrix stores it's elements in an efficient way.
    The matrix does not have to be square, but it will only have non-zero elements on it's main diagonal.
*/
public class DiagonalMatrix <T: MatrixCompatible> : Matrix<T> {

    /**
        Returns a row major ordered list of all elements in the array.
        This should be used for high performance applications.
    */
    override public var elementsList: [T] {
        
        get {
            
            var elementsList = [T]()
            
            for row in 0 ..< self.dimensions.rows {
                for col in 0 ..< self.dimensions.columns {
                    elementsList.append(row == col ? self.elementsStructure[row] : 0)
                }
            }
            
            return elementsList
        }
        
        set (newElementsList) {
            
            if newElementsList.count != self.dimensions.product {
                NSException(name: "Wrong number of elements", reason: "The number of elements in the given elementsList is not correct. \(self.dimensions.product) elements expected, but got \(newElementsList.count).", userInfo: nil).raise()
            }
            
            for i in 0 ..< self.dimensions.minimum {
                self.elementsStructure[i] = newElementsList[i * (1 + self.dimensions.columns)]
            }
        }
    }
    
    
    /**
        Returns or sets a 2 dimensional array containing the elements of the matrix.
        The array contains array's that represent rows.
    
        :performance: This method scales O(n*m) for an nxm matrix, so elementsList should be used for
                        high performance applications.
    */
    override public var elements: [[T]] {
        
        get {
            var elements = [[T]]()
            
            for r in 0 ..< self.dimensions.rows {
                
                var rowElements = [T]()
                
                for c in 0 ..< self.dimensions.columns {
                    rowElements.append(r == c ? self.elementsStructure[r] : 0)
                }
                
                elements.append(rowElements)
            }
            
            if elements.count == 0 {
                elements.append([])
            }
            
            return elements
        }
        
        set(newElements) {
            
            if newElements.count == 0 || newElements[0].count == 0 {
                self.innerDimensions = Dimensions()
            } else {
                self.innerDimensions = Dimensions(newElements.count, newElements[0].count)
            }
            
            self.elementsStructure = []
            
            for i in 0 ..< self.dimensions.minimum {
                self.elementsStructure.append(newElements[i][i])
            }
        }
    }
    
    
    
    // MARK: Initialisation
    
    /**
        Creates a square diagonal matrix with the given elements on it's main diagonal.
    */
    public init(diagonal: [T]) {
        super.init()
        
        self.elementsStructure = diagonal
        self.innerDimensions = Dimensions(size: diagonal.count)
    }
    
    
    /**
        Creates a diagonal matrix with the given dimensions and the given elements on it's main diagonal.
    
        :exception: Throws an exception when the number of given diagonal elements is not equal to the
                    minimum dimension of the given dimensions.
    */
    public init(diagonal: [T], dimensions: Dimensions) {
        super.init()
        
        if diagonal.count != dimensions.minimum {
            NSException(name: "Wrong number of elements", reason: "The number of given diagonal elements (\(diagonal.count)) is not equal to the minimum dimension of the given dimensions (\(dimensions.minimum)).", userInfo: nil).raise()
        }
        
        self.elementsStructure = diagonal
        self.innerDimensions = dimensions
    }
    
    
    /**
        Creates a diagonal matrix with the given dimensions using
        the given generator. Note that the row and column values of the indives
        will be equal.
    
        - parameter dimensions:  The dimensions the matrix should have.
        - parameter generator:   The generator used to generate the matrix.
                            This function is called for every element passing
                            the index of the element.
    */
    override public init(dimensions: Dimensions, generator: (Index) -> T) {
        super.init()
        
        self.elementsStructure = []
        self.innerDimensions = dimensions
        
        for i in 0 ..< self.dimensions.minimum {
            self.elementsStructure.append(generator([i, i]))
        }
    }
    
    
    /**
        Creates a diagonal matrix with the given dimensions with the diagonal filled with the given element.
    
        - parameter element:     The element to fill the diagonal with.
        - parameter dimensions:  The dimensions the matrix should have.
    */
    override public init(filledWith element: T, dimensions: Dimensions) {
        super.init()
        
        self.elementsStructure = [T](count: dimensions.minimum, repeatedValue: element)
        self.innerDimensions = dimensions
    }
    
    
    
    // MARK: Basic Properties
    
    /**
        Gives the rank of the matrix. This is not the tensor rank.
    
        - returns: The rank of the matrix.
    */
    override public var rank: Int {
        
        //TODO: Improve this implementation using a general count function or something using diagonalElements
        
        var rank = self.dimensions.minimum
        
        for element in self.elementsStructure {
            if element == 0 { rank -= 1 }
        }
        
        return rank
    }
    
    
    /**
        Returns the determinant of the matrix. This is the product of the diagonal elements.
    */
    override public var determinant: T {
        
        return product(self.diagonalElements)
    }
    
    
    /**
        Gets or sets the diagonal elements of the matrix.
    
        - returns: An array with the diagonal elements of the matrix.
    
        :set: When the number of given elements is bigger than the minimum dimension of the matrix,
                the dimensions will be padded as few as possible.
                This means that when a 2x4 matrix is set using 3 elements it will only be padded
                to a 3x4 matrix.
                When the number of given elements is less than the minimum dimension of the matrix,
                the minimum dimensions will shrink even more. Unless the matrix is square. When it is square,
                both dimensions will shrink.
                This means that when a 3x4 matrix is set using 2 elements it will shrink to a 2x4 matrix, but
                when a 4x4 matrix is set using 2 elements it will shrink to a 2x2 matrix.
    */
    override public var diagonalElements: [T] {
        
        get {
            return self.elementsStructure
        }
        
        set(elements) {
            
            self.elementsStructure = elements
            
            if elements.count >= self.dimensions.minimum {
                
                self.innerDimensions = Dimensions(max(elements.count, self.dimensions.rows), max(elements.count, self.dimensions.columns))
                
            } else {
                
                if self.isSquare {
                    
                    self.innerDimensions = Dimensions(size: elements.count)
                    
                } else {
                    
                    if self.dimensions.rows < self.dimensions.columns {
                        
                        self.innerDimensions = Dimensions(elements.count, self.dimensions.columns)
                        
                    } else {
                        
                        self.innerDimensions = Dimensions(self.dimensions.rows, elements.count)
                    }
                }
            }
        }
    }
    
    
    /**
        Returns the elements of the diagonal at the given index.
        0 represents the main diagonal.
        -1 means the first subdiagonal, this is the one below the main diagonal.
        Other negative numbers represent lower subdiagonals.
        1 means the first superdiagonal, this is the one above the main diagonal.
        Other positive numbers represent higher superdiagonals.
    
        - parameter n: The diagonal's index.
    
        - returns: An array representing the diagonal elements from top left to bottom right in the matrix.
    
        :exception: An exception will be raised if the diagonal at the given index does not exist.
                    This means -n > the number of rows or n > the number of columns.
    */
    override public func diagonalElements(n: Int = 0) -> [T] {
        
        if -n >= self.dimensions.rows || n >= self.dimensions.columns {
            NSException(name: "Index out the bounds.", reason: "The given index is out of bounds.", userInfo: nil).raise()
        }
        
        if n == 0 {
            return elementsStructure
        } else {
            let cnt = min(self.dimensions.minimum, n < 0 ? self.dimensions.rows + n : self.dimensions.columns - n)
            return [T](count: cnt, repeatedValue: 0)
        }
    }
    
    
    /**
        Returns a copy of the matrix with all elements under the main diagonal set to zero.
        This also applies to non-square matrices.
    */
    override public var upperTriangle: Matrix<T> {
        
        return self
    }
    
    
    /**
        Returns the upper triangle part of the matrix. This is the part of above the diagonal with the given index.
        The diagonal itself is also included. The part below the diagonal contains zero.
        0 represents the main diagonal.
        -1 means the first subdiagonal, this is the one below the main diagonal.
        Other negative numbers represent lower subdiagonals.
        1 means the first superdiagonal, this is the one above the main diagonal.
        Other positive numbers represent higher superdiagonals.
    
        :note: Note that this method also works for non-square matrices, but the returned matrix will thus be
                not upper triangular because only square matrices are upper triangular.
    
        - parameter n: The diagonal's index.
    
        - returns: A matrix where all elements under the diagonal with the given index are zero.
    
        :exception: An exception will be raised if the diagonal at the given index does not exist.
                    This means -n > the number of rows or n > the number of columns.
    */
    override public func upperTriangle(n: Int = 0) -> Matrix<T> {
        
        if -n >= self.dimensions.rows || n >= self.dimensions.columns {
            
            NSException(name: "Index out the bounds.", reason: "The given index is out of bounds.", userInfo: nil).raise()
        }
        
        if n == 0 {
            return self
        } else {
            return Matrix(filledWith: 0, dimensions: self.dimensions)
        }
    }
    
    
    /**
        Returns the lower triangle part of the matrix. This is the part of below the diagonal with the given index.
        The diagonal itself is also included. The part below the diagonal contains zero.
        0 represents the main diagonal.
        -1 means the first subdiagonal, this is the one below the main diagonal.
        Other negative numbers represent lower subdiagonals.
        1 means the first superdiagonal, this is the one above the main diagonal.
        Other positive numbers represent higher superdiagonals.
    
        :note: Note that this method also works for non-square matrices, but the returned matrix will thus be
                not lower triangular because only square matrices are lower triangular.
    
        - parameter n:   The diagonal's index.
    
        - returns: A matrix where all elements above the diagonal with the given index are zero.
    
        :exception: An exception will be raised if the diagonal at the given index does not exist.
                    This means -n >= the number of rows or n >= the number of columns.
    */
    override public func lowerTriangle(n: Int = 0) -> Matrix<T> {
        
        if -n >= self.dimensions.rows || n >= self.dimensions.columns {
            
            NSException(name: "Index out the bounds.", reason: "The given index is out of bounds.", userInfo: nil).raise()
        }
        
        if n == 0 {
            return self
        } else {
            return Matrix(filledWith: 0, dimensions: self.dimensions)
        }
    }
    
    
    /**
        Returns the maximum element in the matrix if the matrix is not empty,
        otherwise it returns nil.
    */
    override public var maxElement: T? {
        
        if self.isEmpty {
            
            return nil
            
        } else {
            
            return max(max(self.elementsStructure), 0)
        }
    }
    
    
    /**
        Returns the minimum element in the matrix if the matrix is not empty,
        otherwise it returns nil.
    */
    override public var minElement: T? {
        
        if self.isEmpty {
            
            return nil
            
        } else {
            
            return min(min(self.elementsStructure), 0)
        }
    }
    
    
    /**
        Returns the transpose of the matrix.
    */
    override public var transpose: Matrix<T> {
        
        return DiagonalMatrix(diagonal: self.elementsStructure, dimensions: self.dimensions.transpose)
    }
    
    
    /**
        Returns the conjugate of the matrix.
    */
    override public var conjugate: Matrix<T> {
        
        return DiagonalMatrix(diagonal: self.elementsStructure.map{ $0.conjugate }, dimensions: self.dimensions)
    }
    
    
    /**
        Returns the conjugate transpose of the matrix. This is also called the Hermitian transpose.
    */
    override public var conjugateTranspose: Matrix<T> {
        
        return DiagonalMatrix(diagonal: self.elementsStructure.map{ $0.conjugate }, dimensions: self.dimensions.transpose)
    }
    
    
    /**
        Returns whether all elements are zero.
    */
    override public var isZero: Bool {
        
        for element in self.diagonalElements {
            
            if element != 0 { return false }
        }
        
        return true
    }
    
    
    /**
        Returns whether the matrix is diagonal. This means all elements that are not on the main diagonal are zero.
    */
    override public var isDiagonal: Bool {
        
        return true
    }
    
    
    /**
        Returns whether the matrix is symmetrical. This method works O(2n) for symmetrical (square) matrixes of size n.
    
        - returns: true if the matrix is symmetrical.
    */
    override public var isSymmetrical: Bool {
        
        return self.isSquare
    }
    
    
    /**
        Returns whether the matrix is upper triangular according to the given diagonal index.
        This means all elements below the diagonal at the given index n must be zero.
        When mustBeSquare is set to true the matrix must be square.
    
        - parameter n:               The diagonal's index.
        - parameter mustBeSquare:    Whether the matrix must be square to be upper triangular.
    */
    override public func isUpperTriangular(n: Int = 0, mustBeSquare: Bool = true) -> Bool {
        
        if -n >= self.dimensions.rows || n >= self.dimensions.columns {
            
            NSException(name: "Index out the bounds.", reason: "The given diagonal index is out of bounds.", userInfo: nil).raise()
        }
        
        return (!mustBeSquare || self.isSquare) && (n <= 0 || self.isZero)
    }
    
    
    /**
        Returns whether the matrix is upper Hessenberg.
        This means all elements below the first subdiagonal are zero.
    */
    override public var isUpperHessenberg: Bool {
        
        return self.isSquare
    }
    
    
    /**
        Returns whether the matrix is lower triangular according to the given diagonal index.
        This means all elements above the diagonal at the given index n must be zero.
        When mustBeSquare is set to true the matrix must be square.
    
        - parameter n: The diagonal's index.
        - parameter mustBeSquare: Whether the matrix must be square to be lower triangular.
    */
    override public func isLowerTriangular(n: Int = 0, mustBeSquare: Bool = true) -> Bool {
        
        if -n >= self.dimensions.rows || n >= self.dimensions.columns {
            
            NSException(name: "Index out the bounds.", reason: "The given diagonal index is out of bounds.", userInfo: nil).raise()
        }
        
        return (!mustBeSquare || self.isSquare) && (n >= 0 || self.isZero)
    }
    
    
    /**
        Returns whether the matrix is a lower Hessenberg matrix.
        This means all elements above the first superdiagonal are zero.
    */
    override public var isLowerHessenberg: Bool {
        
        return isLowerTriangular(1)
    }
    
    
    
    // MARK: Element Methods
    
    /**
        Returns the element at the given index (row, column).
    
        - parameter row: The row index of the requested element
        - parameter column: The column index of the requested element
    
        - returns: The element at the given index (row, column).
    */
    override public func element(row: Int, _ column: Int) -> T {
        
        if row < 0 || row >= self.dimensions.rows {
            
            NSException(name: "Row index out of bounds", reason: "The requested element's row index is out of bounds.", userInfo: nil).raise()
        }
        
        if column < 0 || column >= self.dimensions.columns {
            
            NSException(name: "Column index out of bounds", reason: "The requested element's column index is out of bounds.", userInfo: nil).raise()
        }
        
        return row == column ? self.elementsStructure[row] : 0
    }
    
    
    /**
        Sets the element at the given indexes.
    
        - parameter row: The row index of the element
        - parameter column: The column index of the element
        - parameter element: The element to set at the given indexes
    */
    override public func setElement(atRow row: Int, atColumn column: Int, toElement element: T) {
        
        if row < 0 || row >= self.dimensions.rows {
            
            NSException(name: "Row index out of bounds", reason: "The row index at which the element should be set is out of bounds.", userInfo: nil).raise()
        }
        
        if column < 0 || column >= self.dimensions.columns {
            
            NSException(name: "Column index out of bounds", reason: "The column index at which the element should be set is out of bounds.", userInfo: nil).raise()
        }
        
        if row != column {
            
            NSException(name: "Unsettable element", reason: "Can't set a non-diagonal element.", userInfo: nil).raise()
        }
        
        self.elementsStructure[row] = element
    }
    
    
    /**
        Returns the row at the given index. The first row has index 0.
    
        - returns: The row at the given index.
    */
    override public func row(index: Int) -> Vector<T> {
        
        if index < 0 || index >= self.dimensions.rows {
            
            NSException(name: "Row index out of bounds", reason: "The requested row's index is out of bounds.", userInfo: nil).raise()
        }
        
        var elementsList = [T](count: self.dimensions.columns, repeatedValue: 0)
        elementsList[index] = self.elementsStructure[index]
        
        return Vector(elementsList)
    }
    
    
    /**
        Sets the row at the given index to the given row.
    
        - parameter index: The index of the row to change.
        - parameter newRow: The row to set at the given index.
    */
    override public func setRow(atIndex index: Int, toRow newRow: Vector<T>) {
        
        // If the index is out of bounds
        if index < 0 || index >= self.dimensions.rows {
            
            NSException(name: "Row index out of bounds", reason: "The index at which the row should be set is out of bounds.", userInfo: nil).raise()
        }
        
        // If the row's length is not correct
        if newRow.length != self.dimensions.columns {
            
            NSException(name: "New row wrong length", reason: "The new row's length is not equal to the matrix's number of columns.", userInfo: nil).raise()
        }
        
        for (i, element) in newRow.enumerate() {
            
            if i == index {
                
                self.elementsStructure[i] = element
                
            } else if element != 0 {
                
                NSException(name: "Unsettable element", reason: "All elements at non-diagonal positions must be zero.", userInfo: nil).raise()
            }
        }
    }
    
    
    /**
        Switches the rows at the given indexes.
    
        - parameter i: The index of the first row.
        - parameter j: The index of the second row.
    */
    override public func switchRows(i: Int, _ j: Int) {
        
        NSException(name: "Can't switch rows", reason: "Rows can't be switched in a DiagonalMatrix.", userInfo: nil).raise()
    }
    
    
    /**
        Returns the column at the given index. The first column has index 0.
    
        - returns: The column at the given index.
    */
    override public func column(index: Int) -> Vector<T> {
        
        if index < 0 || index >= self.dimensions.columns {
            
            NSException(name: "Column index out of bounds", reason: "The requested column's index is out of bounds.", userInfo: nil).raise()
        }
        
        var elementsList = [T](count: self.dimensions.rows, repeatedValue: 0)
        elementsList[index] = self.elementsStructure[index]
        
        return Vector(elementsList)
    }
    
    
    /**
        Sets the column at the given index to the given column.
    
        - parameter index: The index of the column to change.
        - parameter column: The column to set at the given index.
    */
    override public func setColumn(atIndex index: Int, toColumn newColumn: Vector<T>) {
        
        // If the index is out of bounds
        if index < 0 || index >= self.dimensions.columns {
            
            NSException(name: "Column index out of bounds", reason: "The index at which the column should be set is out of bounds.", userInfo: nil).raise()
        }
        
        // If the column's length is not correct
        if newColumn.length != self.dimensions.rows {
            
            NSException(name: "New column wrong length", reason: "The new column's length is not equal to the matrix's number of rows.", userInfo: nil).raise()
        }
        
        for (i, element) in newColumn.enumerate() {
            
            if i == index {
                
                self.elementsStructure[i] = element
                
            } else if element != 0 {
                
                NSException(name: "Unsettable element", reason: "All elements at non-diagonal positions must be zero.", userInfo: nil).raise()
            }
        }
    }
    
    
    /**
        Switches the columns at the given indexes.
    
        - parameter i:   The index of the first column.
        - parameter j:   The index of the second column.
    */
    override public func switchColumns(i: Int, _ j: Int) {
        
        NSException(name: "Can't switch columns", reason: "Columns can't be switched in a DiagonalMatrix.", userInfo: nil).raise()
    }
    
    
    /**
        Fills the diagonal with the given value.
    
        - parameter value:   The value to fill the diagonal with.
    */
    override public func fillDiagonal(value: T) {
        
        self.elementsStructure = [T](count: self.dimensions.minimum, repeatedValue: value)
    }
}


// MARK: DiagonalMatrix Equality

/**
    Returns whether the two given matrices are equal. This means corresponding
    elements are equal.

    - parameter left:    The left matrix in the equation.
    - parameter right:   The right matrix in the equation.

    - returns: true if the two matrices are equal.
*/
public func == <T: MatrixCompatible> (left: DiagonalMatrix<T>, right: DiagonalMatrix<T>) -> Bool {
    
    if left.dimensions != right.dimensions {
        return false
    }
    
    return left.elementsStructure == right.elementsStructure
}


// MARK: Matrix Addition

/**
    Returns the sum of the two matrices.

    - parameter left:    The left matrix in the sum.
    - parameter right:   The right matrix in the sum.

    - returns: A matrix of the same dimensions as the two
                given matrices.

    :exception: Throws an exception when the dimensions of the two matrices are not equal.
*/
public func + <T: MatrixCompatible> (left: DiagonalMatrix<T>, right: DiagonalMatrix<T>) -> DiagonalMatrix<T> {
    
    if left.dimensions != right.dimensions {
        NSException(name: "Unequal dimensions", reason: "The dimensions of the two matrices are not equal.", userInfo: nil).raise()
    }
    
    return DiagonalMatrix(diagonal: (Vector(left.elementsStructure) + Vector(right.elementsStructure)).elements, dimensions: left.dimensions)
}

/**
    Returns the sum of the two matrices.

    - parameter left:    The left matrix in the sum.
    - parameter right:   The right matrix in the sum.

    - returns: A matrix of the same dimensions as the two
                given matrices.

    :exception: Throws an exception when the dimensions of the two matrices are not equal.
*/
public func + (left: DiagonalMatrix<Float>, right: DiagonalMatrix<Float>) -> DiagonalMatrix<Float> {
    
    if left.dimensions != right.dimensions {
        NSException(name: "Unequal dimensions", reason: "The dimensions of the two matrices are not equal.", userInfo: nil).raise()
    }
    
    var diagonal = right.elementsStructure
    
    cblas_saxpy(Int32(left.dimensions.minimum), 1.0, left.elementsStructure, 1, &diagonal, 1)
    
    return DiagonalMatrix(diagonal: diagonal, dimensions: left.dimensions)
}

/**
    Returns the sum of the two matrices.

    - parameter left:    The left matrix in the sum.
    - parameter right:   The right matrix in the sum.

    - returns: A matrix of the same dimensions as the two
                given matrices.

    :exception: Throws an exception when the dimensions of the two matrices are not equal.
*/
public func + (left: DiagonalMatrix<Double>, right: DiagonalMatrix<Double>) -> DiagonalMatrix<Double> {
    
    if left.dimensions != right.dimensions {
        NSException(name: "Unequal dimensions", reason: "The dimensions of the two matrices are not equal.", userInfo: nil).raise()
    }
    
    var diagonal = right.elementsStructure
    
    cblas_daxpy(Int32(left.dimensions.minimum), 1.0, left.elementsStructure, 1, &diagonal, 1)
    
    return DiagonalMatrix(diagonal: diagonal, dimensions: left.dimensions)
}