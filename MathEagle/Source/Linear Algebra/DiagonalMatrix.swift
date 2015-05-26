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
}
