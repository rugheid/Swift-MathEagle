//
//  Math.swift
//  SwiftMath
//
//  Created by Rugen Heidbuchel on 30/12/14.
//  Copyright (c) 2014 Jorestha Solutions. All rights reserved.
//

import Foundation



// MARK: BasicMathValue Protocol

public protocol BasicMathValue: Comparable, Addable, Subtractable, Multiplicable, Dividable, SetCompliant, ExpressibleByIntegerLiteral {}


// MARK: FullMathValue Protocol

public protocol FullMathValue: Comparable, Addable, Negatable, Subtractable, Multiplicable, Dividable, NaturalPowerable, IntegerPowerable, RealPowerable, SetCompliant, ExpressibleByIntegerLiteral {}


// MARK: Basic Type Protocol Adoptions

extension Int: Addable, Negatable, Subtractable, Multiplicable, Dividable, Modulable, NaturalPowerable, IntegerPowerable, RealPowerable, SetCompliant, BasicMathValue, FullMathValue, MatrixCompatible {
    
    public typealias NaturalPowerType = Int
    public typealias IntegerPowerType = Double
    public typealias RealPowerType = Double
}
extension Int8: Addable, Negatable, Subtractable, Multiplicable, Dividable, Modulable, NaturalPowerable, IntegerPowerable, RealPowerable, SetCompliant, BasicMathValue, FullMathValue, MatrixCompatible {
    
    public typealias NaturalPowerType = Int
    public typealias IntegerPowerType = Double
    public typealias RealPowerType = Double
}
extension Int16: Addable, Negatable, Subtractable, Multiplicable, Dividable, Modulable, NaturalPowerable, IntegerPowerable, RealPowerable, SetCompliant, BasicMathValue, FullMathValue, MatrixCompatible {
    
    public typealias NaturalPowerType = Int
    public typealias IntegerPowerType = Double
    public typealias RealPowerType = Double
}
extension Int32: Addable, Negatable, Subtractable, Multiplicable, Dividable, Modulable, NaturalPowerable, IntegerPowerable, RealPowerable, SetCompliant, BasicMathValue, FullMathValue, MatrixCompatible {
    
    public typealias NaturalPowerType = Int
    public typealias IntegerPowerType = Double
    public typealias RealPowerType = Double
}
extension Int64: Addable, Negatable, Subtractable, Multiplicable, Dividable, Modulable, NaturalPowerable, IntegerPowerable, RealPowerable, SetCompliant, BasicMathValue, FullMathValue, MatrixCompatible {
    
    public typealias NaturalPowerType = Int
    public typealias IntegerPowerType = Double
    public typealias RealPowerType = Double
}
extension UInt: Addable, Negatable, Subtractable, Multiplicable, Dividable, Modulable, NaturalPowerable, IntegerPowerable, RealPowerable, SetCompliant, BasicMathValue, MatrixCompatible {
    
    public typealias NaturalPowerType = UInt
    public typealias IntegerPowerType = Double
    public typealias RealPowerType = Double
}
extension UInt8: Addable, Negatable, Subtractable, Multiplicable, Dividable, Modulable, NaturalPowerable, IntegerPowerable, RealPowerable, SetCompliant, BasicMathValue, MatrixCompatible {
    
    public typealias NaturalPowerType = UInt
    public typealias IntegerPowerType = Double
    public typealias RealPowerType = Double
}
extension UInt16: Addable, Negatable, Subtractable, Multiplicable, Dividable, Modulable, NaturalPowerable, IntegerPowerable, RealPowerable, SetCompliant, BasicMathValue, MatrixCompatible {
    
    public typealias NaturalPowerType = UInt
    public typealias IntegerPowerType = Double
    public typealias RealPowerType = Double
}
extension UInt32: Addable, Negatable, Subtractable, Multiplicable, Dividable, Modulable, NaturalPowerable, IntegerPowerable, RealPowerable, SetCompliant, BasicMathValue, MatrixCompatible {
    
    public typealias NaturalPowerType = UInt
    public typealias IntegerPowerType = Double
    public typealias RealPowerType = Double
}
extension UInt64: Addable, Negatable, Subtractable, Multiplicable, Dividable, Modulable, NaturalPowerable, IntegerPowerable, RealPowerable, SetCompliant, BasicMathValue, MatrixCompatible {
    
    public typealias NaturalPowerType = UInt
    public typealias IntegerPowerType = Double
    public typealias RealPowerType = Double
}
extension Float: Addable, Negatable, Subtractable, Multiplicable, Dividable, Modulable, NaturalPowerable, IntegerPowerable, RealPowerable, SetCompliant, MatrixCompatible, BasicMathValue, FullMathValue {
    
    public typealias NaturalPowerType = Float
    public typealias IntegerPowerType = Float
    public typealias RealPowerType = Double
    public static func % (left: Float, right: Float) -> Float {
        return left.truncatingRemainder(dividingBy:right)
    }
}
extension Double: Addable, Negatable, Subtractable, Multiplicable, Dividable, Modulable, NaturalPowerable, IntegerPowerable, RealPowerable, SetCompliant, MatrixCompatible, BasicMathValue, FullMathValue {
    
    public typealias NaturalPowerType = Double
    public typealias IntegerPowerType = Double
    public typealias RealPowerType = Double
    public static func % (left: Double, right: Double) -> Double {
        return left.truncatingRemainder(dividingBy:right)
    }
}
extension CGFloat: Addable, Negatable, Subtractable, Multiplicable, Dividable, NaturalPowerable, IntegerPowerable, RealPowerable, SetCompliant, MatrixCompatible, BasicMathValue, FullMathValue {
    
    public typealias NaturalPowerType = CGFloat
    public typealias IntegerPowerType = CGFloat
    public typealias RealPowerType = CGFloat
    public static func % (left: CGFloat, right: CGFloat) -> CGFloat {
        return left.truncatingRemainder(dividingBy:right)
    }
}
extension String: Addable {}

