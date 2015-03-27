//
//  Matrix.swift
//  SwiftMath
//
//  Created by Rugen Heidbuchel on 22/12/14.
//  Copyright (c) 2014 Jorestha Solutions. All rights reserved.
//

import Foundation

protocol MatrixCompatible: Equatable, Comparable, Addable, Negatable, Substractable, Multiplicable, Dividable, Powerable, IntegerLiteralConvertible {}

class Matrix <T: MatrixCompatible> : ArrayLiteralConvertible, Equatable, Printable, SequenceType {
    
    
    // MARK: Basic Properties
    
    var elements: [[T]] = [[]]
    
    
    
    // MARK: Initialisation
    
    init() {}
    
    
    init(_ elements: [[T]]) {
    
        self.elements = elements.count == 0 ? [[]] : elements
    }
    
    
    required init(arrayLiteral elements: [T]...) {
        
        self.elements = elements
    }
    
    init(dimensions: Dimensions, generator: (Index) -> T) {
        
        self.elements = []
        
        for row in 0 ..< dimensions.rows {
            
            var rowElements = [T]()
            
            for column in 0 ..< dimensions.columns {
                
                rowElements.append(generator([row, column]))
            }
            
            elements.append(rowElements)
        }
    }
    
    convenience init(size: Int, generator: (Index) -> T) {
        
        self.init(dimensions: Dimensions(size, size), generator: generator)
    }
    
    convenience init(symmetrical elements: [T]) {
        
        var matrixElements = [[T]]()
        
        let size = (elements.count + 1) / 2
        
        for row in 0 ..< size {
            
            var rowElements = [T]()
            
            for column in 0 ..< size {
                
                rowElements.append(elements[row + column])
            }
            
            matrixElements.append(rowElements)
        }
        
        self.init(matrixElements)
    }
    
    convenience init(filledWith element: T, size: Int) {
        
        self.init(filledWith: element, dimensions: Dimensions(size: size))
    }
    
    convenience init(filledWith element: T, dimensions: Dimensions) {
        
        var rowElements = [T](count: dimensions.columns, repeatedValue: element)
        
        self.init([[T]](count: dimensions.rows, repeatedValue: rowElements))
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
    
    var copy: Matrix<T> {
        
        return Matrix(self.elements)
    }
    

    // MARK: Computed Properties
    
    /**
        Returns a textual representation of the matrix. This conforms to the array literal.
    
        :example: [[1, 2], [3, 4], [5, 6]]
    */
    var description: String {
        
        return self.elements.description
    }
    
    
    /**
        Returns the dimensions of matrix.
    
        :returns: The dimensions of the matrix.
    */
    var dimensions: Dimensions {
        
        var dimensions = Dimensions(elements.count, elements[0].count)
        
        if dimensions == Dimensions(1, 0) {
            dimensions = Dimensions(0, 0)
        }
        
        return dimensions
    }
    
    
    /**
        Returns the size of the matrix if the matrix is square. If the matrix is not square, an exception will be raised.
    
        :returns: The size of the matrix if the matrix is square.
    */
    var size: Int {
        
        let n = self.dimensions.rows
        
        if n != self.dimensions.columns {
            
            NSException(name: "Not square", reason: "The matrix is not square, so the size can not be computed. Use dimensions instead.", userInfo: nil).raise()
        }
        
        return n
    }
    
    
    /**
        Gives the rank of the matrix. This is not the tensor rank.
    
        :returns: The rank of the matrix.
    */
    var rank: Int {
        
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
        
        let diagElements = self.diagonalElements
        
        var sum = diagElements[0]
        
        for i in 1 ..< diagElements.count {
            
            sum = sum + diagElements[i]
        }
        
        return sum
    }
    
    
    /**
    Returns an array with the diagonal elements of the matrix.
    
    :returns: An array with the diagonal elements of the matrix.
    */
    var diagonalElements: [T] {
        
        get {
            
            var returnElements = [T]()
            
            for i in 0 ..< self.dimensions.minimum {
                
                returnElements.append(self.elements[i][i])
            }
            
            return returnElements
        }
        
        set(elements) {
            
            let nrOfDiagonals = self.dimensions.minimum
            
            if elements.count != nrOfDiagonals {
                
                NSException(name: "Diagonal elements out of bounds", reason: "\(elements.count) are too many diagonal elements, only \(nrOfDiagonals) needed.", userInfo: nil).raise()
            }
            
            for i in 0 ..< nrOfDiagonals {
                
                self.elements[i][i] = elements[i]
            }
        }
    }
    
    
    /**
        Returns the maximum element in the matrix.
    
        :returns: The maximum element in the matrix.
    */
    var maxElement: T {
        
        if self.isEmpty {
            
            NSException(name: "Empty matrix", reason: "An empty matrix does not have a maximum value", userInfo: nil).raise()
        }
        
        var max: T = self[0][0]
        
        for row in 0 ..< self.dimensions.rows {
            
            for column in 0 ..< self.dimensions.columns {
                
                if row == 0 && column == 0 { continue }
                
                let value = self[row][column]
                
                if value > max {
                    
                    max = value
                }
            }
        }
        
        return max
        
        // This method seems to be two times slower...
        
//        if self.isEmpty {
//            
//            NSException(name: "Empty matrix", reason: "An empty matrix does not have a maximum value", userInfo: nil).raise()
//        }
//        
//        return reduce(self, nil){ (prev: T?, curr: T) -> T? in
//            
//            if let val = prev {
//                
//                return val < curr ? curr : val
//            }
//            
//            return curr
//        }!
    }
    
    
    /**
        Returns the minimum element in the matrix.
    
        :returns: The minimum element in the matrix.
    */
    var minElement: T {
        
        if self.isEmpty {
            
            NSException(name: "Empty matrix", reason: "An empty matrix does not have a minimum value", userInfo: nil).raise()
        }
        
        var min: T = self[0][0]
        
        for row in 0 ..< self.dimensions.rows {
            
            for column in 0 ..< self.dimensions.columns {
                
                if row == 0 && column == 0 { continue }
                
                let value = self[row][column]
                
                if value < min {
                    
                    min = value
                }
            }
        }
        
        return min
    }
    
    
    /**
        Return the transpose of the matrix.
    */
    var transpose: Matrix<T> {
        
        var returnElements = [[T]]()
        
        for col in 0 ..< self.dimensions.columns {
            
            var rowElements = [T]()
            
            for row in 0 ..< self.dimensions.rows {
                
                rowElements.append(self[row][col])
            }
            
            returnElements.append(rowElements)
        }
        
        return Matrix(returnElements)
    }
    
    
    /**
        Returns whether the matrix is empty. This means the dimensions are (0, 0).
    
        :returns: true if the matrix is empty.
    */
    var isEmpty: Bool {
        
        return self.dimensions.isEmpty
    }
    
    
    /**
        Returns whether the matrix is square.
    
        :returns: true if the matrix is square.
    */
    var isSquare: Bool {
        
        return self.dimensions.isSquare
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
        
        let nrOfSecondDiagonals = 2 * size - 1
        
        for i in 1 ..< nrOfSecondDiagonals - 1 {
            
            var (row, column) = (i < size ? i : size - 1, i > size ? i - size : 0)
            
            let value = self.elements[row][column]
            
            while row > 0 && column < size - 1 {
                
                row--
                column++
                
                if self.elements[row][column] != value {
                    
                    return false
                }
            }
        }
        
        return true
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
            
            NSException(name: "Row index out of bounds", reason: "The requested element's row index is out of bounds.", userInfo: nil)
        }
        
        if column < 0 || column >= self.dimensions.columns {
            
            NSException(name: "Column index out of bounds", reason: "The requested element's column index is out of bounds.", userInfo: nil)
        }
        
        return self.elements[row][column]
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
        
        self.elements[row][column] = element
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
        
        return Vector(self.elements[index])
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
        
        self.elements[index] = newRow.elements
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
            
            column.append(self.elements[i][index])
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
            
            self.elements[i][index] = newColumn[i]
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
        
        var matrixElements = [[T]]()
        
        for row in rowRange {
            
            var rowElements = [T]()
            
            for column in columnRange {
                
                rowElements.append(self[row][column])
            }
            
            matrixElements.append(rowElements)
        }
        
        return Matrix(matrixElements)
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
                
                self.elements[row][column] = matrix[row - rowRange.startIndex][column - columnRange.startIndex]
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
            
            vectorElements.append(self.elements[row][column])
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
            
            self.elements[row][column] = vector[row - rowRange.startIndex]
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
            
            vectorElements.append(self.elements[row][column])
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
            
            self.elements[row][column] = vector[column - columnRange.startIndex]
        }
    }
    
    
    /**
        Fills the diagonal with the given value.
    
        :param: value The value to fill the diagonal with.
    */
    func fillDiagonal(value: T) {
        
        for i in 0 ..< self.dimensions.minimum {
            
            self.elements[i][i] = value
        }
    }
    
    
    
    // MARK: Factorisations
    
    /**
        Returns the LU decomposition of the matrix. This is only possible if the matrix is square.
    
        :returns: (L, U, P) with L being a lower triangular matrix with 1 on the diagonal, U an upper triangular matrix and P a permutation matrix. This way PA = LU.
    */
    var LUDecomposition: (Matrix<T>, Matrix<T>, Matrix<T>) {
        
        return self.LUDecomposition()
    }
    
    
    func LUDecomposition(pivoting: Bool = true, optimalPivoting: Bool = true) -> (Matrix<T>, Matrix<T>, Matrix<T>) {
        
        if !self.isSquare {
            
            NSException(name: "Not square", reason: "A non-square matrix does not have a LU decomposition.", userInfo: nil).raise()
        }
        
        let n = self.size
        
        var L = Matrix(identityOfSize: n)
        var U = self.copy
        var P = Matrix(identityOfSize: n)
        
        for i in 0 ..< n {
            
            if pivoting {
                
                var p = i, max = U[i][i]
                
                for j in i ..< n {
                    
                    if U[i][j] > max { max = U[i][j]; p = j }
                }
                
                U.switchRows(p, i)
                P.switchRows(p, i)
            }
            
            L[i+1 ..< n, i] = U[i+1 ..< n, i]/U[i][i]
            U[i+1 ..< n, i+1 ..< n] = U[i+1 ..< n, i+1 ..< n] - L[i+1 ..< n, i].directProduct(U[i, i+1 ..< n])
            U[i+1 ..< n, i] = Vector(filledWith: 0, length: n-i-1)
        }
        
        return (L, U, P)
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

func == <T: MatrixCompatible> (left: Matrix<T>, right: Matrix<T>) -> Bool {
    
    if left.dimensions != right.dimensions {
        
        return false
    }
    
    for i in 0 ..< left.dimensions.rows {
        
        if left[i] != right[i] {
            
            return false
        }
    }
    
    return true
}


// MARK: Matrix Addition

func + <T: MatrixCompatible> (left: Matrix<T>, right: Matrix<T>) -> Matrix<T> {
    
    return mcombine(left, right){ $0 + $1 }
}


// MARK: Matrix Negation

prefix func - <T: MatrixCompatible> (matrix: Matrix<T>) -> Matrix<T> {
    
    return mmap(matrix){ -$0 }
}


// MARK: Matrix Substraction

func - <T: MatrixCompatible> (left: Matrix<T>, right: Matrix<T>) -> Matrix<T> {
    
    return mcombine(left, right){ $0 - $1 }
}


// MARK: Matrix Scalar Multiplication

func * <T: MatrixCompatible> (scalar: T, matrix: Matrix<T>) -> Matrix<T> {
    
    return Matrix(map(matrix.elements){ map($0){ scalar * $0 } })
}

func * <T: MatrixCompatible> (matrix: Matrix<T>, scalar: T) -> Matrix<T> {
    
    return scalar * matrix
}


// MARK: Matrix Multiplication

func * <T: MatrixCompatible> (left: Matrix<T>, right: Matrix<T>) -> Matrix<T> {
    
    let v = left.dimensions.columns
    
    if v != right.dimensions.rows {
        
        NSException(name: "Wrong dimensions", reason: "The left matrix's number of columns is not equal to the right matrix's rows.", userInfo: nil).raise()
    }
    
    var matrixElements = [[T]]()
    
    for row in 0 ..< left.dimensions.rows {
        
        var rowElements = [T]()
        
        for column in 0 ..< right.dimensions.columns {
            
            var element:T = left[row][0] * right[0][column]
            
            for i in 1 ..< v {
                
                element = element + left[row][i] * right[i][column]
            }
            
            rowElements.append(element)
        }
        
        matrixElements.append(rowElements)
    }
    
    return Matrix(matrixElements)
}


// MARK: Matrix Functional Methods

func mmap <T: MatrixCompatible, U: MatrixCompatible> (matrix: Matrix<T>, transform: T -> U) -> Matrix<U> {
    
    let matrixElements = map(matrix.elements){ map($0, transform) }
    
    return Matrix(matrixElements)
}

func mreduce <T: MatrixCompatible, U: MatrixCompatible> (matrix: Matrix<T>, initial: U, combine: (U, T) -> U) -> U {
    
    var reduced = initial
    
    for element in matrix {
        
        reduced = combine(reduced, element)
    }
    
    return reduced
}

func mcombine <T: MatrixCompatible, U: MatrixCompatible, V: MatrixCompatible> (left: Matrix<T>, right: Matrix<U>, combine: (T, U) -> V) -> Matrix<V> {

    if left.dimensions != right.dimensions {
        
        NSException(name: "Unequal dimensions", reason: "The dimensions of the two matrices are not equal.", userInfo: nil).raise()
    }
    
    var matrixElements = [[V]]()
    
    for row in 0 ..< left.dimensions.rows {
        
        var rowElements = [V]()
        
        for column in 0 ..< left.dimensions.columns {
            
            rowElements.append(combine(left[row][column], right[row][column]))
        }
        
        matrixElements.append(rowElements)
    }
    
    return Matrix(matrixElements)
}



// MARK: - Matrix Generators

// MARK: Int Matrices

/**
    Returns a random Int type matrix with the given dimensions. The elements are generated using the generator.

    :param: dimensions The dimensions of the matrix.
    :param: generator The generator used to generate the elements.

    :returns: A random Matrix<Int> with the given dimensions. The elements are generated using the generator.
*/
func randomIntMatrix(withDimensions dimensions: Dimensions, #generator: () -> Int) -> Matrix<Int> {
    
    var matrixElements = [[Int]]()
    
    for row in 0 ..< dimensions.rows {
        
        var rowElements = [Int]()
        
        for column in 0 ..< dimensions.columns {
            
            rowElements.append(generator())
        }
        
        matrixElements.append(rowElements)
    }
    
    return Matrix(matrixElements)
}

/**
    Returns a random Int matrix with the given size. the elements are generated using the generator.

    :param: size The size of the matrix.
    :param: generator The generator used to generate the elements.

    :returns: A random Matrix<Int> with the given size. The elements are generated using the generator.
*/
func randomIntMatrix(withSize size: Int, #generator: () -> Int) -> Matrix<Int> {
    
    return randomIntMatrix(withDimensions: Dimensions(size, size), generator: generator)
}

/**
    Returns a random Int matrix with the given dimensions.

    :param: dimensions The dimensions of the matrix.

    :returns: A random Matrix<Int> with the given dimensions.

    :warning: The elements can become very large, since the max value is UINT32_MAX.
*/
func randomIntMatrix(withDimensions dimensions: Dimensions) -> Matrix<Int> {
    
    return randomIntMatrix(withDimensions: dimensions){ Int(arc4random()) }
}

/**
    Returns a random square Int matrix with the given size.

    :param: size The size of the matrix.

    :returns: A random Matrix<Int> with the given dimensions.

    :warning: The elements can become very large, since the max value is UINT32_MAX.
*/
func randomIntMatrix(withSize size: Int) -> Matrix<Int> {
    
    return randomIntMatrix(withDimensions: Dimensions(size, size))
}

/**
    Returns a random Int matrix with the given dimensions. The elements lie within the given Int range.

    :param: range The range in which the elements may lie.
    :param: dimensions The dimensions of the matrix.

    :returns: A random Matrix<Int> with the given dimensions. The elements lie within the given Int range.
*/
func randomIntMatrix(intRange range: Range<Int>, #dimensions: Dimensions) -> Matrix<Int> {
    
    return randomIntMatrix(withDimensions: dimensions){
        
        range.startIndex + Int(arc4random_uniform(UInt32(range.endIndex - range.startIndex)))
    }
}

func randomIntMatrix(intRange range: Range<Int>, #size: Int) -> Matrix<Int> {
    
    return randomIntMatrix(intRange: range, dimensions: Dimensions(size, size))
}


// MARK: Float Matrices

/**
Returns a random Float type matrix with the given dimensions. The elements are generated using the generator.

:param: dimensions The dimensions of the matrix.
:param: generator The generator used to generate the elements.

:returns: A random Matrix<Float> with the given dimensions. The elements are generated using the generator.
*/
func randomFloatMatrix(withDimensions dimensions: Dimensions, #generator: () -> Float) -> Matrix<Float> {
    
    var matrixElements = [[Float]]()
    
    for row in 0 ..< dimensions.rows {
        
        var rowElements = [Float]()
        
        for column in 0 ..< dimensions.columns {
            
            rowElements.append(generator())
        }
        
        matrixElements.append(rowElements)
    }
    
    return Matrix(matrixElements)
}

/**
Returns a random Int matrix with the given size. the elements are generated using the generator.

:param: size The size of the matrix.
:param: generator The generator used to generate the elements.

:returns: A random Matrix<Int> with the given size. The elements are generated using the generator.
*/
func randomFloatMatrix(withSize size: Int, #generator: () -> Float) -> Matrix<Float> {
    
    return randomFloatMatrix(withDimensions: Dimensions(size, size), generator: generator)
}

/**
Returns a random Float matrix with the given dimensions.

:param: dimensions The dimensions of the matrix.

:returns: A random Matrix<Float> with the given dimensions.

:warning: The elements can become very large.
*/
func randomFloatMatrix(withDimensions dimensions: Dimensions) -> Matrix<Float> {
    
    return randomFloatMatrix(withDimensions: dimensions){ Float(arc4random()) }
}

/**
Returns a random square Float matrix with the given size.

:param: size The size of the matrix.

:returns: A random Matrix<Float> with the given dimensions.

:warning: The elements can become very large.
*/
func randomFloatMatrix(withSize size: Int) -> Matrix<Float> {
    
    return randomFloatMatrix(withDimensions: Dimensions(size, size))
}



// MARK: - Additional Structs

// MARK: - MatrixGenerator

struct MatrixGenerator <T: MatrixCompatible> : GeneratorType {
    
    let matrix: Matrix<T>
    
    var row = 0, column = 0
    
    init(matrix: Matrix<T>) {
        
        self.matrix = matrix
    }
    
    mutating func next() -> T? {
        
        if column >= matrix.dimensions.columns {
            
            column = 0
            row++
        }
        
        if row >= matrix.dimensions.rows {
            
            return nil
        }
        
        let element = matrix[row][column]
        
        column++
        
        return element
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

struct Dimensions: Equatable, Addable {
    
    let rows: Int
    let columns: Int
    
    init(_ rows: Int = 0, _ columns: Int = 0) {
        
        self.rows = rows
        self.columns = columns
    }
    
    init(size: Int) {
        
        self.init(size, size)
    }
    
    /**
        Returns the minimal value of both dimension values (rows, columns).
    
        :returns: The minimal value of both dimension values (rows, columns).
    */
    var minimum: Int {
        
        return self.rows < self.columns ? self.rows : self.columns
    }
    
    /**
        Returns whether the dimensions are sqaure or not. Dimensions are sqaure when the number of
        rows equals the number of columns.
    
        :returns: true if the dimensions are square.
    */
    var isSquare: Bool {
        
        return self.rows == self.columns
    }
    
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

// MARK: Dimensions Substraction
func - (left: Dimensions, right: Dimensions) -> Dimensions {
    
    return left + -right
}



