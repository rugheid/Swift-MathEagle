//
//  DiagonalMatrix.swift
//  MathEagle
//
//  Created by Rugen Heidbuchel on 26/05/15.
//  Copyright (c) 2015 Jorestha Solutions. All rights reserved.
//

import Foundation


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
                self.dimensions = Dimensions()
            } else {
                self.dimensions = Dimensions(newElements.count, newElements[0].count)
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
        self.dimensions = Dimensions(diagonal.count, diagonal.count)
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
        self.dimensions = dimensions
    }
    
    
    /**
        Creates a matrix with the given dimensions using
        the given generator.
    
        :param: dimensions  The dimensions the matrix should have.
        :param: generator   The generator used to generate the matrix.
                This function is called for every element passing
                the index of the element.
    */
    override public init(dimensions: Dimensions, generator: (Index) -> T) {
        super.init()
        
        self.elementsStructure = []
        self.dimensions = dimensions
        
        for i in 0 ..< self.dimensions.minimum {
            self.elementsStructure.append(generator([i, i]))
        }
    }
    
    //TODO: Check whether the super implementation of init(size: generator:) calls this class' implementation.
    
    //TODO: Override random initialisers once they have been made faster.
    
    
    /**
        Creates a matrix with the given dimensions filled with the given element.
    
        :param: element     The element to fill the matrix with.
        :param: dimensions  The dimensions the matrix should have.
    */
    override public init(filledWith element: T, dimensions: Dimensions) {
        super.init()
        
        self.elementsStructure = [T](count: dimensions.minimum, repeatedValue: element)
        self.dimensions = dimensions
    }
    
    
    
    // MARK: Basic Properties
    
    /**
        Gives the rank of the matrix. This is not the tensor rank.
    
        :returns: The rank of the matrix.
    */
    override public var rank: Int {
        
        var rank = self.dimensions.minimum
        
        for element in self.elementsStructure {
            if element == 0 { rank-- }
        }
        
        return rank
    }
    
    
    /**
        Returns the determinant of the matrix.
    */
    override public var determinant: T {
        
        return product(self.diagonalElements)
    }
    
    
    /**
        Gets or sets the diagonal elements of the matrix.
    
        :returns: An array with the diagonal elements of the matrix.
    
        :exception: Throws an exception when the given array countains too many elements.
    */
    override public var diagonalElements: [T] {
        
        get {
            return self.elementsStructure
        }
        
        set(elements) {
            
            if elements.count != self.dimensions.minimum {
                NSException(name: "Wrong number of elements", reason: "Wrong number of diagonal elements provided. Expected \(self.dimensions.minimum), but got \(elements.count).", userInfo: nil).raise()
            }
            
            self.elementsStructure = elements
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
    override public func diagonalElements(_ n: Int = 0) -> [T] {
        
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
    
        :param: n The diagonal's index.
    
        :returns: A matrix where all elements under the diagonal with the given index are zero.
    
        :exception: An exception will be raised if the diagonal at the given index does not exist.
                    This means -n > the number of rows or n > the number of columns.
    */
    override public func upperTriangle(_ n: Int = 0) -> Matrix<T> {
        
        if -n >= self.dimensions.rows || n >= self.dimensions.columns {
            
            NSException(name: "Index out the bounds.", reason: "The given index is out of bounds.", userInfo: nil).raise()
        }
        
        var row = max(-n, 0)
        var col = max(n, 0)
        
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
    
        :param: n   The diagonal's index.
    
        :returns: A matrix where all elements above the diagonal with the given index are zero.
    
        :exception: An exception will be raised if the diagonal at the given index does not exist.
                    This means -n >= the number of rows or n >= the number of columns.
    */
    override public func lowerTriangle(_ n: Int = 0) -> Matrix<T> {
        
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
}
