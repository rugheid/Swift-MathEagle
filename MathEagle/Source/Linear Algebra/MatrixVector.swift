//
//  MatrixVector.swift
//  SwiftMath
//
//  Created by Rugen Heidbuchel on 11/01/15.
//  Copyright (c) 2015 Jorestha Solutions. All rights reserved.
//

import Foundation

// MARK: Vector - Matrix Product


public func * <T: MatrixCompatible> (left: Vector<T>, right: Matrix<T>) -> Vector<T> {
    
    if left.length != right.dimensions.rows {
        
        NSException(name: "Unequal dimensions", reason: "The vector's length (\(left.length)) is not equal to the matrix's number of rows (\(right.dimensions.rows)).", userInfo: nil).raise()
    }
    
    if left.length == 0 { return Vector() }
    
    var elements = [T]()
    var i = 0
    
    while i < left.length {
        
        elements.append(left.dotProduct(right.column(i)))
        
        i++
    }
    
    return Vector(elements)
}


public func * <T: MatrixCompatible> (left: Matrix<T>, right: Vector<T>) -> Vector<T> {
    
    if right.length != left.dimensions.columns {
        
        NSException(name: "Unequal dimensions", reason: "The vector's length (\(right.length)) is not equal to the matrix's number of columns (\(left.dimensions.columns)).", userInfo: nil).raise()
    }
    
    if right.length == 0 { return Vector() }
    
    var elements = [T]()
    var i = 0
    
    while i < right.length {
        
        elements.append(right.dotProduct(left.row(i)))
        
        i++
    }
    
    return Vector(elements)
}