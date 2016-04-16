//
//  Random.swift
//  MathEagle
//
//  Created by Rugen Heidbuchel on 18/06/15.
//  Copyright © 2015 Jorestha Solutions. All rights reserved.
//

import Foundation

// MARK: Randomizable Protocol

public protocol Randomizable {
    
    associatedtype RandomIntervalType: Comparable
    static func random() -> Self
    static func randomInInterval(intervals: ClosedInterval<RandomIntervalType>...) -> Self
    static func randomInInterval(intervals: [ClosedInterval<RandomIntervalType>]) -> Self
    static func randomArrayOfLength(length: Int) -> [Self]
}


// MARK: Implementations

extension Int: Randomizable {
    
    public typealias RandomIntervalType = Int
    
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
    
    public typealias RandomIntervalType = Int8
    
    public static func random() -> Int8 {
        
        return Int8(Int.randomInInterval(ClosedInterval(0, Int(Int8.max))))
    }
    
    public static func randomInInterval(intervals: ClosedInterval<Int8>...) -> Int8 {
        
        return randomInInterval(intervals)
    }
    
    public static func randomInInterval(intervals: [ClosedInterval<Int8>]) -> Int8 {
        
        return Int8(Int.randomInInterval(intervals.map{ ClosedInterval(Int($0.start), Int($0.end)) }))
    }
    
    public static func randomArrayOfLength(length: Int) -> [Int8] {
        
        var array = [Int8](count: length, repeatedValue: 0)
        
        Random_OBJC.randomInt8ArrayOfLength(length, inArray: &array)
        
        return array
    }
}

extension Int16: Randomizable {
    
    public typealias RandomIntervalType = Int16
    
    public static func random() -> Int16 {
        
        return Int16(Int.randomInInterval(ClosedInterval(0, Int(Int16.max))))
    }
    
    public static func randomInInterval(intervals: ClosedInterval<Int16>...) -> Int16 {
        
        return randomInInterval(intervals)
    }
    
    public static func randomInInterval(intervals: [ClosedInterval<Int16>]) -> Int16 {
        
        return Int16(Int.randomInInterval(intervals.map{ ClosedInterval(Int($0.start), Int($0.end)) }))
    }
    
    public static func randomArrayOfLength(length: Int) -> [Int16] {
        
        var array = [Int16](count: length, repeatedValue: 0)
        
        Random_OBJC.randomInt16ArrayOfLength(length, inArray: &array)
        
        return array
    }
}

extension Int32: Randomizable {
    
    public typealias RandomIntervalType = Int32
    
    public static func random() -> Int32 {
        
        return Int32(Int.randomInInterval(ClosedInterval(0, Int(Int32.max))))
    }
    
    public static func randomInInterval(intervals: ClosedInterval<Int32>...) -> Int32 {
        
        return randomInInterval(intervals)
    }
    
    public static func randomInInterval(intervals: [ClosedInterval<Int32>]) -> Int32 {
        
        return Int32(Int.randomInInterval(intervals.map{ ClosedInterval(Int($0.start), Int($0.end)) }))
    }
    
    public static func randomArrayOfLength(length: Int) -> [Int32] {
        
        var array = [Int32](count: length, repeatedValue: 0)
        
        Random_OBJC.randomInt32ArrayOfLength(length, inArray: &array)
        
        return array
    }
}

extension Int64: Randomizable {
    
    public typealias RandomIntervalType = Int64
    
    public static func random() -> Int64 {
        
        return Int64(Int.random())
    }
    
    public static func randomInInterval(intervals: ClosedInterval<Int64>...) -> Int64 {
        
        return randomInInterval(intervals)
    }
    
    public static func randomInInterval(intervals: [ClosedInterval<Int64>]) -> Int64 {
        
        return Int64(Int.randomInInterval(intervals.map{ ClosedInterval(Int($0.start), Int($0.end)) }))
    }
    
    public static func randomArrayOfLength(length: Int) -> [Int64] {
        
        var array = [Int64](count: length, repeatedValue: 0)
        
        Random_OBJC.randomInt64ArrayOfLength(length, inArray: &array)
        
        return array
    }
}

extension UInt: Randomizable {
    
    public typealias RandomIntervalType = UInt
    
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
    
    public typealias RandomIntervalType = UInt8
    
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
    
    public typealias RandomIntervalType = UInt16
    
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
        
        var array = [UInt16](count: length, repeatedValue: 0)
        
        Random_OBJC.randomUInt16ArrayOfLength(length, inArray: &array)
        
        return array
    }
}

extension UInt32: Randomizable {
    
    public typealias RandomIntervalType = UInt32
    
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
        
        var array = [UInt32](count: length, repeatedValue: 0)
        
        Random_OBJC.randomUInt32ArrayOfLength(length, inArray: &array)
        
        return array
    }
}

extension UInt64: Randomizable {
    
    public typealias RandomIntervalType = UInt64
    
    public static func random() -> UInt64 {
        
        return UInt64(UInt.random())
    }
    
    public static func randomInInterval(intervals: ClosedInterval<UInt64>...) -> UInt64 {
        
        return randomInInterval(intervals)
    }
    
    public static func randomInInterval(intervals: [ClosedInterval<UInt64>]) -> UInt64 {
        
        return UInt64(UInt.randomInInterval(intervals.map{ ClosedInterval(UInt($0.start), UInt($0.end)) }))
    }
    
    public static func randomArrayOfLength(length: Int) -> [UInt64] {
        
        var array = [UInt64](count: length, repeatedValue: 0)
        
        Random_OBJC.randomUInt64ArrayOfLength(length, inArray: &array)
        
        return array
    }
}

extension Float: Randomizable {
    
    public typealias RandomIntervalType = Float
    
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
    
    public typealias RandomIntervalType = Double
    
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
