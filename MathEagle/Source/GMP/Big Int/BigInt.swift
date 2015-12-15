//
//  BigInt.swift
//  MathEagle
//
//  Created by Rugen Heidbuchel on 13/12/15.
//  Copyright © 2015 Jorestha Solutions. All rights reserved.
//

import Foundation

public struct BigInt: Equatable, Comparable, Addable, Negatable, Subtractable, CustomStringConvertible {
    
    
    // MARK: Private Properties
    
    var bigIntOBJC: BigInt_OBJC
    
    
    // MARK: Initialisers
    
    public init() {
        bigIntOBJC = BigInt_OBJC()
    }
    
    public init(bigInt: BigInt) {
        bigIntOBJC = BigInt_OBJC(bigIntOBJC: bigInt.bigIntOBJC)
    }
    
    public init(int: Int) {
        bigIntOBJC = BigInt_OBJC(long: int)
    }
    
    public init(uint: UInt) {
        bigIntOBJC = BigInt_OBJC(unsignedLong: uint)
    }
    
    public init(double: Double) {
        bigIntOBJC = BigInt_OBJC(double: double)
    }
    
    public init(string: String, base: Int32 = 10) {
        bigIntOBJC = BigInt_OBJC(string: string.cStringUsingEncoding(NSUTF8StringEncoding)!, inBase: base)
    }
    
    
    // MARK: Properties
    
    /**
    Returns the string value of the number in base 10.
    */
    public var description: String {
        return self.stringValue
    }
    
    
    // MARK: Conversions
    
    /**
    Returns the int value of the number. When the number is too big to represent as an Int,
    the Int formed by using the lower significant bits is returned.
    */
    public var intValue: Int {
        return self.bigIntOBJC.getLongValue()
    }
    
    /**
     Returns the unsigned int value of the number. When the number is too big to represent as a UInt,
     the UInt formed by using the lower significant bits is returned. The sign of the number is ignored.
     */
    public var uintValue: UInt {
        return self.bigIntOBJC.getUnsignedLongValue()
    }
    
    /**
     Returns the double value of the number. When the number can not be represented as a Double,
     the number is rounded towards zero. Inf is returned if it's too big.
     */
    public var doubleValue: Double {
        return self.bigIntOBJC.getDoubleValue()
    }
    
    /**
     Returns the string value of the number in base 10.
     */
    public var stringValue: String {
        return stringValue()
    }
    
    /**
     Returns the string value of the number in the given base.
     - parameter base: The base in which to express the string. 10 is the default value. When 0 or 1 is passed, 10 will
        be used as well. Negative values are converted to their absolute value.
     */
    public func stringValue(base: Int32 = 10) -> String {
        return String(CString: self.bigIntOBJC.getStringValueInBase(base), encoding: NSUTF8StringEncoding)!
    }
    
    
    // MARK: Comparisons
    
    public func compare(bigInt: BigInt) -> NSComparisonResult {
        let cmp = self.bigIntOBJC.compareWithBigIntOBJC(bigInt.bigIntOBJC)
        if cmp < 0 {
            return .OrderedAscending
        } else if cmp > 0 {
            return .OrderedDescending
        } else {
            return .OrderedSame
        }
    }
    
    
    // MARK: Operations
    
    public func add(bigInt: BigInt) -> BigInt {
        let result = BigInt()
        BigInt_OBJC.set(result.bigIntOBJC, toSumOf: self.bigIntOBJC, and: bigInt.bigIntOBJC)
        return result
    }
    
    public mutating func addInPlace(bigInt: BigInt) {
        BigInt_OBJC.set(self.bigIntOBJC, toSumOf: self.bigIntOBJC, and: bigInt.bigIntOBJC)
    }
    
    public var negation: BigInt {
        let result = BigInt()
        BigInt_OBJC.set(result.bigIntOBJC, toNegationOf: self.bigIntOBJC)
        return result
    }
    
    public mutating func negateInPlace() {
        BigInt_OBJC.set(self.bigIntOBJC, toNegationOf: self.bigIntOBJC)
    }
    
    public func subtract(bigInt: BigInt) -> BigInt {
        let result = BigInt()
        BigInt_OBJC.set(result.bigIntOBJC, toDifferenceOf: self.bigIntOBJC, and: bigInt.bigIntOBJC)
        return result
    }
    
    public mutating func subtractInPlace(bigInt: BigInt) {
        BigInt_OBJC.set(self.bigIntOBJC, toDifferenceOf: self.bigIntOBJC, and: bigInt.bigIntOBJC)
    }
}


// MARK: Equatable

public func == (left: BigInt, right: BigInt) -> Bool {
    return left.compare(right) == .OrderedSame
}


// MARK: Comparable

public func < (left: BigInt, right: BigInt) -> Bool {
    return left.compare(right) == .OrderedAscending
}

public func > (left: BigInt, right: BigInt) -> Bool {
    return left.compare(right) == .OrderedDescending
}


// MARK: Addable

public func + (left: BigInt, right: BigInt) -> BigInt {
    return left.add(right)
}

public func += (inout left: BigInt, right: BigInt) {
    left.addInPlace(right)
}


// MARK: Negatable

public prefix func - (bigInt: BigInt) -> BigInt {
    return bigInt.negation
}


// MARK: Subtractable

public func - (left: BigInt, right: BigInt) -> BigInt {
    return left.subtract(right)
}

public func -= (inout left: BigInt, right: BigInt) {
    left.subtractInPlace(right)
}
