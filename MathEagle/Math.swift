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

prefix func - (x: UInt) -> UInt {
    return x
}
prefix func - (x: UInt8) -> UInt8 {
    return x
}
prefix func - (x: UInt16) -> UInt16 {
    return x
}
prefix func - (x: UInt32) -> UInt32 {
    return x
}
prefix func - (x: UInt64) -> UInt64 {
    return x
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
    
    typealias PowerType
    func ** (left: Self, right: Double) -> PowerType
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
func ** (left: UInt, right: Double) -> Double {
    
    return pow(Double(left), right)
}
func ** (left: UInt8, right: Double) -> Double {
    
    return pow(Double(left), right)
}
func ** (left: UInt16, right: Double) -> Double {
    
    return pow(Double(left), right)
}
func ** (left: UInt32, right: Double) -> Double {
    
    return pow(Double(left), right)
}
func ** (left: UInt64, right: Double) -> Double {
    
    return pow(Double(left), right)
}


// MARK: SetCompliant Protocol

protocol SetCompliant {
    
    var isNatural: Bool { get }
    var isInteger: Bool { get }
}


// MARK: BasicMathValue Protocol

protocol BasicMathValue: Equatable, Comparable, Addable, Substractable, Multiplicable, Dividable, SetCompliant, IntegerLiteralConvertible {}


// MARK: FullMathValue Protocol

protocol FullMathValue: Equatable, Comparable, Addable, Negatable, Substractable, Multiplicable, Dividable, Powerable, SetCompliant, IntegerLiteralConvertible {}


// MARK: Basic Type Protocol Adoptions

extension Int: Addable, Negatable, Substractable, Multiplicable, Dividable, Powerable, SetCompliant, BasicMathValue, FullMathValue, MatrixCompatible {}
extension Int8: Addable, Negatable, Substractable, Multiplicable, Dividable, Powerable, SetCompliant, BasicMathValue, FullMathValue, MatrixCompatible {}
extension Int16: Addable, Negatable, Substractable, Multiplicable, Dividable, Powerable, SetCompliant, BasicMathValue, FullMathValue, MatrixCompatible {}
extension Int32: Addable, Negatable, Substractable, Multiplicable, Dividable, Powerable, SetCompliant, BasicMathValue, FullMathValue, MatrixCompatible {}
extension Int64: Addable, Negatable, Substractable, Multiplicable, Dividable, Powerable, SetCompliant, BasicMathValue, FullMathValue, MatrixCompatible {}
extension UInt: Addable, Negatable, Substractable, Multiplicable, Dividable, Powerable, SetCompliant, BasicMathValue, MatrixCompatible {}
extension UInt8: Addable, Negatable, Substractable, Multiplicable, Dividable, Powerable, SetCompliant, BasicMathValue, MatrixCompatible {}
extension UInt16: Addable, Negatable, Substractable, Multiplicable, Dividable, Powerable, SetCompliant, BasicMathValue, MatrixCompatible {}
extension UInt32: Addable, Negatable, Substractable, Multiplicable, Dividable, Powerable, SetCompliant, BasicMathValue, MatrixCompatible {}
extension UInt64: Addable, Negatable, Substractable, Multiplicable, Dividable, Powerable, SetCompliant, BasicMathValue, MatrixCompatible {}
extension Float: Addable, Negatable, Substractable, Multiplicable, Dividable, Powerable, SetCompliant, MatrixCompatible, BasicMathValue, FullMathValue {}
extension Double: Addable, Negatable, Substractable, Multiplicable, Dividable, Powerable, SetCompliant, MatrixCompatible, BasicMathValue, FullMathValue {}
extension String: Addable {}