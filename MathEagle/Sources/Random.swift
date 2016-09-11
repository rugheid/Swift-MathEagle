//
//  Random.swift
//  MathEagle
//
//  Created by Rugen Heidbuchel on 18/06/15.
//  Copyright © 2015 Jorestha Solutions. All rights reserved.
//

import Foundation

// MARK: Randomizable Protocol

public protocol RangeType: Comparable {}
extension Int: RangeType {}
extension Int8: RangeType {}
extension Int16: RangeType {}
extension Int32: RangeType {}
extension Int64: RangeType {}
extension UInt: RangeType {}
extension UInt8: RangeType {}
extension UInt16: RangeType {}
extension UInt32: RangeType {}
extension UInt64: RangeType {}
extension Float: RangeType {}
extension Double: RangeType {}
extension CGFloat: RangeType {}

public protocol CountableRangeType: Comparable, _Strideable {
    associatedtype Stride: SignedInteger
}
extension Int: CountableRangeType {}
extension Int8: CountableRangeType {}
extension Int16: CountableRangeType {}
extension Int32: CountableRangeType {}
extension Int64: CountableRangeType {}
extension UInt: CountableRangeType {}
extension UInt8: CountableRangeType {}
extension UInt16: CountableRangeType {}
extension UInt32: CountableRangeType {}
extension UInt64: CountableRangeType {}

public protocol Randomizable {
    
    associatedtype RandomRangeType: RangeType
    associatedtype RandomCountableRangeType: CountableRangeType
    static func random() -> Self
    static func randomInInterval(_ intervals: Range<RandomRangeType>...) -> Self
    static func randomInInterval(_ intervals: [Range<RandomRangeType>]) -> Self
    static func randomInInterval(_ intervals: ClosedRange<RandomRangeType>...) -> Self
    static func randomInInterval(_ intervals: [ClosedRange<RandomRangeType>]) -> Self
    static func randomInInterval(_ intervals: CountableRange<RandomCountableRangeType>...) -> Self
    static func randomInInterval(_ intervals: [CountableRange<RandomCountableRangeType>]) -> Self
    static func randomInInterval(_ intervals: CountableClosedRange<RandomCountableRangeType>...) -> Self
    static func randomInInterval(_ intervals: [CountableClosedRange<RandomCountableRangeType>]) -> Self
    static func randomArrayOfLength(_ length: Int) -> [Self]
}

public extension Randomizable {
    
    static func randomInInterval(_ intervals: Range<RandomRangeType>...) -> Self {
        return self.randomInInterval(intervals)
    }
    
    static func randomInInterval(_ intervals: ClosedRange<RandomRangeType>...) -> Self {
        return self.randomInInterval(intervals)
    }
    
    static func randomInInterval(_ intervals: CountableRange<RandomCountableRangeType>...) -> Self {
        return self.randomInInterval(intervals)
    }
    
    static func randomInInterval(_ intervals: CountableClosedRange<RandomCountableRangeType>...) -> Self {
        return self.randomInInterval(intervals)
    }
}

public extension Randomizable where RandomRangeType == RandomCountableRangeType {

    static func randomInInterval(_ intervals: [Range<RandomRangeType>]) -> Self {
        return self.randomInInterval(intervals.map({ (range) -> CountableRange<RandomCountableRangeType> in
            return CountableRange(range)
        }))
    }
    
    static func randomInInterval(_ intervals: [ClosedRange<RandomRangeType>]) -> Self {
        return self.randomInInterval(intervals.map({ (range) -> CountableClosedRange<RandomCountableRangeType> in
            return CountableClosedRange(range)
        }))
    }
}


// MARK: Implementations

extension Int: Randomizable {
    
    public typealias RandomRangeType = Int
    public typealias RandomCountableRangeType = Int
    
    public static func random() -> Int {
        
        return Int(bitPattern: UInt.random())
    }
    
    public static func randomInInterval(_ intervals: [CountableRange<Int>]) -> Int {
        
        let interval = intervals[0]
        let length = interval.count
        return interval.lowerBound + Int(UInt.randomInInterval(0 ..< UInt(length)))
    }
    
    public static func randomInInterval(_ intervals: [CountableClosedRange<Int>]) -> Int {
        
        let interval = intervals[0]
        let length = interval.count
        return interval.lowerBound + Int(UInt.randomInInterval(0 ... UInt(length-1)))
    }
    
    public static func randomArrayOfLength(_ length: Int) -> [Int] {
        
        var array = [Int](repeating: 0, count: length)
        
        Random_OBJC.randomIntArray(ofLength: length, inArray: &array)
        
        return array
    }
}

extension Int8: Randomizable {
    
    public typealias RandomRangeType = Int8
    public typealias RandomCountableRangeType = Int8
    
    public static func random() -> Int8 {
        
        return Int8(Int.randomInInterval(Range(0 ... Int(Int8.max))))
    }
    
    public static func randomInInterval(_ intervals: [CountableRange<Int8>]) -> Int8 {
        
        return Int8(Int.randomInInterval(intervals.map{ Int($0.lowerBound) ..< Int($0.upperBound) }))
    }
    
    public static func randomInInterval(_ intervals: [CountableClosedRange<Int8>]) -> Int8 {
        
        return Int8(Int.randomInInterval(intervals.map{ Int($0.lowerBound) ... Int($0.upperBound) }))
    }
    
    public static func randomArrayOfLength(_ length: Int) -> [Int8] {
        
        var array = [Int8](repeating: 0, count: length)
        
        Random_OBJC.randomInt8Array(ofLength: length, inArray: &array)
        
        return array
    }
}

extension Int16: Randomizable {
    
    public typealias RandomRangeType = Int16
    public typealias RandomCountableRangeType = Int16
    
    public static func random() -> Int16 {
        
        return Int16(Int.randomInInterval(Range(0 ... Int(Int16.max))))
    }
    
    public static func randomInInterval(_ intervals: [CountableRange<Int16>]) -> Int16 {
        
        return Int16(Int.randomInInterval(intervals.map{ Int($0.lowerBound) ..< Int($0.upperBound) }))
    }
    
    public static func randomInInterval(_ intervals: [CountableClosedRange<Int16>]) -> Int16 {
        
        return Int16(Int.randomInInterval(intervals.map{ Int($0.lowerBound) ... Int($0.upperBound) }))
    }
    
    public static func randomArrayOfLength(_ length: Int) -> [Int16] {
        
        var array = [Int16](repeating: 0, count: length)
        
        Random_OBJC.randomInt16Array(ofLength: length, inArray: &array)
        
        return array
    }
}

extension Int32: Randomizable {
    
    public typealias RandomRangeType = Int32
    public typealias RandomCountableRangeType = Int32
    
    public static func random() -> Int32 {
        
        return Int32(Int.randomInInterval(Range(0 ... Int(Int32.max))))
    }
    
    public static func randomInInterval(_ intervals: [CountableRange<Int32>]) -> Int32 {
        
        return Int32(Int.randomInInterval(intervals.map{ Int($0.lowerBound) ..< Int($0.upperBound) }))
    }
    
    public static func randomInInterval(_ intervals: [CountableClosedRange<Int32>]) -> Int32 {
        
        return Int32(Int.randomInInterval(intervals.map{ Int($0.lowerBound) ... Int($0.upperBound) }))
    }
    
    public static func randomArrayOfLength(_ length: Int) -> [Int32] {
        
        var array = [Int32](repeating: 0, count: length)
        
        Random_OBJC.randomInt32Array(ofLength: length, inArray: &array)
        
        return array
    }
}

extension Int64: Randomizable {
    
    public typealias RandomRangeType = Int64
    public typealias RandomCountableRangeType = Int64
    
    public static func random() -> Int64 {
        
        return Int64(Int.random())
    }
    
    public static func randomInInterval(_ intervals: [CountableRange<Int64>]) -> Int64 {
        
        return Int64(Int.randomInInterval(intervals.map{ Int($0.lowerBound) ..< Int($0.upperBound) }))
    }
    
    public static func randomInInterval(_ intervals: [CountableClosedRange<Int64>]) -> Int64 {
        
        return Int64(Int.randomInInterval(intervals.map{ Int($0.lowerBound) ... Int($0.upperBound) }))
    }
    
    public static func randomArrayOfLength(_ length: Int) -> [Int64] {
        
        var array = [Int64](repeating: 0, count: length)
        
        Random_OBJC.randomInt64Array(ofLength: length, inArray: &array)
        
        return array
    }
}

extension UInt: Randomizable {
    
    public typealias RandomRangeType = UInt
    public typealias RandomCountableRangeType = UInt
    
    public static func random() -> UInt {
        
        let mult = UInt(arc4random())
        return UInt(arc4random_uniform(UInt32.max)) + mult * UInt(UInt32.max)
    }
    
    public static func randomInInterval(_ intervals: [CountableRange<UInt>]) -> UInt {
        
        return self.randomInInterval(intervals.map({ (range) -> CountableClosedRange<UInt> in
            return CountableClosedRange(range)
        }))
    }
    
    public static func randomInInterval(_ intervals: [CountableClosedRange<UInt>]) -> UInt {
        
        let interval = intervals[0]
        let length = interval.upperBound - interval.lowerBound
        var random: UInt
        if length >= UInt(UInt32.max) {
            let half = UInt(arc4random_uniform(2))
            random = UInt(arc4random_uniform(UInt32(length/2))) + half * length/2
        } else {
            random = UInt(arc4random_uniform(UInt32(length + 1)))
        }
        return interval.lowerBound + random
    }
    
    public static func randomArrayOfLength(_ length: Int) -> [UInt] {
        
        var array = [UInt](repeating: 0, count: length)
        
        Random_OBJC.randomUIntArray(ofLength: length, inArray: &array)
        
        return array
    }
}

extension UInt8: Randomizable {
    
    public typealias RandomRangeType = UInt8
    public typealias RandomCountableRangeType = UInt8
    
    public static func random() -> UInt8 {
        
        return UInt8(arc4random_uniform(UInt32(UInt8.max)+1))
    }
    
    public static func randomInInterval(_ intervals: [CountableRange<UInt8>]) -> UInt8 {
        
        let interval = intervals[0]
        let length = interval.upperBound - interval.lowerBound
        let rand = UInt8(arc4random_uniform(UInt32(length)+1))
        return interval.lowerBound + rand
    }
    
    public static func randomInInterval(_ intervals: [CountableClosedRange<UInt8>]) -> UInt8 {
        
        let interval = intervals[0]
        let length = interval.upperBound - interval.lowerBound
        let rand = UInt8(arc4random_uniform(UInt32(length)+1))
        return interval.lowerBound + rand
    }
    
    public static func randomArrayOfLength(_ length: Int) -> [UInt8] {
        
        var array = [UInt8](repeating: 0, count: length)
        
        Random_OBJC.randomUInt8Array(ofLength: length, inArray: &array)
        
        return array
    }
}

extension UInt16: Randomizable {
    
    public typealias RandomRangeType = UInt16
    public typealias RandomCountableRangeType = UInt16
    
    public static func random() -> UInt16 {
        
        return UInt16(arc4random_uniform(UInt32(UInt16.max)+1))
    }
    
    public static func randomInInterval(_ intervals: [CountableRange<UInt16>]) -> UInt16 {
        
        return 0
    }
    
    public static func randomInInterval(_ intervals: [CountableClosedRange<UInt16>]) -> UInt16 {
        
        return 0
    }
    
    public static func randomArrayOfLength(_ length: Int) -> [UInt16] {
        
        var array = [UInt16](repeating: 0, count: length)
        
        Random_OBJC.randomUInt16Array(ofLength: length, inArray: &array)
        
        return array
    }
}

extension UInt32: Randomizable {
    
    public typealias RandomRangeType = UInt32
    public typealias RandomCountableRangeType = UInt32
    
    public static func random() -> UInt32 {
        
        return arc4random()
    }
    
    public static func randomInInterval(_ intervals: [CountableRange<UInt32>]) -> UInt32 {
        
        let interval = intervals[0]
        let length = interval.upperBound - interval.lowerBound
        return interval.lowerBound + arc4random_uniform(length + 1)
    }
    
    public static func randomInInterval(_ intervals: [CountableClosedRange<UInt32>]) -> UInt32 {
        
        let interval = intervals[0]
        let length = interval.upperBound - interval.lowerBound
        return interval.lowerBound + arc4random_uniform(length + 1)
    }
    
    public static func randomArrayOfLength(_ length: Int) -> [UInt32] {
        
        var array = [UInt32](repeating: 0, count: length)
        
        Random_OBJC.randomUInt32Array(ofLength: length, inArray: &array)
        
        return array
    }
}

extension UInt64: Randomizable {
    
    public typealias RandomRangeType = UInt64
    public typealias RandomCountableRangeType = UInt64
    
    public static func random() -> UInt64 {
        
        return UInt64(UInt.random())
    }
    
    public static func randomInInterval(_ intervals: [CountableRange<UInt64>]) -> UInt64 {
        
        return UInt64(UInt.randomInInterval(intervals.map{ Range(UInt($0.lowerBound) ... UInt($0.upperBound)) }))
    }
    
    public static func randomInInterval(_ intervals: [CountableClosedRange<UInt64>]) -> UInt64 {
        
        return UInt64(UInt.randomInInterval(intervals.map{ Range(UInt($0.lowerBound) ... UInt($0.upperBound)) }))
    }
    
    public static func randomArrayOfLength(_ length: Int) -> [UInt64] {
        
        var array = [UInt64](repeating: 0, count: length)
        
        Random_OBJC.randomUInt64Array(ofLength: length, inArray: &array)
        
        return array
    }
}

// TODO: Improve random implementations of Float, Double and CGFloat

extension Float: Randomizable {
    
    public typealias RandomRangeType = Float
    public typealias RandomCountableRangeType = Int
    
    public static func random() -> Float {
        
        let sign: Float = arc4random_uniform(2) == 0 ? 1 : -1
        return Float(arc4random()) * sign
    }
    
    public static func randomInInterval(_ intervals: [Range<Float>]) -> Float {
        
        let interval = intervals[0]
        let length = interval.upperBound - interval.lowerBound
        
        return interval.lowerBound + abs(random().truncatingRemainder(dividingBy: length))
    }
    
    public static func randomInInterval(_ intervals: [ClosedRange<Float>]) -> Float {
        
        let interval = intervals[0]
        let length = interval.upperBound - interval.lowerBound
        
        return interval.lowerBound + abs(random().truncatingRemainder(dividingBy: length))
    }
    
    public static func randomInInterval(_ intervals: [CountableRange<Int>]) -> Float {
        
        let interval = intervals[0]
        let length = interval.upperBound - interval.lowerBound
        
        return Float(interval.lowerBound) + abs(random().truncatingRemainder(dividingBy: Float(length)))
    }
    
    public static func randomInInterval(_ intervals: [CountableClosedRange<Int>]) -> Float {
        
        let interval = intervals[0]
        let length = interval.upperBound - interval.lowerBound
        
        return Float(interval.lowerBound) + abs(random().truncatingRemainder(dividingBy: Float(length)))
    }
    
    public static func randomArrayOfLength(_ length: Int) -> [Float] {
        
        var array = [Float](repeating: 0, count: length)
        
        Random_OBJC.randomFloatArray(ofLength: length, inArray: &array)
        
        return array
    }
}

extension Double: Randomizable {
    
    public typealias RandomRangeType = Double
    public typealias RandomCountableRangeType = Int
    
    public static func random() -> Double {
        
        let sign: Double = arc4random_uniform(2) == 0 ? 1 : -1
        return Double(arc4random()) * sign
    }
    
    public static func randomInInterval(_ intervals: [Range<Double>]) -> Double {
        
        return 0
    }
    
    public static func randomInInterval(_ intervals: [ClosedRange<Double>]) -> Double {
        
        return 0
    }
    
    public static func randomInInterval(_ intervals: [CountableRange<Int>]) -> Double {
        
        return 0
    }
    
    public static func randomInInterval(_ intervals: [CountableClosedRange<Int>]) -> Double {
        
        return 0
    }
    
    public static func randomArrayOfLength(_ length: Int) -> [Double] {
        
        var array = [Double](repeating: 0, count: length)
        
        Random_OBJC.randomDoubleArray(ofLength: length, inArray: &array)
        
        return array
    }
}

extension CGFloat: Randomizable {
    
    public typealias RandomRangeType = CGFloat
    public typealias RandomCountableRangeType = Int
    
    public static func random() -> CGFloat {
        
        let sign: CGFloat = arc4random_uniform(2) == 0 ? 1 : -1
        return CGFloat(arc4random()) * sign
    }
    
    public static func randomInInterval(_ intervals: [Range<CGFloat>]) -> CGFloat {
        
        return 0
    }
    
    public static func randomInInterval(_ intervals: [ClosedRange<CGFloat>]) -> CGFloat {
        
        return 0
    }
    
    public static func randomInInterval(_ intervals: [CountableRange<Int>]) -> CGFloat {
        
        return 0
    }
    
    public static func randomInInterval(_ intervals: [CountableClosedRange<Int>]) -> CGFloat {
        
        return 0
    }
    
    public static func randomArrayOfLength(_ length: Int) -> [CGFloat] {
        
        var array = [CGFloat](repeating: 0, count: length)
        
        for i in 0..<length {
            array[i] = random()
        }
        
        return array
    }
}
