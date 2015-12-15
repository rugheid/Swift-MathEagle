//
//  BasicOperations.swift
//  MathEagle
//
//  Created by Rugen Heidbuchel on 18/06/15.
//  Copyright © 2015 Jorestha Solutions. All rights reserved.
//

import Foundation


// MARK: Addable Protocol

public protocol Addable {
    
    func + (left: Self, right: Self) -> Self
    func += (inout left: Self, right: Self)
}


// MARK: Negatable Protocol

public protocol Negatable {
    
    prefix func - (instance: Self) -> Self
}

public prefix func - (x: UInt) -> UInt {
    return x
}
public prefix func - (x: UInt8) -> UInt8 {
    return x
}
public prefix func - (x: UInt16) -> UInt16 {
    return x
}
public prefix func - (x: UInt32) -> UInt32 {
    return x
}
public prefix func - (x: UInt64) -> UInt64 {
    return x
}


// MARK: Subtractable Protocol

public protocol Subtractable {
    
    func - (left: Self, right: Self) -> Self
}


// MARK: Multiplicable Protocol

public protocol Multiplicable {
    
    func * (left: Self, right: Self) -> Self
}


// MARK: Dividable Protocol

public protocol Dividable {
    
    func / (left: Self, right: Self) -> Self
}


// MARK: Modulable Protocol

public protocol Modulable {
    
    func % (left: Self, right: Self) -> Self
}


// MARK: SetCompliant Protocol

public protocol SetCompliant {
    
    var isNatural: Bool { get }
    var isInteger: Bool { get }
}