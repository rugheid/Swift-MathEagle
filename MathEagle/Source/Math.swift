//
//  Math.swift
//  SwiftMath
//
//  Created by Rugen Heidbuchel on 30/12/14.
//  Copyright (c) 2014 Jorestha Solutions. All rights reserved.
//

import Foundation


// MARK: Constants

/**
    π: The ratio of a circle's circumference to it's diameter. ≈ 3.14159
*/
public let PI = 3.1415926535897932384626433832795028841971693993751

/**
    Φ: The golden ratio. ≈ 1.618
*/
public let GOLDEN_RATIO = (sqrt(5.0) + 1.0)/2.0

/**
    φ: The inverse golden ratio. ≈ 0.618
*/
public let INVERSE_GOLDEN_RATIO = (sqrt(5.0) - 1.0)/2.0

/**
    e: Euler's number, base of the natural logarithm. ≈ 2.71828
*/
public let E = 2.71828182845904523536028747135266249775724709369995

/**
    𝛾: Euler-Mascheroni constant. ≈ 0.57721
*/
public let EULER_MASCHERONI = 0.57721566490153286060651209008240243104215933593992

/**
    e^π: Gelfond's constant. Also (-1)^(-i), where i is the imaginary unit. ≈ 23.14
*/
public let GELFOND = 23.140692632779269005729086

/**
    2^√2: Gelfond-Schneider constant, also called Hilbert number. ≈ 2.665
*/
public let GELFOND_SCHNEIDER = 2.665144142690225188650297




// MARK: Addable Protocol

public protocol Addable {
    
    func + (left: Self, right: Self) -> Self
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


// MARK: Substractable Protocol

public protocol Substractable {
    
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


// MARK: Powerable Protocols

infix operator ** {associativity left precedence 160}

public protocol NaturalPowerable {
    
    typealias NaturalPowerType
    func ** (Self, UInt) -> NaturalPowerType
    init(NaturalPowerType)
}

public func ** (left: Int, right: UInt) -> Int {
    return Int(pow(Double(left), Double(right)))
}
public func ** (left: Int8, right: UInt) -> Int {
    return Int(pow(Double(left), Double(right)))
}
public func ** (left: Int16, right: UInt) -> Int {
    return Int(pow(Double(left), Double(right)))
}
public func ** (left: Int32, right: UInt) -> Int {
    return Int(pow(Double(left), Double(right)))
}
public func ** (left: Int64, right: UInt) -> Int {
    return Int(pow(Double(left), Double(right)))
}
public func ** (left: UInt, right: UInt) -> UInt {
    return UInt(pow(Double(left), Double(right)))
}
public func ** (left: UInt8, right: UInt) -> UInt {
    return UInt(pow(Double(left), Double(right)))
}
public func ** (left: UInt16, right: UInt) -> UInt {
    return UInt(pow(Double(left), Double(right)))
}
public func ** (left: UInt32, right: UInt) -> UInt {
    return UInt(pow(Double(left), Double(right)))
}
public func ** (left: UInt64, right: UInt) -> UInt {
    return UInt(pow(Double(left), Double(right)))
}
public func ** (left: Float, right: UInt) -> Float {
    return pow(left, Float(right))
}
public func ** (left: Double, right: UInt) -> Double {
    return pow(left, Double(right))
}



public protocol IntegerPowerable {
    
    typealias IntegerPowerType
    func ** (Self, Int) -> IntegerPowerType
    init(IntegerPowerType)
}

public func ** (left: Int, right: Int) -> Double {
    return pow(Double(left), Double(right))
}
public func ** (left: Int8, right: Int) -> Double {
    return pow(Double(left), Double(right))
}
public func ** (left: Int16, right: Int) -> Double {
    return pow(Double(left), Double(right))
}
public func ** (left: Int32, right: Int) -> Double {
    return pow(Double(left), Double(right))
}
public func ** (left: Int64, right: Int) -> Double {
    return pow(Double(left), Double(right))
}
public func ** (left: UInt, right: Int) -> Double {
    return pow(Double(left), Double(right))
}
public func ** (left: UInt8, right: Int) -> Double {
    return pow(Double(left), Double(right))
}
public func ** (left: UInt16, right: Int) -> Double {
    return pow(Double(left), Double(right))
}
public func ** (left: UInt32, right: Int) -> Double {
    return pow(Double(left), Double(right))
}
public func ** (left: UInt64, right: Int) -> Double {
    return pow(Double(left), Double(right))
}
public func ** (left: Float, right: Int) -> Float {
    return pow(left, Float(right))
}
public func ** (left: Double, right: Int) -> Double {
    return pow(left, Double(right))
}



public protocol RealPowerable {
    
    typealias RealPowerType
    func ** (Self, Double) -> RealPowerType
    init(RealPowerType)
}

public func ** (left: Int, right: Double) -> Double {
    return pow(Double(left), right)
}
public func ** (left: Int8, right: Double) -> Double {
    return pow(Double(left), right)
}
public func ** (left: Int16, right: Double) -> Double {
    return pow(Double(left), right)
}
public func ** (left: Int32, right: Double) -> Double {
    return pow(Double(left), right)
}
public func ** (left: Int64, right: Double) -> Double {
    return pow(Double(left), right)
}
public func ** (left: UInt, right: Double) -> Double {
    return pow(Double(left), right)
}
public func ** (left: UInt8, right: Double) -> Double {
    return pow(Double(left), right)
}
public func ** (left: UInt16, right: Double) -> Double {
    return pow(Double(left), right)
}
public func ** (left: UInt32, right: Double) -> Double {
    return pow(Double(left), right)
}
public func ** (left: UInt64, right: Double) -> Double {
    return pow(Double(left), right)
}
public func ** (left: Float, right: Double) -> Double {
    return pow(Double(left), right)
}
public func ** (left: Double, right: Double) -> Double {
    return pow(left, right)
}



public func root <X: RealPowerable> (x: X, order: Int) -> X.RealPowerType {
    //FIXME: This function does not work properly for negative x'. root(-8, 3) returns NaN for example.
    return x ** (1.0 / Double(order))
}




// MARK: SetCompliant Protocol

public protocol SetCompliant {
    
    var isNatural: Bool { get }
    var isInteger: Bool { get }
}


// MARK: Conjugatable Protocol

public protocol Conjugatable {
    
     var conjugate: Self { get }
}

 extension Int: Conjugatable {
    
    public var conjugate: Int { return self }
}
extension Int8: Conjugatable {
    
    public var conjugate: Int8 { return self }
}
extension Int16: Conjugatable {
    
    public var conjugate: Int16 { return self }
}
extension Int32: Conjugatable {
    
    public var conjugate: Int32 { return self }
}
extension Int64: Conjugatable {
    
    public var conjugate: Int64 { return self }
}
extension UInt: Conjugatable {
    
    public var conjugate: UInt { return self }
}
extension UInt8: Conjugatable {
    
    public var conjugate: UInt8 { return self }
}
extension UInt16: Conjugatable {
    
    public var conjugate: UInt16 { return self }
}
extension UInt32: Conjugatable {
    
    public var conjugate: UInt32 { return self }
}
extension UInt64: Conjugatable {
    
    public var conjugate: UInt64 { return self }
}
extension Float: Conjugatable {
    
    public var conjugate: Float { return self }
}
extension Double: Conjugatable {
    
    public var conjugate: Double { return self }
}




// MARK: BasicMathValue Protocol

public protocol BasicMathValue: Equatable, Comparable, Addable, Substractable, Multiplicable, Dividable, SetCompliant, IntegerLiteralConvertible {}


// MARK: FullMathValue Protocol

public protocol FullMathValue: Equatable, Comparable, Addable, Negatable, Substractable, Multiplicable, Dividable, NaturalPowerable, IntegerPowerable, RealPowerable, SetCompliant, IntegerLiteralConvertible {}


// MARK: Basic Type Protocol Adoptions

// I have to add Comparable for everything to work properly, but I have no idea why...
extension Int: Addable, Negatable, Substractable, Multiplicable, Dividable, Modulable, NaturalPowerable, IntegerPowerable, RealPowerable, SetCompliant, BasicMathValue, FullMathValue, MatrixCompatible {
    
    public typealias NaturalPowerType = Int
    public typealias IntegerPowerType = Double
    public typealias RealPowerType = Double
}
extension Int8: Addable, Negatable, Substractable, Multiplicable, Dividable, Modulable, NaturalPowerable, IntegerPowerable, RealPowerable, SetCompliant, BasicMathValue, FullMathValue, MatrixCompatible {
    
    public typealias NaturalPowerType = Int
    public typealias IntegerPowerType = Double
    public typealias RealPowerType = Double
}
extension Int16: Addable, Negatable, Substractable, Multiplicable, Dividable, Modulable, NaturalPowerable, IntegerPowerable, RealPowerable, SetCompliant, BasicMathValue, FullMathValue, MatrixCompatible {
    
    public typealias NaturalPowerType = Int
    public typealias IntegerPowerType = Double
    public typealias RealPowerType = Double
}
extension Int32: Addable, Negatable, Substractable, Multiplicable, Dividable, Modulable, NaturalPowerable, IntegerPowerable, RealPowerable, SetCompliant, BasicMathValue, FullMathValue, MatrixCompatible {
    
    public typealias NaturalPowerType = Int
    public typealias IntegerPowerType = Double
    public typealias RealPowerType = Double
}
extension Int64: Addable, Negatable, Substractable, Multiplicable, Dividable, Modulable, NaturalPowerable, IntegerPowerable, RealPowerable, SetCompliant, BasicMathValue, FullMathValue, MatrixCompatible {
    
    public typealias NaturalPowerType = Int
    public typealias IntegerPowerType = Double
    public typealias RealPowerType = Double
}
extension UInt: Addable, Negatable, Substractable, Multiplicable, Dividable, Modulable, NaturalPowerable, IntegerPowerable, RealPowerable, SetCompliant, BasicMathValue, MatrixCompatible {
    
    public typealias NaturalPowerType = UInt
    public typealias IntegerPowerType = Double
    public typealias RealPowerType = Double
}
extension UInt8: Addable, Negatable, Substractable, Multiplicable, Dividable, Modulable, NaturalPowerable, IntegerPowerable, RealPowerable, SetCompliant, BasicMathValue, MatrixCompatible {
    
    public typealias NaturalPowerType = UInt
    public typealias IntegerPowerType = Double
    public typealias RealPowerType = Double
}
extension UInt16: Addable, Negatable, Substractable, Multiplicable, Dividable, Modulable, NaturalPowerable, IntegerPowerable, RealPowerable, SetCompliant, BasicMathValue, MatrixCompatible {
    
    public typealias NaturalPowerType = UInt
    public typealias IntegerPowerType = Double
    public typealias RealPowerType = Double
}
extension UInt32: Addable, Negatable, Substractable, Multiplicable, Dividable, Modulable, NaturalPowerable, IntegerPowerable, RealPowerable, SetCompliant, BasicMathValue, MatrixCompatible {
    
    public typealias NaturalPowerType = UInt
    public typealias IntegerPowerType = Double
    public typealias RealPowerType = Double
}
extension UInt64: Addable, Negatable, Substractable, Multiplicable, Dividable, Modulable, NaturalPowerable, IntegerPowerable, RealPowerable, SetCompliant, BasicMathValue, MatrixCompatible {
    
    public typealias NaturalPowerType = UInt
    public typealias IntegerPowerType = Double
    public typealias RealPowerType = Double
}
extension Float: Addable, Negatable, Substractable, Multiplicable, Dividable, Modulable, NaturalPowerable, IntegerPowerable, RealPowerable, SetCompliant, MatrixCompatible, BasicMathValue, FullMathValue {
    
    public typealias NaturalPowerType = Float
    public typealias IntegerPowerType = Float
    public typealias RealPowerType = Double
}
extension Double: Addable, Negatable, Substractable, Multiplicable, Dividable, Modulable, NaturalPowerable, IntegerPowerable, RealPowerable, SetCompliant, MatrixCompatible, BasicMathValue, FullMathValue {
    
    public typealias NaturalPowerType = Double
    public typealias IntegerPowerType = Double
    public typealias RealPowerType = Double
}
extension String: Addable {}

