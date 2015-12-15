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
public enum Parity: IntegerLiteralConvertible, Addable, Subtractable, Multiplicable {
    
    /// Denotes an even parity.
    case Even
    
    /// Denotes an odd parity.
    case Odd
    
    
    
    // MARK: Initialisers
    
    /**
        Creates a parity from the given integer literal.
    */
    public init(integerLiteral value: IntegerLiteralType) {
        
        self = Parity.fromMod2Remainder(value)
    }
    
    
    /**
        Returns a parity from the value modulo 2.
    */
    public static func fromMod2Remainder(value: Int) -> Parity {
        
        return value % 2 == 0 ? .Even : .Odd
    }
    
    
    /**
        Returns a parity from the sign of the value.
    
        :exception: Throws an exception when the given value equals zero.
    */
    public static func fromSign(value: Int) -> Parity {
        
        if value == 0 {
            NSException(name: "Sign can't be 0.", reason: "The sign to initialise from can't be 0.", userInfo: nil).raise()
        }
        
        return value > 0 ? .Even : .Odd
    }
    
    
    
    // MARK: Properties
    
    /**
        Returns the remainder modulo 2. This is 0 when even and 1 when odd.
    */
    public var mod2Remainder: Int {
        
        return self == .Even ? 0 : 1
    }
    
    
    /**
        Returns the sign of the parity. This is 1 when even and -1 when odd.
    */
    public var sign: Int {
        
        return self == .Even ? 1 : -1
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

public func += (inout left: Parity, right: Parity) {
    
    left = left + right
}



// MARK: Subtractable

/**
    Returns the difference of the two given parities. When they are equal `.Even` is returned,
    otherwise `.Odd`.
*/
public func - (left: Parity, right: Parity) -> Parity {
    
    return left + right
}



// MARK: Multiplicable

/**
    Returns the product of the two given parities. When both parities are `.Odd`, `.Odd` is returned,
    otherwise `.Even`.
*/
public func * (left: Parity, right: Parity) -> Parity {
    
    return left == .Odd && right == .Odd ? .Odd : .Even
}