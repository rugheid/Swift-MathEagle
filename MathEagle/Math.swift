//
//  Math.swift
//  SwiftMath
//
//  Created by Rugen Heidbuchel on 30/12/14.
//  Copyright (c) 2014 Jorestha Solutions. All rights reserved.
//

import Foundation


// MARK: Constants

let PI = 3.14159265358979




// MARK: Addable Protocol

protocol Addable {
    
    func + (left: Self, right: Self) -> Self
}


// MARK: Negatable Protocol

protocol Negatable {
    
    prefix func - (instance: Self) -> Self
}


// MARK: Substractable Protocol

protocol Substractable {
    
    func - (left: Self, right: Self) -> Self
}


// MARK: Multiplicable Protocol

protocol Multiplicable {
    
    func * (left: Self, right: Self) -> Self
}


// MARK: Dividable Protocol

protocol Dividable {
    
    func / (left: Self, right: Self) -> Self
}


// MARK: Powerable Protocol

infix operator ** {associativity left precedence 160}

protocol Powerable {
    
    func ** (left: Self, right: Double) -> Double
}

func ** (left: Double, right: Double) -> Double {
    
    return pow(left, right)
}
func ** (left: Double, right: Int) -> Double {
    
    return pow(left, Double(right))
}
func ** (left: Float, right: Float) -> Float {
    
    return pow(left, right)
}
func ** (left: Float, right: Double) -> Double {
    
    return pow(Double(left), right)
}
func ** (left: Double, right: Float) -> Double {
    
    return pow(left, Double(right))
}
func ** (left: Int, right: Double) -> Double {
    
    return pow(Double(left), right)
}
func ** (left: Int8, right: Double) -> Double {
    
    return pow(Double(left), right)
}
func ** (left: Int16, right: Double) -> Double {
    
    return pow(Double(left), right)
}
func ** (left: Int32, right: Double) -> Double {
    
    return pow(Double(left), right)
}
func ** (left: Int64, right: Double) -> Double {
    
    return pow(Double(left), right)
}


// MARK: SetCompliant Protocol

protocol SetCompliant {
    
    func isNatural() -> Bool
    func isInteger() -> Bool
}


// MARK: BasicMathValue Protocol

protocol BasicMathValue: Equatable, Comparable, Addable, Substractable, Multiplicable, Dividable, SetCompliant, IntegerLiteralConvertible {}


// MARK: FullMathValue Protocol

protocol FullMathValue: Equatable, Comparable, Addable, Negatable, Substractable, Multiplicable, Dividable, Powerable, SetCompliant, IntegerLiteralConvertible {}


// MARK: Basic Type Protocol Adoptions

extension Int: Addable, Negatable, Substractable, Multiplicable, Dividable, Powerable, SetCompliant, BasicMathValue, FullMathValue {}
extension Int8: Addable, Negatable, Substractable, Multiplicable, Dividable, Powerable, SetCompliant, BasicMathValue, FullMathValue {}
extension Int16: Addable, Negatable, Substractable, Multiplicable, Dividable, Powerable, SetCompliant, BasicMathValue, FullMathValue {}
extension Int32: Addable, Negatable, Substractable, Multiplicable, Dividable, Powerable, SetCompliant, BasicMathValue, FullMathValue {}
extension Int64: Addable, Negatable, Substractable, Multiplicable, Dividable, Powerable, SetCompliant, BasicMathValue, FullMathValue {}
extension UInt: Addable, Substractable, Multiplicable, Dividable, SetCompliant, BasicMathValue {}
extension UInt8: Addable, Substractable, Multiplicable, Dividable, SetCompliant, BasicMathValue {}
extension UInt16: Addable, Substractable, Multiplicable, Dividable, SetCompliant, BasicMathValue {}
extension UInt32: Addable, Substractable, Multiplicable, Dividable, SetCompliant, BasicMathValue {}
extension UInt64: Addable, Substractable, Multiplicable, Dividable, SetCompliant, BasicMathValue {}
extension Float: Addable, Negatable, Substractable, Multiplicable, Dividable, Powerable, SetCompliant, BasicMathValue, FullMathValue {}
extension Double: Addable, Negatable, Substractable, Multiplicable, Dividable, Powerable, SetCompliant, BasicMathValue, FullMathValue {}
extension String: Addable {}