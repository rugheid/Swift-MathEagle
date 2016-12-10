//
//  BigInt.swift
//  MathEagle
//
//  Created by Rugen Heidbuchel on 13/12/15.
//  Copyright © 2015 Jorestha Solutions. All rights reserved.
//

import Foundation

public struct BigInt: Equatable, Comparable, Addable, Negatable, Subtractable, Multiplicable, Dividable, SetCompliant, CustomStringConvertible, Hashable, ExpressibleByIntegerLiteral {
    
    
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
    
    public init(integerLiteral value: IntegerLiteralType) {
        bigIntOBJC = BigInt_OBJC(long: value)
    }
    
    public init(uint: UInt) {
        bigIntOBJC = BigInt_OBJC(unsignedLong: uint)
    }
    
    public init(double: Double) {
        bigIntOBJC = BigInt_OBJC(double: double)
    }
    
    public init(string: String, base: Int32 = 10) {
        bigIntOBJC = BigInt_OBJC(string: string.cString(using: String.Encoding.utf8)!, inBase: base)
    }
    
    
    // MARK: Properties
    
    /**
     Returns the string value of the number in base 10.
     */
    public var description: String {
        return self.stringValue
    }
    
    /**
     Returns the hash value of the number.
     */
    public var hashValue: Int {
        return self.intValue.hashValue
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
    public func stringValue(_ base: Int32 = 10) -> String {
        return String(cString: self.bigIntOBJC.getStringValue(inBase: base), encoding: String.Encoding.utf8)!
    }
    
    
    // MARK: Comparisons
    
    public func compare(_ bigInt: BigInt) -> ComparisonResult {
        let cmp = self.bigIntOBJC.compare(withBigIntOBJC: bigInt.bigIntOBJC)
        if cmp < 0 {
            return .orderedAscending
        } else if cmp > 0 {
            return .orderedDescending
        } else {
            return .orderedSame
        }
    }
    
    
    // MARK: Operations
    
    public func add(_ bigInt: BigInt) -> BigInt {
        let result = BigInt()
        BigInt_OBJC.set(result.bigIntOBJC, toSumOf: self.bigIntOBJC, and: bigInt.bigIntOBJC)
        return result
    }
    
    public mutating func addInPlace(_ bigInt: BigInt) {
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
    
    public func subtract(_ bigInt: BigInt) -> BigInt {
        let result = BigInt()
        BigInt_OBJC.set(result.bigIntOBJC, toDifferenceOf: self.bigIntOBJC, and: bigInt.bigIntOBJC)
        return result
    }
    
    public mutating func subtractInPlace(_ bigInt: BigInt) {
        BigInt_OBJC.set(self.bigIntOBJC, toDifferenceOf: self.bigIntOBJC, and: bigInt.bigIntOBJC)
    }
    
    public func multiply(_ bigInt: BigInt) -> BigInt {
        let result = BigInt()
        BigInt_OBJC.set(result.bigIntOBJC, toProductOf: self.bigIntOBJC, and: bigInt.bigIntOBJC)
        return result
    }
    
    public mutating func multiplyInPlace(_ bigInt: BigInt) {
        BigInt_OBJC.set(self.bigIntOBJC, toProductOf: self.bigIntOBJC, and: bigInt.bigIntOBJC)
    }
    
    public func divide(_ bigInt: BigInt) -> BigInt {
        let result = BigInt()
        BigInt_OBJC.set(result.bigIntOBJC, toQuotientOf: self.bigIntOBJC, and: bigInt.bigIntOBJC)
        return result
    }
    
    public mutating func divideInPlace(_ bigInt: BigInt) {
        BigInt_OBJC.set(self.bigIntOBJC, toQuotientOf: self.bigIntOBJC, and: bigInt.bigIntOBJC)
    }
    
    public var absoluteValue: BigInt {
        let result = BigInt()
        BigInt_OBJC.set(result.bigIntOBJC, toAbsoluteValueOf: self.bigIntOBJC)
        return result
    }
    
    public mutating func absoluteValueInPlace() {
        BigInt_OBJC.set(self.bigIntOBJC, toAbsoluteValueOf: self.bigIntOBJC)
    }
    
    public var squareRoot: BigInt {
        let result = BigInt()
        BigInt_OBJC.set(result.bigIntOBJC, toSquareRootOf: self.bigIntOBJC)
        return result
    }
    
    public mutating func squareRootInPlace() {
        BigInt_OBJC.set(self.bigIntOBJC, toSquareRootOf: self.bigIntOBJC)
    }
    
    public func power(_ bigInt: BigInt, modulo: BigInt) -> BigInt {
        let result = BigInt()
        BigInt_OBJC.set(result.bigIntOBJC, toPowerOf: self.bigIntOBJC, and: bigInt.bigIntOBJC, modulo: modulo.bigIntOBJC)
        return result
    }
    
    public mutating func powerInPlace(_ bigInt: BigInt, modulo: BigInt) {
        BigInt_OBJC.set(self.bigIntOBJC, toPowerOf: self.bigIntOBJC, and: bigInt.bigIntOBJC, modulo: modulo.bigIntOBJC)
    }
    
    public func power(_ uint: UInt) -> BigInt {
        let result = BigInt()
        BigInt_OBJC.set(result.bigIntOBJC, toPowerOf: self.bigIntOBJC, and: uint)
        return result
    }
    
    public mutating func powerInPlace(_ uint: UInt) {
        BigInt_OBJC.set(self.bigIntOBJC, toPowerOf: self.bigIntOBJC, and: uint)
    }
    
    
    // MARK: SetCompliant
    
    public var isNatural: Bool {
        return self >= BigInt(int: 0)
    }
    
    public var isInteger: Bool {
        return true
    }
}


// MARK: Equatable

public func == (left: BigInt, right: BigInt) -> Bool {
    return left.compare(right) == .orderedSame
}


// MARK: Comparable

public func < (left: BigInt, right: BigInt) -> Bool {
    return left.compare(right) == .orderedAscending
}

public func > (left: BigInt, right: BigInt) -> Bool {
    return left.compare(right) == .orderedDescending
}


// MARK: Addable

public func + (left: BigInt, right: BigInt) -> BigInt {
    return left.add(right)
}

public func += (left: inout BigInt, right: BigInt) {
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

public func -= (left: inout BigInt, right: BigInt) {
    left.subtractInPlace(right)
}


// MARK: Multiplicable

public func * (left: BigInt, right: BigInt) -> BigInt {
    return left.multiply(right)
}

public func *= (left: inout BigInt, right: BigInt) {
    left.multiplyInPlace(right)
}


// MARK: Dividable

public func / (left: BigInt, right: BigInt) -> BigInt {
    return left.divide(right)
}

public func /= (left: inout BigInt, right: BigInt) {
    left.divideInPlace(right)
}


// MARK: Absolute Value

public func abs(_ bigInt: BigInt) -> BigInt {
    return bigInt.absoluteValue
}
