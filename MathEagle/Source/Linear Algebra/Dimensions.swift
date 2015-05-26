//
//  Dimensions.swift
//  MathEagle
//
//  Created by Rugen Heidbuchel on 26/05/15.
//  Copyright (c) 2015 Jorestha Solutions. All rights reserved.
//


/**
    A struct representing the dimensions of a 2-dimensional matrix.
*/
public struct Dimensions: Equatable, Addable {
    
    
    /**
        The number of rows in the dimensions.
    */
    public let rows: Int
    
    
    /**
        The number of columns in the dimensions.
    */
    public let columns: Int
    
    
    
    // MARK: Initialisers
    
    /**
        Creates a new dimensions object with the given number of rows and columns.
    
        :param: rows    The number of rows in the dimensions.
        :param: columns The number of columns in the dimensions.
    */
    public init(_ rows: Int = 0, _ columns: Int = 0) {
        
        self.rows = rows
        self.columns = columns
    }
    
    /**
        Creates a new dimensions object where the number of rows and columns are equal.
    
        :param: size    The size of the dimensions. This value will be used for both the
                number of rows and columns.
    */
    public init(size: Int) {
        
        self.init(size, size)
    }
    
    
    // MARK: Properties
    
    /**
        Returns the minimal value of both dimension values (rows, columns).
    */
    public var minimum: Int {
        
        return self.rows < self.columns ? self.rows : self.columns
    }
    
    /**
        Returns the size of these dimensions. Returns nil if the rows and columns
        dimensions values are not equal.
    */
    public var size: Int? {
        return self.rows == self.columns ? self.rows : nil
    }
    
    /**
        Returns the product of the two dimension values: rows * columns.
    */
    public var product: Int {
        return self.rows * self.columns
    }
    
    /**
        Returns a new Dimensions object with the two dimensions swapped.
    */
    public var transpose: Dimensions {
        return Dimensions(self.columns, self.rows)
    }
    
    /**
        Returns whether the dimensions are sqaure or not. Dimensions are sqaure when the number of
        rows equals the number of columns.
    
        :returns: true if the dimensions are square.
    */
    public var isSquare: Bool {
        
        return self.rows == self.columns
    }
    
    /**
        Returns the rows dimension value when index == 0, otherwise the columns dimension
        value is returned.
    */
    public subscript(index: Int) -> Int {
        
        return index == 0 ? self.rows : self.columns
    }
    
    /**
        Returns whether the dimensions are empty or not.
    
        :returns: true if the dimensions are empty.
    */
    public var isEmpty: Bool {
        
        return self.rows == 0 && self.columns == 0
    }
}

// MARK: Dimensions Equality
public func == (left: Dimensions, right: Dimensions) -> Bool {
    
    return left[0] == right[0] && left[1] == right[1]
}

// MARK: Dimensions Tuple Equality
public func == (left: Dimensions, right: (Int, Int)) -> Bool {
    
    let (n, m) = right
    
    return left[0] == n && left[1] == m
}

public func == (left: (Int, Int), right: Dimensions) -> Bool {
    
    return right == left
}

// MARK: Dimensions Summation
public func + (left: Dimensions, right: Dimensions) -> Dimensions {
    
    return Dimensions(left[0] + right[0], left[1] + right[1])
}

// MARK: Dimensions Negation
public prefix func - (dimensions: Dimensions) -> Dimensions {
    
    return Dimensions(-dimensions[0], -dimensions[1])
}

// MARK: Dimensions Subtraction
public func - (left: Dimensions, right: Dimensions) -> Dimensions {
    
    return left + -right
}