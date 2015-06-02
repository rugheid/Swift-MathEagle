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


// MARK: Powerable Protocol

infix operator ** {associativity left precedence 160}

public protocol Powerable {
    
    typealias PowerType
    func ** (left: Self, right: Double) -> PowerType
    init(PowerType)
}

public func ** (left: Double, right: Double) -> Double {
    
    return pow(left, right)
}
public func ** (left: Double, right: Int) -> Double {
    
    return pow(left, Double(right))
}
public func ** (left: Float, right: Float) -> Float {
    
    return pow(left, right)
}
public func ** (left: Float, right: Double) -> Double {
    
    return pow(Double(left), right)
}
public func ** (left: Double, right: Float) -> Double {
    
    return pow(left, Double(right))
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




// MARK: Randomizable Protocol
// This protocol had it's own file, but this gave duplicate symbol errors...

public protocol Randomizable {
    
    typealias RandomIntervalType: Comparable
    static func random() -> Self
    static func randomInInterval(intervals: ClosedInterval<RandomIntervalType>...) -> Self
    static func randomInInterval(intervals: [ClosedInterval<RandomIntervalType>]) -> Self
    static func randomArrayOfLength(length: Int) -> [Self]
}

extension UInt: Randomizable {
    
    public static func random() -> UInt {
        
        let mult = UInt(arc4random())
        return UInt(arc4random_uniform(UInt32.max)) + mult * UInt(UInt32.max)
    }
    
    public static func randomInInterval(intervals: ClosedInterval<UInt>...) -> UInt {
    
        return self.randomInInterval(intervals)
    }
    
    public static func randomInInterval(intervals: [ClosedInterval<UInt>]) -> UInt {
        
        let interval = intervals[0]
        let length = interval.end - interval.start
        var random: UInt
        if length >= UInt(UInt32.max) {
            let half = UInt(arc4random_uniform(2))
            random = UInt(arc4random_uniform(UInt32(length/2))) + half * length/2
        } else {
            random = UInt(arc4random_uniform(UInt32(length + 1)))
        }
        return interval.start + random
    }
    
    public static func randomArrayOfLength(length: Int) -> [UInt] {
        
        var array = [UInt](count: length, repeatedValue: 0)
        
        Random_OBJC.randomUIntArrayOfLength(length, inArray: &array)
        
        return array
    }
}

extension UInt8: Randomizable {
    
    public static func random() -> UInt8 {
        
        return UInt8(arc4random_uniform(UInt32(UInt8.max)+1))
    }
    
    public static func randomInInterval(intervals: ClosedInterval<UInt8>...) -> UInt8 {
    
        return randomInInterval(intervals)
    }
    
    public static func randomInInterval(intervals: [ClosedInterval<UInt8>]) -> UInt8 {
        
        let interval = intervals[0]
        let length = interval.end - interval.start
        let rand = UInt8(arc4random_uniform(UInt32(length)+1))
        return interval.start + rand
    }
    
    public static func randomArrayOfLength(length: Int) -> [UInt8] {
        
        var array = [UInt8](count: length, repeatedValue: 0)
        
        Random_OBJC.randomUInt8ArrayOfLength(length, inArray: &array)
        
        return array
    }
}

extension UInt16: Randomizable {
    
    public static func random() -> UInt16 {
        
        return UInt16(arc4random_uniform(UInt32(UInt16.max)+1))
    }
    
    public static func randomInInterval(intervals: ClosedInterval<UInt16>...) -> UInt16 {
    
        return randomInInterval(intervals)
    }
    
    public static func randomInInterval(intervals: [ClosedInterval<UInt16>]) -> UInt16 {
        
        return 0
    }
    
    public static func randomArrayOfLength(length: Int) -> [UInt16] {
        
        var array = [UInt16]()
        
        for _ in 0 ..< length {
            array.append(self.random())
        }
        
        return array
    }
}

extension UInt32: Randomizable {
    
    public static func random() -> UInt32 {
        
        return arc4random()
    }
    
    public static func randomInInterval(intervals: ClosedInterval<UInt32>...) -> UInt32 {
    
        return randomInInterval(intervals)
    }
    
    public static func randomInInterval(intervals: [ClosedInterval<UInt32>]) -> UInt32 {
        
        let interval = intervals[0]
        let length = interval.end - interval.start
        return interval.start + arc4random_uniform(length + 1)
    }
    
    public static func randomArrayOfLength(length: Int) -> [UInt32] {
        
        var array = [UInt32]()
        
        for _ in 0 ..< length {
            array.append(self.random())
        }
        
        return array
    }
}

extension UInt64: Randomizable {
    
    public static func random() -> UInt64 {
        
        return UInt64(UInt.random())
    }
    
    public static func randomInInterval(intervals: ClosedInterval<UInt64>...) -> UInt64 {
    
        return randomInInterval(intervals)
    }
    
    public static func randomInInterval(intervals: [ClosedInterval<UInt64>]) -> UInt64 {
        
        return UInt64(UInt.randomInInterval(map(intervals){ ClosedInterval(UInt($0.start), UInt($0.end)) }))
    }
    
    public static func randomArrayOfLength(length: Int) -> [UInt64] {
        
        var array = [UInt64]()
        
        for _ in 0 ..< length {
            array.append(self.random())
        }
        
        return array
    }
}

extension Int: Randomizable {
    
    public static func random() -> Int {
        
        return Int(bitPattern: UInt.random())
    }
    
    public static func randomInInterval(intervals: ClosedInterval<Int>...) -> Int {
    
        let interval = intervals[0]
        let length = interval.end - interval.start
        return Int(UInt.randomInInterval(ClosedInterval<UInt>(0, UInt(length))))
    }
    
    public static func randomInInterval(intervals: [ClosedInterval<Int>]) -> Int {
        
        let interval = intervals[0]
        let length = interval.end - interval.start
        return interval.start + Int(UInt.randomInInterval(ClosedInterval<UInt>(0, UInt(length))))
    }
    
    public static func randomArrayOfLength(length: Int) -> [Int] {
        
        var array = [Int](count: length, repeatedValue: 0)
        
        Random_OBJC.randomIntArrayOfLength(length, inArray: &array)
        
        return array
    }
}

extension Int8: Randomizable {
    
    public static func random() -> Int8 {
        
        return Int8(Int.randomInInterval(ClosedInterval(0, Int(Int8.max))))
    }
    
    public static func randomInInterval(intervals: ClosedInterval<Int8>...) -> Int8 {
        
        return randomInInterval(intervals)
    }
    
    public static func randomInInterval(intervals: [ClosedInterval<Int8>]) -> Int8 {
        
        return Int8(Int.randomInInterval(map(intervals){ ClosedInterval(Int($0.start), Int($0.end)) }))
    }
    
    public static func randomArrayOfLength(length: Int) -> [Int8] {
        
        var array = [Int8]()
        
        for _ in 0 ..< length {
            array.append(self.random())
        }
        
        return array
    }
}

extension Int16: Randomizable {
    
    public static func random() -> Int16 {
        
        return Int16(Int.randomInInterval(ClosedInterval(0, Int(Int16.max))))
    }
    
    public static func randomInInterval(intervals: ClosedInterval<Int16>...) -> Int16 {
    
        return randomInInterval(intervals)
    }
    
    public static func randomInInterval(intervals: [ClosedInterval<Int16>]) -> Int16 {
        
        return Int16(Int.randomInInterval(map(intervals){ ClosedInterval(Int($0.start), Int($0.end)) }))
    }
    
    public static func randomArrayOfLength(length: Int) -> [Int16] {
        
        var array = [Int16]()
        
        for _ in 0 ..< length {
            array.append(self.random())
        }
        
        return array
    }
}

extension Int32: Randomizable {
    
    public static func random() -> Int32 {
        
        return Int32(Int.randomInInterval(ClosedInterval(0, Int(Int32.max))))
    }
    
    public static func randomInInterval(intervals: ClosedInterval<Int32>...) -> Int32 {
    
        return randomInInterval(intervals)
    }
    
    public static func randomInInterval(intervals: [ClosedInterval<Int32>]) -> Int32 {
        
        return Int32(Int.randomInInterval(map(intervals){ ClosedInterval(Int($0.start), Int($0.end)) }))
    }
    
    public static func randomArrayOfLength(length: Int) -> [Int32] {
        
        var array = [Int32]()
        
        for _ in 0 ..< length {
            array.append(self.random())
        }
        
        return array
    }
}

extension Int64: Randomizable {
    
    public static func random() -> Int64 {
        
        return Int64(Int.random())
    }
    
    public static func randomInInterval(intervals: ClosedInterval<Int64>...) -> Int64 {
    
        return randomInInterval(intervals)
    }
    
    public static func randomInInterval(intervals: [ClosedInterval<Int64>]) -> Int64 {
        
        return Int64(Int.randomInInterval(map(intervals){ ClosedInterval(Int($0.start), Int($0.end)) }))
    }
    
    public static func randomArrayOfLength(length: Int) -> [Int64] {
        
        var array = [Int64]()
        
        for _ in 0 ..< length {
            array.append(self.random())
        }
        
        return array
    }
}

extension Float: Randomizable {
    
    public static func random() -> Float {
        
        let sign: Float = arc4random_uniform(2) == 0 ? 1 : -1
        return Float(arc4random()) * sign
    }
    
    public static func randomInInterval(intervals: ClosedInterval<Float>...) -> Float {
    
        return randomInInterval(intervals)
    }
    
    public static func randomInInterval(intervals: [ClosedInterval<Float>]) -> Float {
        
        let interval = intervals[0]
        let length = interval.end - interval.start
        
        return interval.start + abs(random() % length)
    }
    
    public static func randomArrayOfLength(length: Int) -> [Float] {
        
        var array = [Float](count: length, repeatedValue: 0)
        
        Random_OBJC.randomFloatArrayOfLength(length, inArray: &array)
        
        return array
    }
}

extension Double: Randomizable {
    
    public static func random() -> Double {
        
        let sign: Double = arc4random_uniform(2) == 0 ? 1 : -1
        return Double(arc4random()) * sign
    }
    
    public static func randomInInterval(intervals: ClosedInterval<Double>...) -> Double {
    
        return randomInInterval(intervals)
    }
    
    public static func randomInInterval(intervals: [ClosedInterval<Double>]) -> Double {
        
        return 0
    }
    
    public static func randomArrayOfLength(length: Int) -> [Double] {
        
        var array = [Double](count: length, repeatedValue: 0)
        
        Random_OBJC.randomDoubleArrayOfLength(length, inArray: &array)
        
        return array
    }
}




// MARK: BasicMathValue Protocol

public protocol BasicMathValue: Equatable, Comparable, Addable, Substractable, Multiplicable, Dividable, SetCompliant, IntegerLiteralConvertible {}


// MARK: FullMathValue Protocol

public protocol FullMathValue: Equatable, Comparable, Addable, Negatable, Substractable, Multiplicable, Dividable, Powerable, SetCompliant, IntegerLiteralConvertible {}


// MARK: Basic Type Protocol Adoptions

// I have to add Comparable for everything to work properly, but I have no idea why...
extension Int: Comparable, Addable, Negatable, Substractable, Multiplicable, Dividable, Modulable, Powerable, SetCompliant, BasicMathValue, FullMathValue, MatrixCompatible {}
extension Int8: Comparable, Addable, Negatable, Substractable, Multiplicable, Dividable, Modulable, Powerable, SetCompliant, BasicMathValue, FullMathValue, MatrixCompatible {}
extension Int16: Comparable, Addable, Negatable, Substractable, Multiplicable, Dividable, Modulable, Powerable, SetCompliant, BasicMathValue, FullMathValue, MatrixCompatible {}
extension Int32: Comparable, Addable, Negatable, Substractable, Multiplicable, Dividable, Modulable, Powerable, SetCompliant, BasicMathValue, FullMathValue, MatrixCompatible {}
extension Int64: Comparable, Addable, Negatable, Substractable, Multiplicable, Dividable, Modulable, Powerable, SetCompliant, BasicMathValue, FullMathValue, MatrixCompatible {}
extension UInt: Comparable, Addable, Negatable, Substractable, Multiplicable, Dividable, Modulable, Powerable, SetCompliant, BasicMathValue, MatrixCompatible {}
extension UInt8: Comparable, Addable, Negatable, Substractable, Multiplicable, Dividable, Modulable, Powerable, SetCompliant, BasicMathValue, MatrixCompatible {}
extension UInt16: Comparable, Addable, Negatable, Substractable, Multiplicable, Dividable, Modulable, Powerable, SetCompliant, BasicMathValue, MatrixCompatible {}
extension UInt32: Comparable, Addable, Negatable, Substractable, Multiplicable, Dividable, Modulable, Powerable, SetCompliant, BasicMathValue, MatrixCompatible {}
extension UInt64: Comparable, Addable, Negatable, Substractable, Multiplicable, Dividable, Modulable, Powerable, SetCompliant, BasicMathValue, MatrixCompatible {}
extension Float: Addable, Negatable, Substractable, Multiplicable, Dividable, Modulable, Powerable, SetCompliant, MatrixCompatible, BasicMathValue, FullMathValue {}
extension Double: Addable, Negatable, Substractable, Multiplicable, Dividable, Modulable, Powerable, SetCompliant, MatrixCompatible, BasicMathValue, FullMathValue {}
extension String: Addable {}

