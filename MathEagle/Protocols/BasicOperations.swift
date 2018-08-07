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
    
    static func + (left: Self, right: Self) -> Self
    static func += (left: inout Self, right: Self)
}


// MARK: Negatable Protocol

public protocol Negatable {
    
    prefix static func - (instance: Self) -> Self
}

public prefix func - (x: UInt) -> UInt {
    return UInt(bitPattern:-Int(bitPattern:x))
}
public prefix func - (x: UInt8) -> UInt8 {
    return UInt8(bitPattern:-Int8(bitPattern:x))
}
public prefix func - (x: UInt16) -> UInt16 {
    return UInt16(bitPattern:-Int16(bitPattern:x))
}
public prefix func - (x: UInt32) -> UInt32 {
    return UInt32(bitPattern:-Int32(bitPattern:x))
}
public prefix func - (x: UInt64) -> UInt64 {
    return UInt64(bitPattern:-Int64(bitPattern:x))
}


// MARK: Subtractable Protocol

public protocol Subtractable {
    
    static func - (left: Self, right: Self) -> Self
}


// MARK: Multiplicable Protocol

public protocol Multiplicable {
    
    static func * (left: Self, right: Self) -> Self
}


// MARK: Dividable Protocol

public protocol Dividable {
    
    static func / (left: Self, right: Self) -> Self
}


// MARK: Modulable Protocol

public protocol Modulable {
    
    static func % (left: Self, right: Self) -> Self
}


// MARK: SetCompliant Protocol

public protocol SetCompliant {
    
    var isNatural: Bool { get }
    var isInteger: Bool { get }
}
