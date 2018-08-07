//
//  Random.swift
//  MathEagle
//
//  Created by Rugen Heidbuchel on 18/06/15.
//  Copyright © 2015 Jorestha Solutions. All rights reserved.
//

import Foundation

// MARK: Randomizable Protocol

public protocol RangeType: Comparable {
    init(_ v: Int)
}
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
extension Complex: RangeType {}

public protocol CountableRangeType: Strideable where Stride: SignedInteger {
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
    static func random(_ upperBound: RandomRangeType) -> Self
    static func random(_ range: Range<RandomRangeType>) -> Self
    static func random(_ range: ClosedRange<RandomRangeType>) -> Self
    static func random(_ range: CountableRange<RandomCountableRangeType>) -> Self
    static func random(_ range: CountableClosedRange<RandomCountableRangeType>) -> Self
    static func randomArray(_ length: Int, upperBound: RandomRangeType) -> [Self]
    static func randomArray(_ length: Int, range: Range<RandomRangeType>) -> [Self]
    static func randomArray(_ length: Int, range: ClosedRange<RandomRangeType>) -> [Self]
}

public extension Randomizable {
    // The idea is to immitate "random(_ upperBound: RandomRangeType = 1)
    // Unfortunately, Swift doesn't allow optional values in protocols.
    // RandomRangeType.self.init is available because init is declared
    // in protocol RangeType .
    static func random() -> Self {
        return random(RandomRangeType.self.init(1))
    }
    static func randomArray(_ length: Int) -> [Self] {
        if (RandomRangeType.self==Complex.self) {
            // Elements from square [0,1] x [0,1]*i
            return Complex.randomArray(length, upperBound:Complex(1.0,1.0)) as! [Self]
        } else {
            // Elements from interval [0,1]
            return randomArray(length, upperBound:RandomRangeType.self.init(1))
        }
    }
}

public extension Randomizable where RandomRangeType == RandomCountableRangeType {
    static func random(_ range: Range<RandomRangeType>) -> Self {
        return self.random(CountableRange(range))
    }
    static func random(_ range: ClosedRange<RandomRangeType>) -> Self {
        return self.random(CountableClosedRange(range))
    }
    static func randomArray(_ length: Int, range: CountableRange<RandomRangeType>) -> [Self] {
        return self.randomArray(length, range:Range(range))
    }
    static func randomArray(_ length: Int, range: CountableClosedRange<RandomRangeType>) -> [Self] {
        return self.randomArray(length, range:ClosedRange(range))
    }
}


// MARK: Implementations
// We don't use Int range.count because it doesn't work for ranges over
// 64 bit integers.  We compute our own "delta"s instead.

extension Int: Randomizable {
    
    public typealias RandomRangeType = Int
    public typealias RandomCountableRangeType = Int
    
    public static func random(_ upperBound: RandomRangeType) -> Int {
        let sign=Int((upperBound<0) ? -1 : 1)
        let x=UInt(abs(upperBound))
        return sign*Int(UInt.random(x))
    }
    
    public static func random(_ range: CountableRange<Int>) -> Int {
        let delta = range.upperBound-range.lowerBound
        return range.lowerBound + Int(UInt.random(0 ..< UInt(delta)))
    }
    
    public static func random(_ range: CountableClosedRange<Int>) -> Int {
        let delta = range.upperBound-range.lowerBound
        return range.lowerBound + Int(UInt.random(0 ... UInt(delta)))
    }
    
    public static func randomArray(_ length: Int, upperBound: Int) -> [Int] {
        var array = [Int](repeating: 0, count: length)
        Random_OBJC.randomIntArray(length, lowerBound: 0, upperBound: upperBound, closed: true, inArray: &array)
        return array
    }

    public static func randomArray(_ length: Int, range: Range<RandomRangeType>) -> [Int] {
        var array = [Int](repeating: 0, count: length)
        Random_OBJC.randomIntArray(length, lowerBound: range.lowerBound, upperBound: range.upperBound, closed: false, inArray: &array)
        return array
    }
    
    public static func randomArray(_ length: Int, range: ClosedRange<RandomRangeType>) -> [Int] {
        var array = [Int](repeating: 0, count: length)
        Random_OBJC.randomIntArray(length, lowerBound: range.lowerBound, upperBound: range.upperBound, closed: true, inArray: &array)
        return array
    }

}

extension Int8: Randomizable {
    
    public typealias RandomRangeType = Int8
    public typealias RandomCountableRangeType = Int8
    
    public static func random(_ upperBound: RandomRangeType) -> Int8 {
        let sign=Int8((upperBound<0) ? -1 : 1)
        let x=UInt8(abs(upperBound))
        return sign*Int8(UInt8.random(x))
    }
    
    public static func random(_ range: CountableRange<Int8>) -> Int8 {
        return Int8(Int.random(Int(range.lowerBound) ..< Int(range.upperBound)))
    }
    
    public static func random(_ range: CountableClosedRange<Int8>) -> Int8 {
        return Int8(Int.random(Int(range.lowerBound) ... Int(range.upperBound)))
    }
    
    public static func randomArray(_ length: Int, upperBound: Int8) -> [Int8] {
        var array = [Int8](repeating: 0, count: length)
        Random_OBJC.randomInt8Array(length, lowerBound: 0, upperBound: upperBound, closed: true, inArray: &array)
        return array
    }

    public static func randomArray(_ length: Int, range: Range<RandomRangeType>) -> [Int8] {
        var array = [Int8](repeating: 0, count: length)
        Random_OBJC.randomInt8Array(length, lowerBound: range.lowerBound, upperBound: range.upperBound, closed: false, inArray: &array)
        return array
    }
    
    public static func randomArray(_ length: Int, range: ClosedRange<RandomRangeType>) -> [Int8] {
        var array = [Int8](repeating: 0, count: length)
        Random_OBJC.randomInt8Array(length, lowerBound: range.lowerBound, upperBound: range.upperBound, closed: true, inArray: &array)
        return array
    }

}

extension Int16: Randomizable {
    
    public typealias RandomRangeType = Int16
    public typealias RandomCountableRangeType = Int16
    
    public static func random(_ upperBound: RandomRangeType) -> Int16 {
        let sign=Int16((upperBound<0) ? -1 : 1)
        let x=UInt16(abs(upperBound))
        return sign*Int16(UInt16.random(x))
    }
    
    public static func random(_ range: CountableRange<Int16>) -> Int16 {
        return Int16(Int.random(Int(range.lowerBound) ..< Int(range.upperBound)))
    }
    
    public static func random(_ range: CountableClosedRange<Int16>) -> Int16 {
        return Int16(Int.random(Int(range.lowerBound) ... Int(range.upperBound)))
    }
    
    public static func randomArray(_ length: Int, upperBound: Int16) -> [Int16] {
        var array = [Int16](repeating: 0, count: length)
        Random_OBJC.randomInt16Array(length, lowerBound: 0, upperBound: upperBound, closed: true, inArray: &array)
        return array
    }

    public static func randomArray(_ length: Int, range: Range<RandomRangeType>) -> [Int16] {
        var array = [Int16](repeating: 0, count: length)
        Random_OBJC.randomInt16Array(length, lowerBound: range.lowerBound, upperBound: range.upperBound, closed: false, inArray: &array)
        return array
    }
    
    public static func randomArray(_ length: Int, range: ClosedRange<RandomRangeType>) -> [Int16] {
        var array = [Int16](repeating: 0, count: length)
        Random_OBJC.randomInt16Array(length, lowerBound: range.lowerBound, upperBound: range.upperBound, closed: true, inArray: &array)
        return array
    }
}

extension Int32: Randomizable {
    
    public typealias RandomRangeType = Int32
    public typealias RandomCountableRangeType = Int32
    
    public static func random(_ upperBound: RandomRangeType) -> Int32 {
        let sign=Int32((upperBound<0) ? -1 : 1)
        let x=UInt32(abs(upperBound))
        return sign*Int32(UInt32.random(x))
    }
    
    public static func random(_ range: CountableRange<Int32>) -> Int32 {
        return Int32(Int.random(Int(range.lowerBound) ..< Int(range.upperBound)))
    }
    
    public static func random(_ range: CountableClosedRange<Int32>) -> Int32 {
        return Int32(Int.random(Int(range.lowerBound) ... Int(range.upperBound)))
    }
    
    public static func randomArray(_ length: Int, upperBound: Int32) -> [Int32] {
        var array = [Int32](repeating: 0, count: length)
        Random_OBJC.randomInt32Array(length, lowerBound: 0, upperBound: upperBound, closed: true, inArray: &array)
        return array
    }

    public static func randomArray(_ length: Int, range: Range<RandomRangeType>) -> [Int32] {
        var array = [Int32](repeating: 0, count: length)
        Random_OBJC.randomInt32Array(length, lowerBound: range.lowerBound, upperBound: range.upperBound, closed: false, inArray: &array)
        return array
    }
    
    public static func randomArray(_ length: Int, range: ClosedRange<RandomRangeType>) -> [Int32] {
        var array = [Int32](repeating: 0, count: length)
        Random_OBJC.randomInt32Array(length, lowerBound: range.lowerBound, upperBound: range.upperBound, closed: true, inArray: &array)
        return array
    }
}

extension Int64: Randomizable {
    
    public typealias RandomRangeType = Int64
    public typealias RandomCountableRangeType = Int64
    
    public static func random(_ upperBound: RandomRangeType) -> Int64 {
        let sign=Int64((upperBound<0) ? -1 : 1)
        let x=UInt64(abs(upperBound))
        return sign*Int64(UInt64.random(x))
    }
    
    public static func random(_ range: CountableRange<Int64>) -> Int64 {
        return Int64(Int.random(Int(range.lowerBound) ..< Int(range.upperBound)))
    }
    
    public static func random(_ range: CountableClosedRange<Int64>) -> Int64 {
        return Int64(Int.random(Int(range.lowerBound) ... Int(range.upperBound)))
    }
    
    public static func randomArray(_ length: Int, upperBound: Int64) -> [Int64] {
        var array = [Int64](repeating: 0, count: length)
        Random_OBJC.randomInt64Array(length, lowerBound: 0, upperBound: upperBound, closed: true, inArray: &array)
        return array
    }

    public static func randomArray(_ length: Int, range: Range<RandomRangeType>) -> [Int64] {
        var array = [Int64](repeating: 0, count: length)
        Random_OBJC.randomInt64Array(length, lowerBound: range.lowerBound, upperBound: range.upperBound, closed: false, inArray: &array)
        return array
    }
    
    public static func randomArray(_ length: Int, range: ClosedRange<RandomRangeType>) -> [Int64] {
        var array = [Int64](repeating: 0, count: length)
        Random_OBJC.randomInt64Array(length, lowerBound: range.lowerBound, upperBound: range.upperBound, closed: true, inArray: &array)
        return array
    }
}

extension UInt: Randomizable {
    
    public typealias RandomRangeType = UInt
    public typealias RandomCountableRangeType = UInt
    
    public static func random(_ upperBound: UInt) -> UInt {
        // On 32-bit platforms, UInt is the same size as UInt32, and on
        // 64-bit platforms, UInt is the same size as UInt64.
        return UInt(Int64.random(Int64(upperBound)))
    }
    
    public static func random(_ range: CountableRange<UInt>) -> UInt {
        return self.random(CountableClosedRange(range))
    }
    
    public static func random(_ range: CountableClosedRange<UInt>) -> UInt {
        let length = range.upperBound - range.lowerBound
        var random: UInt
        if length >= UInt(UInt32.max) {
            let half = UInt(arc4random_uniform(2))
            random = UInt(arc4random_uniform(UInt32(length/2))) + half * length/2
        } else {
            random = UInt(arc4random_uniform(UInt32(length + 1)))
        }
        return range.lowerBound + random
    }
    
    public static func randomArray(_ length: Int, upperBound: UInt) -> [UInt] {
        var array = [UInt](repeating: 0, count: length)
        Random_OBJC.randomUIntArray(length, lowerBound: 0, upperBound: upperBound, closed: true, inArray: &array)
        return array
    }

    public static func randomArray(_ length: Int, range: Range<RandomRangeType>) -> [UInt] {
        var array = [UInt](repeating: 0, count: length)
        Random_OBJC.randomUIntArray(length, lowerBound: range.lowerBound, upperBound: range.upperBound, closed: false, inArray: &array)
        return array
    }
    
    public static func randomArray(_ length: Int, range: ClosedRange<RandomRangeType>) -> [UInt] {
        var array = [UInt](repeating: 0, count: length)
        Random_OBJC.randomUIntArray(length, lowerBound: range.lowerBound, upperBound: range.upperBound, closed: true, inArray: &array)
        return array
    }
}

extension UInt8: Randomizable {
    
    public typealias RandomRangeType = UInt8
    public typealias RandomCountableRangeType = UInt8
    
    public static func random(_ upperBound: UInt8) -> UInt8 {
        return UInt8(arc4random_uniform(UInt32(upperBound+1)))
    }
    
    public static func random(_ range: CountableRange<UInt8>) -> UInt8 {
        let delta = range.upperBound-range.lowerBound
        // Swift runtime precludes delta<0 .
        if (delta==0) {
            // The half-open range is empty.  Error or return best answer.
            return range.lowerBound
        }
        let offset = UInt8(arc4random_uniform(UInt32(delta)))
        return range.lowerBound+offset
    }
    
    public static func random(_ range: CountableClosedRange<UInt8>) -> UInt8 {
        let delta = range.upperBound-range.lowerBound
        let offset = UInt8(arc4random_uniform(UInt32(delta+1)))
        return range.lowerBound+offset
    }
    
    public static func randomArray(_ length: Int, upperBound: UInt8) -> [UInt8] {
        var array = [UInt8](repeating: 0, count: length)
        Random_OBJC.randomUInt8Array(length, lowerBound: 0, upperBound: upperBound, closed: true, inArray: &array)
        return array
    }

    public static func randomArray(_ length: Int, range: Range<RandomRangeType>) -> [UInt8] {
        var array = [UInt8](repeating: 0, count: length)
        Random_OBJC.randomUInt8Array(length, lowerBound: range.lowerBound, upperBound: range.upperBound, closed: false, inArray: &array)
        return array
    }
    
    public static func randomArray(_ length: Int, range: ClosedRange<RandomRangeType>) -> [UInt8] {
        var array = [UInt8](repeating: 0, count: length)
        Random_OBJC.randomUInt8Array(length, lowerBound: range.lowerBound, upperBound: range.upperBound, closed: true, inArray: &array)
        return array
    }
}

extension UInt16: Randomizable {
    
    public typealias RandomRangeType = UInt16
    public typealias RandomCountableRangeType = UInt16
    
    public static func random(_ upperBound: UInt16) -> UInt16 {
        return UInt16(arc4random_uniform(UInt32(upperBound+1)))
    }
    
    public static func random(_ range: CountableRange<UInt16>) -> UInt16 {
        let delta = range.upperBound-range.lowerBound
        // Swift runtime precludes delta<0 .
        if (delta==0) {
            // The half-open range is empty.  Error or return best answer.
            return range.lowerBound
        }
        let offset = UInt16(arc4random_uniform(UInt32(delta)))
        return range.lowerBound+offset
    }
    
    public static func random(_ range: CountableClosedRange<UInt16>) -> UInt16 {
        let delta = range.upperBound-range.lowerBound
        let offset = UInt16(arc4random_uniform(UInt32(delta+1)))
        return range.lowerBound+offset
    }

    public static func randomArray(_ length: Int, upperBound: UInt16) -> [UInt16] {
        var array = [UInt16](repeating: 0, count: length)
        Random_OBJC.randomUInt16Array(length, lowerBound: 0, upperBound: upperBound, closed: true, inArray: &array)
        return array
    }

    public static func randomArray(_ length: Int, range: Range<RandomRangeType>) -> [UInt16] {
        var array = [UInt16](repeating: 0, count: length)
        Random_OBJC.randomUInt16Array(length, lowerBound: range.lowerBound, upperBound: range.upperBound, closed: false, inArray: &array)
        return array
    }
    
    public static func randomArray(_ length: Int, range: ClosedRange<RandomRangeType>) -> [UInt16] {
        var array = [UInt16](repeating: 0, count: length)
        Random_OBJC.randomUInt16Array(length, lowerBound: range.lowerBound, upperBound: range.upperBound, closed: true, inArray: &array)
        return array
    }
}

extension UInt32: Randomizable {
    
    public typealias RandomRangeType = UInt32
    public typealias RandomCountableRangeType = UInt32
    
    public static func random(_ upperBound: UInt32) -> UInt32 {
        if upperBound == UInt32.max {
            return arc4random()
        } else {
            return arc4random_uniform(upperBound+1)
        }
    }
    
    public static func random(_ range: CountableRange<UInt32>) -> UInt32 {
        let delta = range.upperBound-range.lowerBound
        // Swift runtime precludes delta<0 .
        if (delta==0) {
            // The half-open range is empty.  Error or return best answer.
            return range.lowerBound
        }
        let offset = UInt32(arc4random_uniform(UInt32(delta)))
        return range.lowerBound+offset
    }
    
    public static func random(_ range: CountableClosedRange<UInt32>) -> UInt32 {
        let delta = range.upperBound-range.lowerBound
        let offset = UInt32(arc4random_uniform(UInt32(delta+1)))
        return range.lowerBound+offset
    }

    public static func randomArray(_ length: Int, upperBound: UInt32) -> [UInt32] {
        var array = [UInt32](repeating: 0, count: length)
        Random_OBJC.randomUInt32Array(length, lowerBound: 0, upperBound: upperBound, closed: true, inArray: &array)
        return array
    }

    public static func randomArray(_ length: Int, range: Range<RandomRangeType>) -> [UInt32] {
        var array = [UInt32](repeating: 0, count: length)
        Random_OBJC.randomUInt32Array(length, lowerBound: range.lowerBound, upperBound: range.upperBound, closed: false, inArray: &array)
        return array
    }
    
    public static func randomArray(_ length: Int, range: ClosedRange<RandomRangeType>) -> [UInt32] {
        var array = [UInt32](repeating: 0, count: length)
        Random_OBJC.randomUInt32Array(length, lowerBound: range.lowerBound, upperBound: range.upperBound, closed: true, inArray: &array)
        return array
    }
}

extension UInt64: Randomizable {
    
    public typealias RandomRangeType = UInt64
    public typealias RandomCountableRangeType = UInt64
    
    public static func random(_ upperBound: UInt64) -> UInt64 {
        if upperBound<UInt32.max {
            return UInt64(UInt32.random(UInt32(upperBound)))
        } else {
            // limit divisble by upperBound to avoid modulo bias
            let limit = UInt64.max-UInt64.max%upperBound
            // Discover n<limit
            var n:UInt64 = 0
            repeat {
                arc4random_buf(&n, MemoryLayout.size(ofValue:n))
            } while n>=limit
            // Return answer < upperBound
            return n % upperBound
        }
    }
    
    public static func random(_ range: CountableRange<UInt64>) -> UInt64 {
        let delta = range.upperBound-range.lowerBound
        // Swift runtime precludes delta<0 .
        if (delta==0) {
            // The half-open range is empty.  Error or return best answer.
            return range.lowerBound
        }
        let offset = random(UInt64(delta-1))
        return range.lowerBound+offset
    }
    
    public static func random(_ range: CountableClosedRange<UInt64>) -> UInt64 {
        let delta = range.upperBound-range.lowerBound
        let offset = random(UInt64(delta))
        return range.lowerBound+offset
    }

    public static func randomArray(_ length: Int, upperBound: UInt64) -> [UInt64] {
        var array = [UInt64](repeating: 0, count: length)
        Random_OBJC.randomUInt64Array(length, lowerBound: 0, upperBound: upperBound, closed: true, inArray: &array)
        return array
    }

    public static func randomArray(_ length: Int, range: Range<RandomRangeType>) -> [UInt64] {
        var array = [UInt64](repeating: 0, count: length)
        Random_OBJC.randomUInt64Array(length, lowerBound: range.lowerBound, upperBound: range.upperBound, closed: false, inArray: &array)
        return array
    }
    
    public static func randomArray(_ length: Int, range: ClosedRange<RandomRangeType>) -> [UInt64] {
        var array = [UInt64](repeating: 0, count: length)
        Random_OBJC.randomUInt64Array(length, lowerBound: range.lowerBound, upperBound: range.upperBound, closed: true, inArray: &array)
        return array
    }
}

extension Float: Randomizable {
    
    public typealias RandomRangeType = Float
    public typealias RandomCountableRangeType = Int
    
    public static func random(_ upperBound: Float) -> Float {
        return Float(arc4random())/Float(UInt32.max)*upperBound
    }
    
    public static func random(_ range: Range<Float>) -> Float {
        let lowerBound=range.lowerBound
        let upperBound=range.upperBound
        let delta = upperBound-lowerBound
        while true {
            let answer = lowerBound+Float.random()*delta
            if (lowerBound<=answer)&&(answer<upperBound) {
                return answer;
            }
        }
    }
    
    public static func random(_ range: ClosedRange<Float>) -> Float {
        let lowerBound=range.lowerBound
        let upperBound=range.upperBound
        let delta = upperBound-lowerBound
        while true {
            let answer = lowerBound+Float.random()*delta
            if (lowerBound<=answer)&&(answer<=upperBound) {
                return answer;
            }
        }
    }

    public static func random(_ range: CountableRange<Int>) -> Float {
        return random(Float(range.lowerBound)..<Float(range.upperBound))
    }
    
    public static func random(_ range: CountableClosedRange<Int>) -> Float {
        return random(Float(range.lowerBound)...Float(range.upperBound))
    }
    
    public static func randomArray(_ length: Int, upperBound: Float) -> [Float] {
        var array = [Float](repeating: 0, count: length)
        Random_OBJC.randomFloatArray(length, lowerBound: 0.0, upperBound: upperBound, closed: true, inArray: &array)
        return array
    }

    public static func randomArray(_ length: Int, range: Range<RandomRangeType>) -> [Float] {
        var array = [Float](repeating: 0, count: length)
        Random_OBJC.randomFloatArray(length, lowerBound: range.lowerBound, upperBound: range.upperBound, closed: false, inArray: &array)
        return array
    }
    
    public static func randomArray(_ length: Int, range: ClosedRange<RandomRangeType>) -> [Float] {
        var array = [Float](repeating: 0, count: length)
        Random_OBJC.randomFloatArray(length, lowerBound: range.lowerBound, upperBound: range.upperBound, closed: true, inArray: &array)
        return array
    }
}

extension Double: Randomizable {
    
    public typealias RandomRangeType = Double
    public typealias RandomCountableRangeType = Int
    
    public static func random(_ upperBound: Double) -> Double {
        return Double(arc4random())/Double(UInt32.max)*upperBound
    }
    
    public static func random(_ range: Range<Double>) -> Double {
        let lowerBound=range.lowerBound
        let upperBound=range.upperBound
        let delta = upperBound-lowerBound
        while true {
            let answer = lowerBound+Double.random()*delta
            if (lowerBound<=answer)&&(answer<upperBound) {
                return answer;
            }
        }
    }
    
    public static func random(_ range: ClosedRange<Double>) -> Double {
        let lowerBound=range.lowerBound
        let upperBound=range.upperBound
        let delta = upperBound-lowerBound
        while true {
            let answer = lowerBound+Double.random()*delta
            if (lowerBound<=answer)&&(answer<=upperBound) {
                return answer;
            }
        }
    }
    
    public static func random(_ range: CountableRange<Int>) -> Double {
        return random(Double(range.lowerBound)..<Double(range.upperBound))
    }
    
    public static func random(_ range: CountableClosedRange<Int>) -> Double {
        return random(Double(range.lowerBound)...Double(range.upperBound))
    }
    
    public static func randomArray(_ length: Int, upperBound: Double) -> [Double] {
        var array = [Double](repeating: 0, count: length)
        Random_OBJC.randomDoubleArray(length, lowerBound: 0.0, upperBound: upperBound, closed: true, inArray: &array)
        return array
    }

    public static func randomArray(_ length: Int, range: Range<RandomRangeType>) -> [Double] {
        var array = [Double](repeating: 0, count: length)
        Random_OBJC.randomDoubleArray(length, lowerBound: range.lowerBound, upperBound: range.upperBound, closed: false, inArray: &array)
        return array
    }
    
    public static func randomArray(_ length: Int, range: ClosedRange<RandomRangeType>) -> [Double] {
        var array = [Double](repeating: 0, count: length)
        Random_OBJC.randomDoubleArray(length, lowerBound: range.lowerBound, upperBound: range.upperBound, closed: true, inArray: &array)
        return array
    }
}

extension CGFloat: Randomizable {
    
    public typealias RandomRangeType = CGFloat
    public typealias RandomCountableRangeType = Int
    
    public static func random(_ upperBound: CGFloat) -> CGFloat {
        return CGFloat(arc4random())/CGFloat(UInt32.max)*upperBound
    }
    
    public static func random(_ range: Range<CGFloat>) -> CGFloat {
        let lowerBound=range.lowerBound
        let upperBound=range.upperBound
        let delta = upperBound-lowerBound
        while true {
            let answer = lowerBound+CGFloat.random()*delta
            if (lowerBound<=answer)&&(answer<upperBound) {
                return answer;
            }
        }
    }
    
    public static func random(_ range: ClosedRange<CGFloat>) -> CGFloat {
        let lowerBound=range.lowerBound
        let upperBound=range.upperBound
        let delta = upperBound-lowerBound
        while true {
            let answer = lowerBound+CGFloat.random()*delta
            if (lowerBound<=answer)&&(answer<=upperBound) {
                return answer;
            }
        }
    }

    public static func random(_ range: CountableRange<Int>) -> CGFloat {
        return random(CGFloat(range.lowerBound)..<CGFloat(range.upperBound))
    }
    
    public static func random(_ range: CountableClosedRange<Int>) -> CGFloat {
        return random(CGFloat(range.lowerBound)...CGFloat(range.upperBound))
    }

    public static func randomArray(_ length: Int, upperBound: CGFloat) -> [CGFloat] {
        var array = [CGFloat](repeating: 0, count: length)
        Random_OBJC.randomCGFloatArray(length, lowerBound: 0.0, upperBound: upperBound, closed: true, inArray: &array)
        return array
    }
    
    public static func randomArray(_ length: Int, range: Range<RandomRangeType>) -> [CGFloat] {
        var array = [CGFloat](repeating: 0, count: length)
        Random_OBJC.randomCGFloatArray(length, lowerBound: range.lowerBound, upperBound: range.upperBound, closed: false, inArray: &array)
        return array
    }
    
    public static func randomArray(_ length: Int, range: ClosedRange<RandomRangeType>) -> [CGFloat] {
        var array = [CGFloat](repeating: 0, count: length)
        Random_OBJC.randomCGFloatArray(length, lowerBound: range.lowerBound, upperBound: range.upperBound, closed: true, inArray: &array)
        return array
    }

    #if false
    public static func randomArray(_ length: Int, upperBound: CGFloat) -> [CGFloat] {
        var array = [CGFloat](repeating: 0, count: length)
        for i in 0..<length {
            array[i] = random(upperBound)
        }
        return array
    }
    
    public static func randomArray(_ length: Int, range: Range<RandomRangeType>) -> [CGFloat] {
        var array = [CGFloat](repeating: 0, count: length)
        for i in 0..<length {
            array[i] = random(range)
        }
        return array
    }
    
    public static func randomArray(_ length: Int, range: ClosedRange<RandomRangeType>) -> [CGFloat] {
        var array = [CGFloat](repeating: 0, count: length)
        for i in 0..<length {
            array[i] = random(range)
        }
        return array
    }
    #endif
}
