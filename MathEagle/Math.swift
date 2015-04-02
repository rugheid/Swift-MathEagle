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


// MARK: Modulable Protocol

protocol Modulable {
    
    func % (left: Self, right: Self) -> Self
}


// MARK: Powerable Protocol

infix operator ** {associativity left precedence 160}

protocol Powerable {
    
    typealias PowerType
    func ** (left: Self, right: Double) -> PowerType
    init(PowerType)
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


// MARK: Conjugatable Protocol

protocol Conjugatable {
    
    var conjugate: Self { get }
}

extension Int: Conjugatable {
    
    var conjugate: Int { return self }
}
extension Int8: Conjugatable {
    
    var conjugate: Int8 { return self }
}
extension Int16: Conjugatable {
    
    var conjugate: Int16 { return self }
}
extension Int32: Conjugatable {
    
    var conjugate: Int32 { return self }
}
extension Int64: Conjugatable {
    
    var conjugate: Int64 { return self }
}
extension UInt: Conjugatable {
    
    var conjugate: UInt { return self }
}
extension UInt8: Conjugatable {
    
    var conjugate: UInt8 { return self }
}
extension UInt16: Conjugatable {
    
    var conjugate: UInt16 { return self }
}
extension UInt32: Conjugatable {
    
    var conjugate: UInt32 { return self }
}
extension UInt64: Conjugatable {
    
    var conjugate: UInt64 { return self }
}
extension Float: Conjugatable {
    
    var conjugate: Float { return self }
}
extension Double: Conjugatable {
    
    var conjugate: Double { return self }
}




// MARK: Randomizable Protocol
// This protocol had it's own file, but this gave duplicate symbol errors...

protocol Randomizable {
    
    typealias RandomIntervalType: Comparable
    class func random() -> Self
    class func randomInInterval(intervals: ClosedInterval<RandomIntervalType>...) -> Self
    class func randomInInterval(intervals: [ClosedInterval<RandomIntervalType>]) -> Self
}

extension UInt: Randomizable {
    
    static func random() -> UInt {
        
        let mult = UInt(arc4random())
        return UInt(arc4random_uniform(UInt32.max)) + mult * UInt(UInt32.max)
    }
    
    static func randomInInterval(intervals: ClosedInterval<UInt>...) -> UInt {
    
        return self.randomInInterval(intervals)
    }
    
    static func randomInInterval(intervals: [ClosedInterval<UInt>]) -> UInt {
        
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
}

extension UInt8: Randomizable {
    
    static func random() -> UInt8 {
        
        return UInt8(arc4random_uniform(UInt32(UInt8.max)+1))
    }
    
    static func randomInInterval(intervals: ClosedInterval<UInt8>...) -> UInt8 {
    
        return randomInInterval(intervals)
    }
    
    static func randomInInterval(intervals: [ClosedInterval<UInt8>]) -> UInt8 {
        
        let interval = intervals[0]
        let length = interval.end - interval.start
        let rand = UInt8(arc4random_uniform(UInt32(length)+1))
        return interval.start + rand
    }
}

extension UInt16: Randomizable {
    
    static func random() -> UInt16 {
        
        return UInt16(arc4random_uniform(UInt32(UInt16.max)+1))
    }
    
    static func randomInInterval(intervals: ClosedInterval<UInt16>...) -> UInt16 {
    
        return randomInInterval(intervals)
    }
    
    static func randomInInterval(intervals: [ClosedInterval<UInt16>]) -> UInt16 {
        
        return 0
    }
}

extension UInt32: Randomizable {
    
    static func random() -> UInt32 {
        
        return arc4random()
    }
    
    static func randomInInterval(intervals: ClosedInterval<UInt32>...) -> UInt32 {
    
        return randomInInterval(intervals)
    }
    
    static func randomInInterval(intervals: [ClosedInterval<UInt32>]) -> UInt32 {
        
        let interval = intervals[0]
        let length = interval.end - interval.start
        return interval.start + arc4random_uniform(length + 1)
    }
}

extension UInt64: Randomizable {
    
    static func random() -> UInt64 {
        
        return UInt64(UInt.random())
    }
    
    static func randomInInterval(intervals: ClosedInterval<UInt64>...) -> UInt64 {
    
        return randomInInterval(intervals)
    }
    
    static func randomInInterval(intervals: [ClosedInterval<UInt64>]) -> UInt64 {
        
        return UInt64(UInt.randomInInterval(map(intervals){ ClosedInterval(UInt($0.start), UInt($0.end)) }))
    }
}

extension Int: Randomizable {
    
    static func random() -> Int {
        
        return Int(bitPattern: UInt.random())
    }
    
    static func randomInInterval(intervals: ClosedInterval<Int>...) -> Int {
    
        let interval = intervals[0]
        let length = interval.end - interval.start
        return Int(UInt.randomInInterval(ClosedInterval<UInt>(0, UInt(length))))
    }
    
    static func randomInInterval(intervals: [ClosedInterval<Int>]) -> Int {
        
        let interval = intervals[0]
        let length = interval.end - interval.start
        return interval.start + Int(UInt.randomInInterval(ClosedInterval<UInt>(0, UInt(length))))
    }
}

extension Int8: Randomizable {
    
    static func random() -> Int8 {
        
        return Int8(Int.randomInInterval(ClosedInterval(0, Int(Int8.max))))
    }
    
    static func randomInInterval(intervals: ClosedInterval<Int8>...) -> Int8 {
        
        return randomInInterval(intervals)
    }
    
    static func randomInInterval(intervals: [ClosedInterval<Int8>]) -> Int8 {
        
        return Int8(Int.randomInInterval(map(intervals){ ClosedInterval(Int($0.start), Int($0.end)) }))
    }
}

extension Int16: Randomizable {
    
    static func random() -> Int16 {
        
        return Int16(Int.randomInInterval(ClosedInterval(0, Int(Int16.max))))
    }
    
    static func randomInInterval(intervals: ClosedInterval<Int16>...) -> Int16 {
    
        return randomInInterval(intervals)
    }
    
    static func randomInInterval(intervals: [ClosedInterval<Int16>]) -> Int16 {
        
        return Int16(Int.randomInInterval(map(intervals){ ClosedInterval(Int($0.start), Int($0.end)) }))
    }
}

extension Int32: Randomizable {
    
    static func random() -> Int32 {
        
        return Int32(Int.randomInInterval(ClosedInterval(0, Int(Int32.max))))
    }
    
    static func randomInInterval(intervals: ClosedInterval<Int32>...) -> Int32 {
    
        return randomInInterval(intervals)
    }
    
    static func randomInInterval(intervals: [ClosedInterval<Int32>]) -> Int32 {
        
        return Int32(Int.randomInInterval(map(intervals){ ClosedInterval(Int($0.start), Int($0.end)) }))
    }
}

extension Int64: Randomizable {
    
    static func random() -> Int64 {
        
        return Int64(Int.random())
    }
    
    static func randomInInterval(intervals: ClosedInterval<Int64>...) -> Int64 {
    
        return randomInInterval(intervals)
    }
    
    static func randomInInterval(intervals: [ClosedInterval<Int64>]) -> Int64 {
        
        return Int64(Int.randomInInterval(map(intervals){ ClosedInterval(Int($0.start), Int($0.end)) }))
    }
}

extension Float: Randomizable {
    
    static func random() -> Float {
        
        let sign: Float = arc4random_uniform(2) == 0 ? 1 : -1
        return Float(arc4random()) * sign
    }
    
    static func randomInInterval(intervals: ClosedInterval<Float>...) -> Float {
    
        return randomInInterval(intervals)
    }
    
    static func randomInInterval(intervals: [ClosedInterval<Float>]) -> Float {
        
        return 0
    }
}

extension Double: Randomizable {
    
    static func random() -> Double {
        
        let sign: Double = arc4random_uniform(2) == 0 ? 1 : -1
        return Double(arc4random()) * sign
    }
    
    static func randomInInterval(intervals: ClosedInterval<Double>...) -> Double {
    
        return randomInInterval(intervals)
    }
    
    static func randomInInterval(intervals: [ClosedInterval<Double>]) -> Double {
        
        return 0
    }
}




// MARK: BasicMathValue Protocol

protocol BasicMathValue: Equatable, Comparable, Addable, Substractable, Multiplicable, Dividable, SetCompliant, IntegerLiteralConvertible {}


// MARK: FullMathValue Protocol

protocol FullMathValue: Equatable, Comparable, Addable, Negatable, Substractable, Multiplicable, Dividable, Powerable, SetCompliant, IntegerLiteralConvertible {}


// MARK: Basic Type Protocol Adoptions

extension Int: Addable, Negatable, Substractable, Multiplicable, Dividable, Modulable, Powerable, SetCompliant, BasicMathValue, FullMathValue, MatrixCompatible {}
extension Int8: Addable, Negatable, Substractable, Multiplicable, Dividable, Modulable, Powerable, SetCompliant, BasicMathValue, FullMathValue, MatrixCompatible {}
extension Int16: Addable, Negatable, Substractable, Multiplicable, Dividable, Modulable, Powerable, SetCompliant, BasicMathValue, FullMathValue, MatrixCompatible {}
extension Int32: Addable, Negatable, Substractable, Multiplicable, Dividable, Modulable, Powerable, SetCompliant, BasicMathValue, FullMathValue, MatrixCompatible {}
extension Int64: Addable, Negatable, Substractable, Multiplicable, Dividable, Modulable, Powerable, SetCompliant, BasicMathValue, FullMathValue, MatrixCompatible {}
extension UInt: Addable, Negatable, Substractable, Multiplicable, Dividable, Modulable, Powerable, SetCompliant, BasicMathValue, MatrixCompatible {}
extension UInt8: Addable, Negatable, Substractable, Multiplicable, Dividable, Modulable, Powerable, SetCompliant, BasicMathValue, MatrixCompatible {}
extension UInt16: Addable, Negatable, Substractable, Multiplicable, Dividable, Modulable, Powerable, SetCompliant, BasicMathValue, MatrixCompatible {}
extension UInt32: Addable, Negatable, Substractable, Multiplicable, Dividable, Modulable, Powerable, SetCompliant, BasicMathValue, MatrixCompatible {}
extension UInt64: Addable, Negatable, Substractable, Multiplicable, Dividable, Modulable, Powerable, SetCompliant, BasicMathValue, MatrixCompatible {}
extension Float: Addable, Negatable, Substractable, Multiplicable, Dividable, Modulable, Powerable, SetCompliant, MatrixCompatible, BasicMathValue, FullMathValue {}
extension Double: Addable, Negatable, Substractable, Multiplicable, Dividable, Modulable, Powerable, SetCompliant, MatrixCompatible, BasicMathValue, FullMathValue {}
extension String: Addable {}

