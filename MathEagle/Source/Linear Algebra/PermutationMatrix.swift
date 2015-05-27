//
//  PermutationMatrix.swift
//  MathEagle
//
//  Created by Rugen Heidbuchel on 27/05/15.
//  Copyright (c) 2015 Jorestha Solutions. All rights reserved.
//

import Foundation


/**
    A class representing a permutation matrix. This is a square binary matrix with exactly one
    1 in each row and column and 0s elsewhere. When a matrix is left-multiplied with a permuation
    matrix it's rows are permutated.
*/
public class PermutationMatrix <T: MatrixCompatible> : Matrix<T> {
    
    
    // MARK: Inner Structure
    
    /**
        Returns the permutation defining the matrix. This is the permutation that will be performed
        on the rows of a matrix when it is left multiplied with this permutation matrix.
    */
    public var permutation: Permutation
    
    
    /**
        Returns the dimensions of matrix.
    */
    override public var dimensions: Dimensions {
        
        get {
            return Dimensions(size: permutation.length)
        }
        
        set(newDimensions) {
            //TODO: Implement this, or change Matrix's dimensions to a read-only computed property
        }
    }
    
    
    // MARK: Initialisers
    
    /**
        Creates a permutation matrix with the given permutation.
    
        :param: permutation The permutation defining the matrix.
    */
    public init(permutation: Permutation) {
        
        self.permutation = permutation
        
        super.init()
    }
}