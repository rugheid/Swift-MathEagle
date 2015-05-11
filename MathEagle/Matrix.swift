//
//  Matrix.swift
//  SwiftMath
//
//  Created by Rugen Heidbuchel on 22/12/14.
//  Copyright (c) 2014 Jorestha Solutions. All rights reserved.
//

import Foundation
import Accelerate

protocol MatrixCompatible: Equatable, Comparable, Addable, Negatable, Substractable, Multiplicable, Dividable, Powerable, Conjugatable, Randomizable, IntegerLiteralConvertible {}

/**
    A generic class representing a 2-dimensional matrix of the given type.
*/
class Matrix <T: MatrixCompatible> : ArrayLiteralConvertible, Equatable, Printable, SequenceType {
    
    
    // MARK: Internal Elements
    
    /**
        Returns a row major ordered list of all elements in the array.
        This should be used for high performance applications.
    */
    var elementsList: [T] = []
    
    /**
        Returns the dimensions of matrix.
    */
    var dimensions: Dimensions = Dimensions(0, 0)
    
    /**
        Returns or sets a 2 dimensional array containing the elements of the matrix.
        The array contains array's that represent rows.
    
        :performance: This method scales O(n*m) for an nxm matrix, so elementsList should be used for
                        high performance applications.
    */
    var elements: [[T]] {
        
        get {
            var elements = [[T]]()
            
            for r in 0 ..< self.dimensions.rows {
                
                var rowElements = [T]()
                
                for c in 0 ..< self.dimensions.columns {
                    rowElements.append(elementsList[r * self.dimensions.columns + c])
                }
                
                elements.append(rowElements)
            }
            
            if elements.count == 0 {
                elements.append([])
            }
            
            return elements
        }
        
        set(newElements) {
            
            elementsList = []
            
            for row in newElements {
                elementsList.extend(row)
            }
            
            if newElements.count == 0 || newElements[0].count == 0 {
                self.dimensions = Dimensions()
            } else {
                self.dimensions = Dimensions(newElements.count, newElements[0].count)
            }
        }
    }
    
    
    
    // MARK: Initialisation
    
    /**
        Creates an empty matrix with elements [[]]. The dimensions
        will be (0, 0).
    */
    init() {}
    
    
    /**
        Creates a matrix with the given elements.
    
        :param: elements The elements of the matrix. Every element
                    in this array should be an array representing
                    a row in the matrix.
    */
    init(_ elements: [[T]]) {
    
        self.elements = elements
    }
    
    
    /**
        Creates a matrix with the given array literal.
    
        :param: elements The elements of the matrix. Every element
                    in this array should be an array representing
                    a row in the matrix.
    */
    required init(arrayLiteral elements: [T]...) {
        
        self.elements = elements
    }
    
    
    /**
        Creates a matrix with the given elementsList and the
        given number of rows.
    
        :param: elementsList A flat row majored list of all elements in
                    the matrix.
        :param: rows The number of rows the matrix should have.
    
        :exception: An exception will be thrown when the number
                        of elements in the elementsList is not
                        a multiple of rows.
    */
    init(elementsList: [T], rows: Int) {
        
        if elementsList.count % rows != 0 {
            NSException(name: "Wrong number of elements", reason: "The number of elements in the given list is not a multiple of rows.", userInfo: nil).raise()
        }
        
        self.dimensions = Dimensions(rows, rows == 0 ? 0 : elementsList.count / rows)
        self.elementsList = elementsList
    }
    
    
    /**
        Creates a matrix with the given elementsList and the
        given number of columns.
    
        :param: elementsList A flat row majored list of all elements in
                    the matrix.
        :param: columns The number of columns the matrix should have.
    
        :exception: An exception will be thrown when the number
                        of elements in the elementsList is not
                        a multiple of columns.
    */
    init(elementsList: [T], columns: Int) {
        
        if elementsList.count % columns != 0 {
            NSException(name: "Wrong number of elements", reason: "The number of elements in the given list is not a multiple of columns.", userInfo: nil).raise()
        }
        
        self.dimensions = Dimensions(columns == 0 ? 0 : elementsList.count / columns, columns)
        self.elementsList = elementsList
    }
    
    
    /**
        Creates a matrix with the given elementsList and the
        given dimensions.
    
        :param: elementsList A flat row majored list of all elements in
                    the matrix.
        :param: dimensions The dimensions the matrix should have.
    
        :exception: An exception will be thrown when the number
                        of elements in the elementsList is not
                        equal to the product of the dimensions.
    */
    init(elementsList: [T], dimensions: Dimensions) {
        
        if elementsList.count != dimensions.product {
            NSException(name: "Wrong number of elements", reason: "The number of elements in the given list is not equal to the product of the dimensions.", userInfo: nil).raise()
        }
        
        self.dimensions = dimensions
        self.elementsList = elementsList
    }
    
    
    /**
        Creates a matrix with the given dimensions using
        the given generator.
    
        :param: dimensions The dimensions the matrix should have.
        :param: generator The generator used to generate the matrix.
                    This function is called for every element passing
                    the index of the element.
    */
    init(dimensions: Dimensions, generator: (Index) -> T) {
        
        self.elementsList = []
        self.dimensions = dimensions
        
        for row in 0 ..< dimensions.rows {
            for col in 0 ..< dimensions.columns {
                self.elementsList.append(generator([row, col]))
            }
        }
    }
    
    
    convenience init(size: Int, generator: (Index) -> T) {
        
        self.init(dimensions: Dimensions(size, size), generator: generator)
    }
    
    
    convenience init(randomWithDimensions dimensions: Dimensions) {
        
        self.init(dimensions: dimensions, generator: { i in T.random() })
    }
    
    
    convenience init(randomWithSize size: Int) {
        
        self.init(randomWithDimensions: Dimensions(size, size))
    }
    
    
    convenience init(randomWithDimensions dimensions: Dimensions, intervals: ClosedInterval<T.RandomIntervalType>...) {
        
        self.init(dimensions: dimensions, generator: { i in T.randomInInterval(intervals) })
    }
    
    
    convenience init(randomWithSize size: Int, intervals: ClosedInterval<T.RandomIntervalType>...) {
        
        self.init(size: size, generator: { i in T.randomInInterval(intervals) })
    }
    
    
    init(symmetrical elements: [T]) {
        
        self.elementsList = [T]()
        
        let size = (elements.count + 1) / 2
        self.dimensions = Dimensions(size, size)
        
        for row in 0 ..< size {
            for column in 0 ..< size {
                elementsList.append(elements[row + column])
            }
        }
    }
    
    
    convenience init(filledWith element: T, size: Int) {
        
        self.init(filledWith: element, dimensions: Dimensions(size: size))
    }
    
    
    init(filledWith element: T, dimensions: Dimensions) {
        
        self.dimensions = dimensions
        self.elementsList = [T](count: dimensions.rows * dimensions.columns, repeatedValue: element)
    }
    
    
    convenience init(identityOfSize size: Int) {
        
        self.init(filledWith: 0, size: size)
        self.fillDiagonal(1)
    }
    
    
    convenience init(diagonal: [T]) {
        
        self.init(filledWith: 0, size: diagonal.count)
        self.diagonalElements = diagonal
    }
    
    
    
    // MARK: Subscript Methods
    
    subscript(row: Int, column: Int) -> T {
    
        get {
            
            return self.element(row, column)
        }
        
        set(newElement) {
            
            self.setElement(atRow: row, atColumn: column, toElement: newElement)
        }
    }
    
    subscript(index: Int) -> Vector<T>  {
        
        get {
            
            return self.row(index)
        }
        
        set(newRow) {
            
            self.setRow(atIndex: index, toRow: newRow)
        }
    }
    
    
    subscript(indexRange: Range<Int>) -> Matrix<T> {
        
        get {
            
            var matrixElements = [[T]]()
            
            for i in indexRange {
                
                matrixElements.append(self[i].elements)
            }
            
            return Matrix(matrixElements)
        }
        
        set(newMatrix) {
            
            if !indexRange.isEmpty {
                
                if newMatrix.isEmpty {
                    
                    self.elements.removeRange(indexRange)
                    
                } else {
                    
                    self.elements.replaceRange(indexRange, with: newMatrix.elements)
                }
            }
        }
    }
    
    
    subscript(rowRange: Range<Int>, columnRange: Range<Int>) -> Matrix<T> {
        
        get {
            
            return self.submatrix(rowRange, columnRange)
        }
        
        set(newMatrix) {
            
            self.setSubmatrix(rowRange, columnRange, toMatrix: newMatrix)
        }
    }
    
    
    subscript(rowRange: Range<Int>, column: Int) -> Vector<T> {
        
        get {
            
            return self.subvector(rowRange, column)
        }
        
        set(newVector) {
            
            self.setSubvector(rowRange, column, toVector: newVector)
        }
    }
    
    
    subscript(row: Int, columnRange: Range<Int>) -> Vector<T> {
        
        get {
            
            return self.subvector(row, columnRange)
        }
        
        set(newVector) {
            
            self.setSubvector(row, columnRange, toVector: newVector)
        }
    }
    
    
    // MARK: Sequence Type
    
    func generate() -> MatrixGenerator<T> {
        
        return MatrixGenerator(matrix: self)
    }
    
    
    // MARK: Class Behaviour
    
    /**
        Returns a copy of the matrix.
    */
    var copy: Matrix<T> {
        
        return Matrix(elementsList: self.elementsList, dimensions: self.dimensions)
    }
    

    // MARK: Basic Properties
    
    /**
        Returns a textual representation of the matrix. This conforms to the array literal.
    
        :example: [[1, 2], [3, 4], [5, 6]]
    */
    var description: String {
        
        return self.elements.description
    }
    
    
    /**
        Returns the size of the matrix if the matrix is square. If the matrix is not square, an exception will be raised.
    
        :returns: The size of the matrix if the matrix is square.
    */
    var size: Int? {
        return self.dimensions.size
    }
    
    
    /**
        Gives the rank of the matrix. This is not the tensor rank.
    
        :returns: The rank of the matrix.
    */
    var rank: Int {
        
        //TODO: Implement this method
        return 0
    }
    
    
    /**
        Returns the trace of the matrix. This is the sum of the diagonal elements.
    
        :returns: The trace of the matrix.
    
        :exceptions: Exceptions will be thrown if the matrix is empty or if the matrix is not square.
    */
    var trace: T {
        
        if self.isEmpty {
            
            NSException(name: "Empty matrix", reason: "An empty matrix does not have a trace.", userInfo: nil).raise()
        }
        
        if !self.isSquare {
            
            NSException(name: "Non square matrix", reason: "A non square matrix does not have a trace.", userInfo: nil).raise()
        }
        
        return sum(self.diagonalElements)
    }
    
    
    /**
        Returns the determinant of the matrix. Note that this method does not check for easy structures like diagonal
        matrices, zero matrices, ... because this would consume unnecessary time. Use product(matrix.diagonalElements)
        if the matrix is diagonal for example.
    */
    var determinant: T {
        
        let (_, _, _, det) = LUDecomposition(pivoting: true, optimalPivoting: true)
        return det
    }
    
    
    /**
    Returns an array with the diagonal elements of the matrix.
    
    :returns: An array with the diagonal elements of the matrix.
    */
    var diagonalElements: [T] {
        
        get {
            
            var returnElements = [T]()
            
            for i in 0 ..< self.dimensions.minimum {
                
                returnElements.append(self.element(i, i))
            }
            
            return returnElements
        }
        
        set(elements) {
            
            let nrOfDiagonals = self.dimensions.minimum
            
            if elements.count != nrOfDiagonals {
                
                NSException(name: "Diagonal elements out of bounds", reason: "\(elements.count) are too many diagonal elements, only \(nrOfDiagonals) needed.", userInfo: nil).raise()
            }
            
            for i in 0 ..< nrOfDiagonals {
                
                self.setElement(atRow: i, atColumn: i, toElement: elements[i])
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
    
        :param: n The diagonal's index.
    
        :returns: An array representing the diagonal elements from top left to bottom right in the matrix.
    
        :exception: An exception will be raised if the diagonal at the given index does not exist.
                    This means -n > the number of rows or n > the number of columns.
    */
    func diagonalElements(_ n: Int = 0) -> [T] {
        
        if -n > self.dimensions.rows || n > self.dimensions.columns {
            
            NSException(name: "Index out the bounds.", reason: "The given index is out of bounds.", userInfo: nil).raise()
        }
        
        var returnElements = [T]()
        
        var row = max(-n, 0)
        var col = max(n, 0)
        
        while row < self.dimensions.rows && col < self.dimensions.columns {
            
            returnElements.append(self.element(row, col))
            row++
            col++
        }
        
        return returnElements
    }
    
    
    /**
        Returns a copy of the matrix with all elements under the main diagonal set to zero.
        This also applies to non-square matrices.
    */
    var upperTriangle: Matrix<T> {
        
        return upperTriangle()
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
    
        :param: n The diagonal's index.
    
        :returns: A matrix where all elements under the diagonal with the given index are zero.
    
        :exception: An exception will be raised if the diagonal at the given index does not exist.
                    This means -n > the number of rows or n > the number of columns.
    */
    func upperTriangle(_ n: Int = 0) -> Matrix<T> {
        
        if -n > self.dimensions.rows || n > self.dimensions.columns {
            
            NSException(name: "Index out the bounds.", reason: "The given index is out of bounds.", userInfo: nil).raise()
        }
        
        var row = max(-n, 0)
        var col = max(n, 0)
        
        if n > 0 {
            
            var elementsList = [T](count: self.dimensions.product, repeatedValue: 0)
            
            while row < self.dimensions.rows && col < self.dimensions.columns {
                
                for c in col ..< self.dimensions.columns {
                    
                    elementsList[row * self.dimensions.columns + c] = self.element(row, c)
                }
                
                row++
                col++
            }
            
            return Matrix(elementsList: elementsList, dimensions: self.dimensions)
            
        } else {
            
            var elementsList = Array(self.elementsList)
            
            while row + 1 < self.dimensions.rows && col < self.dimensions.columns {
                
                for r in row + 1 ..< self.dimensions.rows {
                    
                    elementsList[r * self.dimensions.columns + col] = 0
                }
                
                row++
                col++
            }
            
            return Matrix(elementsList: elementsList, dimensions: self.dimensions)
        }
    }
    
    
    var lowerTriangle: Matrix<T> {
        
        get {
            return lowerTriangle()
        }
    }
    
    
    func lowerTriangle(_ n: Int = 0) -> Matrix<T> {
        
        if -n > self.dimensions.rows || n > self.dimensions.columns {
            
            NSException(name: "Index out the bounds.", reason: "The given index is out of bounds.", userInfo: nil).raise()
        }
        
        var row = max(-n, 0)
        var col = max(n, 0)
        
        if n >= 0 {
            
            var elementsList = Array(self.elementsList)
            
            while row < self.dimensions.rows && col + 1 < self.dimensions.columns {
                
                for c in col + 1 ..< self.dimensions.columns {
                    
                    elementsList[row * self.dimensions.columns + c] = 0
                }
                
                row++
                col++
            }
            
            return Matrix(elementsList: elementsList, dimensions: dimensions)
            
        } else {
            
            var elementsList = [T](count: self.dimensions.product, repeatedValue: 0)
            
            while row < self.dimensions.rows && col < self.dimensions.columns {
                
                for r in row ..< self.dimensions.rows {
                    
                    elementsList[r * self.dimensions.columns + col] = self.element(r, col)
                }
                
                row++
                col++
            }
            
            return Matrix(elementsList: elementsList, dimensions: self.dimensions)
        }
    }
    
    
    /**
        Returns the maximum element in the matrix if the matrix is not empty,
        otherwise it returns nil.
    */
    var maxElement: T? {
        
        if self.isEmpty {
            
            return nil
            
        } else {
            
            var max = self.elementsList[0]
            for element in self.elementsList {
                if element > max {
                    max = element
                }
            }
            return max
        }
    }
    
    
    /**
        Returns the minimum element in the matrix if the matrix is not empty,
        otherwise it returns nil.
    */
    var minElement: T? {
        
        if self.isEmpty {
            
            return nil
            
        } else {
            
            var min = self.elementsList[0]
            for element in self.elementsList {
                if element < min {
                    min = element
                }
            }
            return min
        }
    }
    
    
    /**
        Returns the transpose of the matrix.
    */
    var transpose: Matrix<T> {
        
        var elementsList = [T]()
        
        for col in 0 ..< self.dimensions.columns {
            for row in 0 ..< self.dimensions.rows {
                
                elementsList.append(self.element(row, col))
            }
        }
        
        return Matrix(elementsList: elementsList, rows: self.dimensions.columns)
    }
    
    
    /**
        Returns the conjugate of the matrix.
    */
    var conjugate: Matrix<T> {
        
        return mmap(self){ $0.conjugate }
    }
    
    
    /**
        Returns the conjugate transpose of the matrix. This is also called the Hermitian transpose.
    */
    var conjugateTranspose: Matrix<T> {
        
        return self.transpose.conjugate
    }
    
    
    /**
        Returns whether the matrix is empty. This means the dimensions are (0, 0).
    
        :returns: true if the matrix is empty.
    */
    var isEmpty: Bool {
        
        return self.dimensions.isEmpty
    }
    
    
    /**
        Returns whether all elements are zero.
    */
    var isZero: Bool {
        
        return mreduce(self, true){ $0 ? $1 == 0 : false }
    }
    
    
    /**
        Returns whether the matrix is square.
    
        :returns: true if the matrix is square.
    */
    var isSquare: Bool {
        
        return self.dimensions.isSquare
    }
    
    
    /**
        Returns whether the matrix is diagonal. This means all elements that are not on the main diagonal are zero.
    */
    var isDiagonal: Bool {
        
        for (index, element) in enumerate(self) {
            
            if index / self.dimensions.rows != index % self.dimensions.rows && element != 0 {
                
                return false
            }
        }
        
        return true
    }
    
    
    /**
        Returns whether the matrix is symmetrical. This method works O(2n) for symmetrical (square) matrixes of size n.
    
        :returns: true if the matrix is symmetrical.
    */
    var isSymmetrical: Bool {
        
        // If it's not square, it's impossible to be symmetrical
        if !self.isSquare { return false }
        
        let size = self.dimensions[0]
        
        // If the size is not bigger than 1, it's always symmetrical
        if size <= 1 { return true }
        
        let nrOfSecondDiagonals = 2 * self.dimensions.rows - 1
        
        for i in 1 ..< nrOfSecondDiagonals - 1 {
            
            var k = i/2 + 1
            let d = min(i, size-1)
            while k <= d {
                
                let j = i - k
                if self.element(k, j) != self.element(j, k) { return false }
                k++
            }
        }
        
        return true
    }
    
    
    /**
        Returns whether the matrix is upper triangular.
        This means the matrix is square and all elements below the main diagonal are zero.
    */
    var isUpperTriangular: Bool {
        
        return isUpperTriangular()
    }
    
    
    /**
        Returns whether the matrix is upper triangular according to the given diagonal index.
        This means all elements below the diagonal at the given index n must be zero.
        When mustBeSquare is set to true the matrix must be square.
    
        :param: n The diagonal's index.
        :param: mustBeSquare Whether the matrix must be square to be upper triangular.
    */
    func isUpperTriangular(_ n: Int = 0, mustBeSquare: Bool = true) -> Bool {
        
        // A non-square matrix can't be upper triangular
        if mustBeSquare && !self.isSquare { return false }
        
        if self.dimensions.rows <= 1 { return true }
        
        var row = max(-n, 0)
        var col = max(n, 0)
        
        for c in 0 ..< col {
            
            for r in 0 ..< self.dimensions.rows {
                
                if self.element(r, c) != 0 { return false }
            }
        }
        
        while row + 1 < self.dimensions.rows && col + 1 < self.dimensions.columns {
            
            for r in row + 1 ..< self.dimensions.rows {
                
                if self.element(r, col) != 0 { return false }
            }
            
            row++
            col++
        }
        
        return true
    }
    
    
    /**
        Returns whether the matrix is upper Hessenberg.
        This means all elements below the first subdiagonal are zero.
    */
    var isUpperHessenberg: Bool {
        
        return isUpperTriangular(-1)
    }
    
    
    /**
    Returns whether the matrix is lower triangular.
    This means the matrix is square and all elements above the main diagonal are zero.
    */
    var isLowerTriangular: Bool {
        
        return isLowerTriangular()
    }
    
    
    /**
    Returns whether the matrix is lower triangular according to the given diagonal index.
    This means all elements above the diagonal at the given index n must be zero.
    When mustBeSquare is set to true the matrix must be square.
    
    :param: n The diagonal's index.
    :param: mustBeSquare Whether the matrix must be square to be lower triangular.
    */
    func isLowerTriangular(_ n: Int = 0, mustBeSquare: Bool = true) -> Bool {
        
        // A non-square matrix can't be upper triangular
        if mustBeSquare && !self.isSquare { return false }
        
        if self.dimensions.rows <= 1 { return true }
        
        var row = max(-n, 0)
        var col = max(n, 0)
        
        for r in 0 ..< row {
            
            for c in 0 ..< self.dimensions.columns {
                
                if self.element(r, c) != 0 { return false }
            }
        }
        
        while row + 1 < self.dimensions.rows && col + 1 < self.dimensions.columns {
            
            for c in col + 1 ..< self.dimensions.columns {
                
                if self.element(row, c) != 0 { return false }
            }
            
            row++
            col++
        }
        
        return true
    }
    
    
    /**
        Returns whether the matrix is a lower Hessenberg matrix.
        This means all elements above the first superdiagonal are zero.
    */
    var isLowerHessenberg: Bool {
        
        return isLowerTriangular(1)
    }
    
    
    /**
        Returns whether the matrix is Hermitian.
        This means the matrix is equal to it's own conjugate transpose.
    */
    var isHermitian: Bool {
        
        return self == self.conjugateTranspose
    }
    
    
    
    // MARK: Element Methods
    
    /**
        Returns the element at the given index (row, column).
    
        :param: row The row index of the requested element
        :param: column The column index of the requested element
    
        :returns: The element at the given index (row, column).
    */
    func element(row: Int, _ column: Int) -> T {
        
        if row < 0 || row >= self.dimensions.rows {
            
            NSException(name: "Row index out of bounds", reason: "The requested element's row index is out of bounds.", userInfo: nil).raise()
        }
        
        if column < 0 || column >= self.dimensions.columns {
            
            NSException(name: "Column index out of bounds", reason: "The requested element's column index is out of bounds.", userInfo: nil).raise()
        }
        
        return self.elementsList[row * self.dimensions.columns + column]
    }
    
    
    /**
        Sets the element at the given indexes.
    
        :param: row The row index of the element
        :param: column The column index of the element
        :param: element The element to set at the given indexes
    */
    func setElement(atRow row: Int, atColumn column: Int, toElement element: T) {
        
        if row < 0 || row >= self.dimensions.rows {
            
            NSException(name: "Row index out of bounds", reason: "The row index at which the element should be set is out of bounds.", userInfo: nil)
        }
        
        if column < 0 || column >= self.dimensions.columns {
            
            NSException(name: "Column index out of bounds", reason: "The column index at which the element should be set is out of bounds.", userInfo: nil)
        }
        
        self.elementsList[row * self.dimensions.columns + column] = element
    }
    
    
    /**
        Sets the element at the given index.
    
        :param: index A tuple containing the indexes of the element (row, column)
        :param: element The element to set at the given index
    */
    func setElement(atIndex index: (Int, Int), toElement element: T) {
        
        let (row, column) = index
        
        self.setElement(atRow: row, atColumn: column, toElement: element)
    }
    
    
    /**
        Returns the row at the given index. The first row has index 0.
    
        :returns: The row at the given index.
    */
    func row(index: Int) -> Vector<T> {
        
        if index < 0 || index >= self.dimensions.rows {
            
            NSException(name: "Row index out of bounds", reason: "The requested row's index is out of bounds.", userInfo: nil).raise()
        }
        
        var elementsList = [T]()
        
        for i in index * self.dimensions.columns ..< (index + 1) * self.dimensions.columns {
            elementsList.append(self.elementsList[i])
        }
        
        return Vector(elementsList)
    }
    
    
    /**
        Sets the row at the given index to the given row.
    
        :param: index The index of the row to change.
        :param: newRow The row to set at the given index.
    */
    func setRow(atIndex index: Int, toRow newRow: Vector<T>) {
        
        // If the index is out of bounds
        if index < 0 || index >= self.dimensions.rows {
            
            NSException(name: "Row index out of bounds", reason: "The index at which the row should be set is out of bounds.", userInfo: nil).raise()
        }
        
        // If the row's length is not correct
        if newRow.length != self.dimensions.columns {
            
            NSException(name: "New row wrong length", reason: "The new row's length is not equal to the matrix's number of columns.", userInfo: nil).raise()
        }
        
        self.elementsList.replaceRange(index * self.dimensions.columns ..< (index + 1) * self.dimensions.columns, with: newRow.elements)
    }
    
    
    /**
        Switches the rows at the given indexes.
    
        :param: i The index of the first row.
        :param: j The index of the second row.
    */
    func switchRows(i: Int, _ j: Int) {
        
        if i < 0 || i >= self.dimensions.rows || j < 0 || j >= self.dimensions.rows {
            
            NSException(name: "Row index out of bounds", reason: "The index of the row that should be switched is out of bounds.", userInfo: nil).raise()
        }
        
        let intermediate = self[i]
        
        self[i] = self[j]
        self[j] = intermediate
    }
    
    
    /**
        Returns the column at the given index. The first column has index 0.
    
        :returns: The column at the given index.
    */
    func column(index: Int) -> Vector<T> {
        
        if index < 0 || index >= self.dimensions.columns {
            
            NSException(name: "Column index out of bounds", reason: "The requested column's index is out of bounds.", userInfo: nil).raise()
        }
            
        var column = [T]()
        
        for i in 0 ..< self.dimensions.rows {
            
            column.append(self.elementsList[i * self.dimensions.columns + index])
        }
        
        return Vector(column)
    }
    
    
    /**
        Sets the column at the given index to the given column.
    
        :param: index The index of the column to change.
        :param: column The column to set at the given index.
    */
    func setColumn(atIndex index: Int, toColumn newColumn: Vector<T>) {
        
        // If the index is out of bounds
        if index < 0 || index >= self.dimensions.columns {
            
            NSException(name: "Column index out of bounds", reason: "The index at which the column should be set is out of bounds.", userInfo: nil).raise()
        }
        
        // If the column's length is not correct
        if newColumn.length != self.dimensions.rows {
            
            NSException(name: "New column wrong length", reason: "The new column's length is not equal to the matrix's number of rows.", userInfo: nil).raise()
        }
        
        for i in 0 ..< self.dimensions.rows {
            
            self.elementsList[i * self.dimensions.columns + index] = newColumn[i]
        }
    }
    
    
    /**
        Switches the columns at the given indexes.
    
        :param: i The index of the first column.
        :param: j The index of the second column.
    */
    func switchColumns(i: Int, _ j: Int) {
        
        var intermediate = self.column(i)
        
        self.setColumn(atIndex: i, toColumn: self.column(j))
        self.setColumn(atIndex: j, toColumn: intermediate)
    }
    
    
    /**
        Returns the submatrix for the given row and column ranges.
    
        :param: rowRange The range with rows included in the submatrix.
        :param: columnRange The range with columns included in the submatrix.
    
        :returns: The submatrix for the given row and column ranges.
    */
    func submatrix(rowRange: Range<Int>, _ columnRange: Range<Int>) -> Matrix<T> {
        
        if rowRange.startIndex < 0 || rowRange.endIndex > self.dimensions.rows {
            
            NSException(name: "Row index out of bound", reason: "The row index range is out of bounds. Range \(rowRange) given, but matrix row range is \(0..<self.dimensions.rows) .", userInfo: nil).raise()
        }
        
        if columnRange.startIndex < 0 || columnRange.endIndex > self.dimensions.columns {
            
            NSException(name: "Column index out of bound", reason: "The column index range is out of bounds. Range \(columnRange) given, but matrix column range is \(0..<self.dimensions.columns) .", userInfo: nil).raise()
        }
        
        var elementsList = [T]()
        
        for row in rowRange {
            for column in columnRange {
                
                elementsList.append(self.element(row, column))
            }
        }
        
        return Matrix(elementsList: elementsList, rows: rowRange.endIndex - rowRange.startIndex)
    }
    
    
    /**
        Replaces the current submatrix for the given row and column ranges with the given matrix.
    
        :param: rowRange The range with rows included in the submatrix.
        :param: columnRange The range with columns included in the submatrix.
        :param: matrix The matrix to replace the submatrix with.
    
        :exceptions: Expections will be thrown if the given ranges are out of bounds or if the given matrix's dimensions don't match the given ranges' lengths.
    */
    func setSubmatrix(rowRange: Range<Int>, _ columnRange: Range<Int>, toMatrix matrix: Matrix<T>) {
        
        if rowRange.startIndex < 0 || rowRange.endIndex > self.dimensions.rows {
            
            NSException(name: "Row index out of bound", reason: "The row index range is out of bounds. Range \(rowRange) given, but matrix row range is \(0..<self.dimensions.rows) .", userInfo: nil).raise()
        }
        
        if columnRange.startIndex < 0 || columnRange.endIndex > self.dimensions.columns {
            
            NSException(name: "Column index out of bound", reason: "The column index range is out of bounds. Range \(columnRange) given, but matrix column range is \(0..<self.dimensions.columns) .", userInfo: nil).raise()
        }
        
        if matrix.dimensions.rows != rowRange.endIndex - rowRange.startIndex || matrix.dimensions.columns != columnRange.endIndex - columnRange.startIndex {
            
            NSException(name: "Matrix dimensions don't match", reason: "The dimensions of the given matrix don't match the dimensions of the row and/or column ranges.", userInfo: nil).raise()
        }
        
        for row in rowRange {
            for column in columnRange {
                
                self.setElement(atRow: row, atColumn: column, toElement: matrix.element(row - rowRange.startIndex, column - columnRange.startIndex))
            }
        }
    }
    
    
    /**
        Returns the subvector for the given row range at the given column.
    
        :param: rowRange The range with rows included in the subvector.
        :param: column The column of the subvector.
    
        :exceptions: Exceptions will be thrown if the given row range and/or column are out of bounds.
    */
    func subvector(rowRange: Range<Int>, _ column: Int) -> Vector<T> {
        
        if rowRange.startIndex < 0 || rowRange.endIndex > self.dimensions.rows {
            
            NSException(name: "Row index out of bound", reason: "The row index range is out of bounds. Range \(rowRange) given, but matrix row range is \(0..<self.dimensions.rows) .", userInfo: nil).raise()
        }
        
        if column < 0 || column > self.dimensions.columns {
            
            NSException(name: "Column index out of bound", reason: "The column index is out of bounds. Index \(column) given, but matrix column range is \(0..<self.dimensions.columns) .", userInfo: nil).raise()
        }
        
        var vectorElements = [T]()
        
        for row in rowRange {
            
            vectorElements.append(self.element(row, column))
        }
        
        return Vector(vectorElements)
    }
    
    
    /**
        Replaces the current subvector for the given row range and column with the given vector.
    
        :param: rowRange The range with rows included in the subvector.
        :param: column The column of the subvector.
        :param: vector The vector to replace the subvector with.
    
        :exceptions: Exceptions will be thrown if the given row range and/or column are out of bounds or if the vector's length does not match the row range's length.
    */
    func setSubvector(rowRange: Range<Int>, _ column: Int, toVector vector: Vector<T>) {
        
        if rowRange.startIndex < 0 || rowRange.endIndex > self.dimensions.rows {
            
            NSException(name: "Row index out of bound", reason: "The row index range is out of bounds. Range \(rowRange) given, but matrix row range is \(0..<self.dimensions.rows) .", userInfo: nil).raise()
        }
        
        if column < 0 || column > self.dimensions.columns {
            
            NSException(name: "Column index out of bound", reason: "The column index is out of bounds. Index \(column) given, but matrix column range is \(0..<self.dimensions.columns) .", userInfo: nil).raise()
        }
        
        if vector.length != rowRange.endIndex - rowRange.startIndex {
            
            NSException(name: "Unequal length", reason: "The length of the given vector is not equal to the length in the given row range. Vector length = \(vector.length), row range = \(rowRange).", userInfo: nil).raise()
        }
        
        for row in rowRange {
            
            self.setElement(atRow: row, atColumn: column, toElement: vector[row - rowRange.startIndex])
        }
    }
    
    
    /**
    Returns the subvector for the given column range at the given row.
    
    :param: row The row of the subvector.
    :param: columnRange The range with columns included in the subvector.
    
    :exceptions: Exceptions will be thrown if the given row and/or column range are out of bounds.
    */
    func subvector(row: Int, _ columnRange: Range<Int>) -> Vector<T> {
        
        if row < 0 || row > self.dimensions.rows {
            
            NSException(name: "Row index out of bound", reason: "The row index is out of bounds. Index \(row) given, but matrix row range is \(0..<self.dimensions.rows) .", userInfo: nil).raise()
        }
        
        if columnRange.startIndex < 0 || columnRange.endIndex > self.dimensions.columns {
            
            NSException(name: "Column index out of bound", reason: "The column index range is out of bounds. Range \(columnRange) given, but matrix column range is \(0..<self.dimensions.columns) .", userInfo: nil).raise()
        }
        
        var vectorElements = [T]()
        
        for column in columnRange {
            
            vectorElements.append(self.element(row, column))
        }
        
        return Vector(vectorElements)
    }
    
    
    /**
    Replaces the current subvector for the given row and column range with the given vector.
    
    :param: row The row of the subvector.
    :param: columnRange The range with columns included in the subvector.
    :param: vector The vector to replace the subvector with.
    
    :exceptions: Exceptions will be thrown if the given row and/or column range are out of bounds or if the vector's length does not match the column range's length.
    */
    func setSubvector(row: Int, _ columnRange: Range<Int>, toVector vector: Vector<T>) {
        
        if row < 0 || row > self.dimensions.rows {
            
            NSException(name: "Row index out of bound", reason: "The row index is out of bounds. Index \(row) given, but matrix row range is \(0..<self.dimensions.rows) .", userInfo: nil).raise()
        }
        
        if columnRange.startIndex < 0 || columnRange.endIndex > self.dimensions.columns {
            
            NSException(name: "Column index out of bound", reason: "The column index range is out of bounds. Range \(columnRange) given, but matrix column range is \(0..<self.dimensions.columns) .", userInfo: nil).raise()
        }
        
        if vector.length != columnRange.endIndex - columnRange.startIndex {
            
            NSException(name: "Unequal length", reason: "The length of the given vector is not equal to the length in the given column range. Vector length = \(vector.length), column range = \(columnRange).", userInfo: nil).raise()
        }
        
        for column in columnRange {
            
            self.setElement(atRow: row, atColumn: column, toElement: vector[column - columnRange.startIndex])
        }
    }
    
    
    /**
        Fills the diagonal with the given value.
    
        :param: value The value to fill the diagonal with.
    */
    func fillDiagonal(value: T) {
        
        for i in 0 ..< self.dimensions.minimum {
            
            self.setElement(atRow: i, atColumn: i, toElement: value)
        }
    }
    
    
    
    // MARK: Factorisations
    
    /**
        Returns the LU decomposition of the matrix. This is only possible if the matrix is square.
    
        :returns: (L, U, P) with L being a lower triangular matrix with 1 on the diagonal, U an upper triangular matrix and P a permutation matrix. This way PA = LU.
    */
    var LUDecomposition: (Matrix<T>, Matrix<T>, Matrix<T>) {
        
        let (L, U, P, _) = self.LUDecomposition()
        return (L, U, P)
    }
    
    
    /**
        Returns the LU decomposition of the matrix. This is only possible if the matrix is square.
    
        :param: pivoting Determines whether the algorithm should use row pivoting. Note that if note pivoting is disabled, the algorithm might not find the LU decomposition.
        :param: optimalPivoting Determines whether the algorithm should use optimal row pivoting when pivoting is enabled. This means the biggest element in the current column is chosen to get more numerical stability.
        
        :returns: (L, U, P, det) with L being a lower triangular matrix with 1 on the diagonal, U an upper triangular matrix and P a permutation matrix. This way PA = LU. det gives the determinant of the matrix
    */
    func LUDecomposition(pivoting: Bool = true, optimalPivoting: Bool = true) -> (Matrix<T>, Matrix<T>, Matrix<T>, T) {
        
        //TODO: Try to bridge from Objective-C to Swift using LAPACK: getrf_ function
        
        if !self.isSquare {
            
            NSException(name: "Not square", reason: "A non-square matrix does not have a LU decomposition.", userInfo: nil).raise()
        }
        
        let n = self.size!
        
        var L = Matrix(identityOfSize: n)
        var U = self.copy
        var P = Matrix(identityOfSize: n)
        var detP: T = 1;
        
        for i in 0 ..< n {
            
            if pivoting {
                
                var p = i, max = U[i][i]
                
                for j in i ..< n {
                    
                    if U[i, j] > max { max = U[i, j]; p = j }
                }
                
                if p != i { detP = -detP }
                
                U.switchRows(p, i)
                P.switchRows(p, i)
            }
            
            L[i+1 ..< n, i] = U[i+1 ..< n, i]/U[i, i]
            U[i+1 ..< n, i+1 ..< n] = U[i+1 ..< n, i+1 ..< n] - L[i+1 ..< n, i].directProduct(U[i, i+1 ..< n])
            U[i+1 ..< n, i] = Vector(filledWith: 0, length: n-i-1)
        }
        
        let detU = product(U.diagonalElements)
        
        return (L, U, P, detP * detU)
    }
    
    
    
    // MARK: Private Helper Methods
    
    private func elementsAreValid(elements: [[T]]) -> Bool {
        
        if elements.count > 1 {
            
            let nrOfColumns = elements[0].count
            
            for i in 1 ..< elements.count {
                
                if elements[i].count != nrOfColumns {
                    
                    return false
                }
                
                return true
            }
        }
        
        return true
    }
    
}


// MARK: Matrix Equality

/**
    Returns whether the two given matrices are equal. This means corresponding
    elements are equal.

    :param: left    The left matrix in the equation.
    :param: right   The right matrix in the equation.

    :returns: true if the two matrices are equal.
*/
func == <T: MatrixCompatible> (left: Matrix<T>, right: Matrix<T>) -> Bool {
    
    if left.dimensions != right.dimensions {
        return false
    }
    
    for i in 0 ..< left.dimensions.product {
        
        if left.elementsList[i] != right.elementsList[i] {
            return false
        }
    }
    
    return true
}


// MARK: Matrix Addition

/**
    Returns the sum of the two matrices.

    :param: left    The left matrix in the sum.
    :param: right   The right matrix in the sum.

    :returns: A matrix of the same dimensions as the two
                given matrices.

    :exception: Throws an exception when the dimensions of the two matrices are not equal.
*/
func + <T: MatrixCompatible> (left: Matrix<T>, right: Matrix<T>) -> Matrix<T> {
    
    if left.dimensions != right.dimensions {
        NSException(name: "Unequal dimensions", reason: "The dimensions of the two matrices are not equal.", userInfo: nil).raise()
    }
    
    return mcombine(left, right){ $0 + $1 }
}

/**
    Returns the sum of the two matrices.

    :param: left    The left matrix in the sum.
    :param: right   The right matrix in the sum.

    :returns: A matrix of the same dimensions as the two
                given matrices.

    :exception: Throws an exception when the dimensions of the two matrices are not equal.
*/
func + (left: Matrix<Float>, right: Matrix<Float>) -> Matrix<Float> {
    
    if left.dimensions != right.dimensions {
        NSException(name: "Unequal dimensions", reason: "The dimensions of the two matrices are not equal.", userInfo: nil).raise()
    }
    
//    var elementsList = [Float](count: left.dimensions.product, repeatedValue: 0)
//    
//    vDSP_vadd(left.elementsList, 1, right.elementsList, 1, &elementsList, 1, vDSP_Length(left.dimensions.product))
//    
//    return Matrix(elementsList: elementsList, dimensions: left.dimensions)
    
    var elementsList = right.elementsList
    
    cblas_saxpy(Int32(left.dimensions.product), 1.0, left.elementsList, 1, &elementsList, 1)
    
    return Matrix(elementsList: elementsList, dimensions: left.dimensions)
    
//    var elementsList = right.elementsList
//    
//    catlas_saxpby(Int32(left.dimensions.product), 1.0, left.elementsList, 1, 1.0, &elementsList, 1)
//    
//    return Matrix(elementsList: elementsList, dimensions: left.dimensions)
}

/**
    Returns the sum of the two matrices.

    :param: left    The left matrix in the sum.
    :param: right   The right matrix in the sum.

    :returns: A matrix of the same dimensions as the two
    given matrices.

    :exception: Throws an exception when the dimensions of the two matrices are not equal.
*/
func + (left: Matrix<Double>, right: Matrix<Double>) -> Matrix<Double> {
    
    if left.dimensions != right.dimensions {
        NSException(name: "Unequal dimensions", reason: "The dimensions of the two matrices are not equal.", userInfo: nil).raise()
    }
    
    //    var elementsList = [Float](count: left.dimensions.product, repeatedValue: 0)
    //
    //    vDSP_vaddD(left.elementsList, 1, right.elementsList, 1, &elementsList, 1, vDSP_Length(left.dimensions.product))
    //
    //    return Matrix(elementsList: elementsList, dimensions: left.dimensions)
    
    var elementsList = right.elementsList
    
    cblas_daxpy(Int32(left.dimensions.product), 1.0, left.elementsList, 1, &elementsList, 1)
    
    return Matrix(elementsList: elementsList, dimensions: left.dimensions)
    
    //    var elementsList = right.elementsList
    //
    //    catlas_daxpby(Int32(left.dimensions.product), 1.0, left.elementsList, 1, 1.0, &elementsList, 1)
    //
    //    return Matrix(elementsList: elementsList, dimensions: left.dimensions)
}


// MARK: Matrix Negation

/**
    Returns the negation of the given matrix.

    :param: matrix  The matrix to negate.

    :returns: A matrix with the given dimensions as the given matrix
                where every element is the negation of the corresponding
                element in the given matrix.
*/
prefix func - <T: MatrixCompatible> (matrix: Matrix<T>) -> Matrix<T> {
    
    return mmap(matrix){ -$0 }
}


// MARK: Matrix Subtraction

/**
    Returns the subtraction of the two given matrices.

    :param: left    The left matrix in the subtraction.
    :param: right   The right matrix in the subtraction.

    :returns: A matrix with the same dimensions as the two given matrices
                where every element is the difference of the corresponding
                elements in the left and right matrices.

    :exception: Throws an exception when the dimensions of the two given
                    matrices are not equal.
*/
func - <T: MatrixCompatible> (left: Matrix<T>, right: Matrix<T>) -> Matrix<T> {
    
    if left.dimensions != right.dimensions {
        NSException(name: "Unequal dimensions", reason: "The dimensions of the two given matrices are not equal. Left dimensions: \(left.dimensions), right dimensions: \(right.dimensions).", userInfo: nil).raise()
    }
    
    return mcombine(left, right){ $0 - $1 }
}


// MARK: Matrix Scalar Multiplication

/**
    Returns the product of the given scalar and the given matrix.

    :param: scalar  The scalar with which to multiply the given matrix.
    :param: matrix  The matrix to multiply with the given scalar.

    :returns: A matrix of the same dimensions as the given matrix where
                every element is calculated as the product of the corresponding
                element in the given matrix and the given scalar.
*/
func * <T: MatrixCompatible> (scalar: T, matrix: Matrix<T>) -> Matrix<T> {
    
    return Matrix(map(matrix.elements){ map($0){ scalar * $0 } })
}

/**
    Returns the product of the given scalar and the given matrix.

    :param: scalar  The scalar with which to multiply the given matrix.
    :param: matrix  The matrix to multiply with the given scalar.

    :returns: A matrix of the same dimensions as the given matrix where
                every element is calculated as the product of the corresponding
                element in the given matrix and the given scalar.
*/
func * <T: MatrixCompatible> (matrix: Matrix<T>, scalar: T) -> Matrix<T> {
    
    return scalar * matrix
}


// MARK: Matrix Multiplication

/**
    Returns the product of the two given matrices.

    :param: left    The left matrix in the multiplication.
    :param: right   The right matrix in the multiplication.

    :returns: A matrix with the same number of rows as the left matrix
                and the same number of columns as the right matrix.

    :exception: Throws an exception when the number of columns of the left
                    matrix is not equal to the number of rows of the right matrix.
*/
func * <T: MatrixCompatible> (left: Matrix<T>, right: Matrix<T>) -> Matrix<T> {
    
    if left.dimensions.columns != right.dimensions.rows {
        NSException(name: "Wrong dimensions", reason: "The left matrix's number of columns is not equal to the right matrix's rows.", userInfo: nil).raise()
    }
    
    var matrixElements = [[T]]()
    
    for row in 0 ..< left.dimensions.rows {
        
        var rowElements = [T]()
        
        for column in 0 ..< right.dimensions.columns {
            
            var element:T = left[row, 0] * right[0][column]
            
            for i in 1 ..< left.dimensions.columns {
                
                element = element + left[row, i] * right[i, column]
            }
            
            rowElements.append(element)
        }
        
        matrixElements.append(rowElements)
    }
    
    return Matrix(matrixElements)
}


// MARK: Matrix Functional Methods

/**
    Returns a new matrix of the same dimensions where the elements are generated by calling the transform with the elements in this matrix.

    :param: matrix The matrix to map with the original elements.
    :param: transform The transform to map on the elements of matrix.
*/
func mmap <T: MatrixCompatible, U: MatrixCompatible> (matrix: Matrix<T>, transform: T -> U) -> Matrix<U> {
    
    let elementsList = map(matrix.elementsList, transform)
    
    return Matrix(elementsList: elementsList, dimensions: matrix.dimensions)
}

/**
    Returns a single value generated by systematically reducing the matrix using the combine closure. For the first element initial will be used. Then the last generated element will be used to combine with the next element in the matrix.
    The elements will be looped through row per row, column per column.

    :param: matrix The matrix to reduce.
    :param: initial The element to combine with the first element of the matrix.
    :param: combine The closure to combine two values to generate a new value.
*/
func mreduce <T: MatrixCompatible, U> (matrix: Matrix<T>, initial: U, combine: (U, T) -> U) -> U {
    
    return reduce(matrix.elementsList, initial, combine)
}

/**
    Returns a new matrix by combining the two given matrices using the combine closure. The two given matrices have to have the same dimensions, since the combination will happen element per element.

    :param: left The left matrix in the combination.
    :param: right The right matrix in the combination.
    :param: combine The closure to combine two elements from the two matrices.

    :exceptions: Throws an exception when the dimensions of the two given matrices are not equal.
*/
func mcombine <T: MatrixCompatible, U: MatrixCompatible, V: MatrixCompatible> (left: Matrix<T>, right: Matrix<U>, combine: (T, U) -> V) -> Matrix<V> {

    if left.dimensions != right.dimensions {
        
        NSException(name: "Unequal dimensions", reason: "The dimensions of the two matrices are not equal.", userInfo: nil).raise()
    }
    
    var elementsList = [V]()
    
    for i in 0 ..< left.dimensions.product {
        elementsList.append(combine(left.elementsList[i], right.elementsList[i]))
    }
    
    return Matrix(elementsList: elementsList, dimensions: left.dimensions)
}



// MARK: - Additional Structs

// MARK: - MatrixGenerator

/**
    A struct representing a generator for iterating over a matrix.
*/
struct MatrixGenerator <T: MatrixCompatible> : GeneratorType {
    
    /**
        The generator of the elements list of the matrix.
    */
    private var generator: IndexingGenerator<Array<T>>
    
    /**
        Creates a new matrix generator to iterator over the given matrix.
    
        :param: The matrix to iterate over.
    */
    init(matrix: Matrix<T>) {
        
        self.generator = matrix.elementsList.generate()
    }
    
    /**
        Returns the next element in the matrix or nil if there are no elements left.
    */
    mutating func next() -> T? {
        return self.generator.next()
    }
}


// MARK: - Index

struct Index: ArrayLiteralConvertible {
    
    let row, column: Int
    
    init(arrayLiteral elements: Int...) {
        
        if elements.count < 2 {
            
            NSException(name: "Not enough elements provided", reason: "Only \(elements.count) elements provided, but 2 elements needed for Index initialisation.", userInfo: nil).raise()
        }
        
        if elements.count > 2 {
            
            NSException(name: "Too many elements provided", reason: "\(elements.count) elements provided, but only 2 elements needed for Index initialisation.", userInfo: nil).raise()
        }
        
        self.row = elements[0]
        self.column = elements[1]
    }
}


// MARK: - Dimensions

/**
    A struct representing the dimensions of a 2-dimensional matrix.
*/
struct Dimensions: Equatable, Addable {
    
    /**
        The number of rows in the dimensions.
    */
    let rows: Int
    
    /**
        The number of columns in the dimensions.
    */
    let columns: Int
    
    /**
        Creates a new dimensions object with the given number of rows and columns.
    
        :param: rows    The number of rows in the dimensions.
        :param: columns The number of columns in the dimensions.
    */
    init(_ rows: Int = 0, _ columns: Int = 0) {
        
        self.rows = rows
        self.columns = columns
    }
    
    /**
        Creates a new dimensions object where the number of rows and columns are equal.
    
        :param: size    The size of the dimensions. This value will be used for both the
                            number of rows and columns.
    */
    init(size: Int) {
        
        self.init(size, size)
    }
    
    /**
        Returns the minimal value of both dimension values (rows, columns).
    */
    var minimum: Int {
        
        return self.rows < self.columns ? self.rows : self.columns
    }
    
    /**
        Returns the size of these dimensions. Returns nil if the rows and columns
        dimensions values are not equal.
    */
    var size: Int? {
        return self.rows == self.columns ? self.rows : nil
    }
    
    /**
        Returns the product of the two dimension values: rows * columns.
    */
    var product: Int {
        return self.rows * self.columns
    }
    
    /**
        Returns whether the dimensions are sqaure or not. Dimensions are sqaure when the number of
        rows equals the number of columns.
    
        :returns: true if the dimensions are square.
    */
    var isSquare: Bool {
        
        return self.rows == self.columns
    }
    
    /**
        Returns the rows dimension value when index == 0, otherwise the columns dimension
        value is returned.
    */
    subscript(index: Int) -> Int {
    
        return index == 0 ? self.rows : self.columns
    }
    
    /**
        Returns whether the dimensions are empty or not.
    
        :returns: true if the dimensions are empty.
    */
    var isEmpty: Bool {
        
        return self.rows == 0 && self.columns == 0
    }
}

// MARK: Dimensions Equality
func == (left: Dimensions, right: Dimensions) -> Bool {
    
    return left[0] == right[0] && left[1] == right[1]
}

// MARK: Dimensions Tuple Equality
func == (left: Dimensions, right: (Int, Int)) -> Bool {
    
    let (n, m) = right
    
    return left[0] == n && left[1] == m
}

func == (left: (Int, Int), right: Dimensions) -> Bool {
    
    return right == left
}

// MARK: Dimensions Summation
func + (left: Dimensions, right: Dimensions) -> Dimensions {
    
    return Dimensions(left[0] + right[0], left[1] + right[1])
}

// MARK: Dimensions Negation
prefix func - (dimensions: Dimensions) -> Dimensions {
    
    return Dimensions(-dimensions[0], -dimensions[1])
}

// MARK: Dimensions Subtraction
func - (left: Dimensions, right: Dimensions) -> Dimensions {
    
    return left + -right
}
