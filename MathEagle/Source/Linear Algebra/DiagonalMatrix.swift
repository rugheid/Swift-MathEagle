//
//  DiagonalMatrix.swift
//  MathEagle
//
//  Created by Rugen Heidbuchel on 26/05/15.
//  Copyright (c) 2015 Jorestha Solutions. All rights reserved.
//

/**
    A class representing a diagonal matrix. This matrix stores it's elements in an efficient way.
    The matrix does not have to be square, but it will only have non-zero elements on it's main diagonal.
*/
public class DiagonalMatrix <T: MatrixCompatible> : PackedMatrix<T> {

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
}
