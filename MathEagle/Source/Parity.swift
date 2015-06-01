//
//  Parity.swift
//  MathEagle
//
//  Created by Rugen Heidbuchel on 01/06/15.
//  Copyright (c) 2015 Jorestha Solutions. All rights reserved.
//

import Foundation

/**
    Defines either even or odd.
*/
public enum Parity: Int,    IntegerLiteralConvertible, Addable, Substractable {
    
    /// Denotes an even parity.
    case Even = 1
    
    /// Denotes an odd parity.
    case Odd = -1
    
    
    /**
        Creates a parity from the given integer literal.
    */
    public init(integerLiteral value: IntegerLiteralType) {
        
        self = value % 2 == 0 ? .Even : .Odd
    }
}


// MARK: Addable

/**
    Returns the sum of the two given parities. When they are equal `.Even` is returned,
    otherwise `.Odd`.
*/
public func + (left: Parity, right: Parity) -> Parity {
    
    return left == right ? .Even : .Odd
}



// MARK: Substractable

/**
    Returns the difference of the two given parities. When they are equal `.Even` is returned,
    otherwise `.Odd`.
*/
public func - (left: Parity, right: Parity) -> Parity {
    
    return left + right
}