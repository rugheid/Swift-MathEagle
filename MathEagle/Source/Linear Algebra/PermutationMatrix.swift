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
    
    
    
    // MARK: Basic Properties
    
    /**
        Returns a row major ordered list of all elements in the array.
        This should be used for high performance applications.
    */
    override public var elementsList: [T] {
        
        get {
            
            let i = self.size
            
            var elementsList = [T](count: i * i, repeatedValue: 0)
            for r in 0 ..< i {
                elementsList[r * i + self.permutation[r]] = 1
            }
            
            return elementsList
        }
        
        set (newElementsList) {
            //TODO: Implement this.
        }
    }
    
    
    /**
        Returns the size of the matrix if the matrix is square. If the matrix is not
        square it returns nil.
    
        :returns: The size of the matrix if the matrix is square or nil otherwise.
    */
    override public var size: Int {
        return self.permutation.length
    }
    
    
    
    // MARK: Element Methods
    
    /**
        Returns the element at the given index (row, column).
    
        :param: row     The row index of the requested element
        :param: column  The column index of the requested element
    
        :returns: The element at the given index (row, column).
    */
    override public func element(row: Int, _ column: Int) -> T {
        
        if row < 0 || row >= self.size {
            
            NSException(name: "Row index out of bounds", reason: "The requested element's row index is out of bounds.", userInfo: nil).raise()
        }
        
        if column < 0 || column >= self.size {
            
            NSException(name: "Column index out of bounds", reason: "The requested element's column index is out of bounds.", userInfo: nil).raise()
        }
        
        return self.permutation[row] == column ? 1 : 0
    }
    
    
    /**
        Sets the element at the given indexes.
    
        :param: row     The row index of the element
        :param: column  The column index of the element
        :param: element The element to set at the given indexes
    */
    override public func setElement(atRow row: Int, atColumn column: Int, toElement element: T) {
        
        NSException(name: "PermutationMatrix is unsettable", reason: "You can't directly set the elements of a permutation matrix.", userInfo: nil).raise()
    }
    
    
    /**
        Returns the row at the given index. The first row has index 0.
    
        :returns:   The row at the given index.
    */
    override public func row(index: Int) -> Vector<T> {
        
        if index < 0 || index >= self.size {
            
            NSException(name: "Row index out of bounds", reason: "The requested row's index is out of bounds.", userInfo: nil).raise()
        }
        
        var elementsList = [T](count: self.size, repeatedValue: 0)
        
        elementsList[index] = 1
        
        return Vector(elementsList)
    }
    
    
    /**
        Sets the row at the given index to the given row.
    
        :param: index   The index of the row to change.
        :param: newRow  The row to set at the given index.
    */
    override public func setRow(atIndex index: Int, toRow newRow: Vector<T>) {
        
        NSException(name: "PermutationMatrix is unsettable", reason: "You can't directly set the elements of a permutation matrix.", userInfo: nil).raise()
    }
    
    
    /**
        Switches the rows at the given indexes.
    
        :param: i   The index of the first row.
        :param: j   The index of the second row.
    */
    override public func switchRows(i: Int, _ j: Int) {
        
        if i < 0 || i >= self.size || j < 0 || j >= self.size {
            
            NSException(name: "Row index out of bounds", reason: "The index of the row that should be switched is out of bounds.", userInfo: nil).raise()
        }
        
        self.permutation.switchElements(i, j)
    }
    
    
    /**
        Returns the column at the given index. The first column has index 0.
    
        :returns: The column at the given index.
    */
    override public func column(index: Int) -> Vector<T> {
        
        if index < 0 || index >= self.size {
            
            NSException(name: "Column index out of bounds", reason: "The requested column's index is out of bounds.", userInfo: nil).raise()
        }
        
        var column = [T](count: self.size, repeatedValue: 0)
        
        column[self.permutation.indexOfElement(index)] = 1
        
        return Vector(column)
    }
    
    
    /**
        Sets the column at the given index to the given column.
    
        :param: index   The index of the column to change.
        :param: column  The column to set at the given index.
    */
    override public func setColumn(atIndex index: Int, toColumn newColumn: Vector<T>) {
        
        NSException(name: "PermutationMatrix is unsettable", reason: "You can't directly set the elements of a permutation matrix.", userInfo: nil).raise()
    }
    
    
    /**
        Switches the columns at the given indexes.
    
        :param: i   The index of the first column.
        :param: j   The index of the second column.
    */
    override public func switchColumns(i: Int, _ j: Int) {
        
        //TODO: Implement this
    }
}