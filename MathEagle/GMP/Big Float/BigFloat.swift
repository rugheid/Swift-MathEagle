//
//  BigFloat.swift
//  MathEagle
//
//  Created by Rugen Heidbuchel on 22/04/16.
//  Copyright © 2016 Jorestha Solutions. All rights reserved.
//

import Foundation

public struct BigFloat: Comparable, Addable, Negatable, Subtractable, Multiplicable, Dividable, SetCompliant, NaturalPowerable, CustomStringConvertible, Hashable, ExpressibleByIntegerLiteral {
    
    
    // MARK: Private Properties
    
    var bigFloatOBJC: BigFloat_OBJC
    
    
    // MARK: Associated Types
    
    public typealias NaturalPowerType = BigFloat
    
    
    // MARK: Initialisers
    
    public init() {
        bigFloatOBJC = BigFloat_OBJC()
    }
    
    public init(_ bigFloat: BigFloat) {
        bigFloatOBJC = BigFloat_OBJC(bigFloat: bigFloat.bigFloatOBJC)
    }
    
    public init(bigInt: BigInt) {
        bigFloatOBJC = BigFloat_OBJC(bigIntOBJC: bigInt.bigIntOBJC)
    }
    
    public init(bigFrac: BigFrac) {
        bigFloatOBJC = BigFloat_OBJC(bigFracOBJC: bigFrac.bigFracOBJC)
    }
    
    public init(int: Int) {
        bigFloatOBJC = BigFloat_OBJC(long: int)
    }
    
    public init(integerLiteral value: IntegerLiteralType) {
        bigFloatOBJC = BigFloat_OBJC(long: value)
    }
    
    public init(uint: UInt) {
        bigFloatOBJC = BigFloat_OBJC(unsignedLong: uint)
    }
    
    public init(double: Double) {
        bigFloatOBJC = BigFloat_OBJC(double: double)
    }
    
    public init(string: String, base: Int32 = 10) {
        bigFloatOBJC = BigFloat_OBJC(string: string.cString(using: String.Encoding.utf8)!, inBase: base)
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
        return self.doubleValue.hashValue
    }
    
    
    // MARK: Conversions
    
    /**
     Returns the int value of the number. When the number is too big to represent as an Int,
     the Int formed by using the lower significant bits is returned.
     */
    public var intValue: Int {
        return self.bigFloatOBJC.getLongValue()
    }
    
    /**
     Returns the unsigned int value of the number. When the number is too big to represent as a UInt,
     the UInt formed by using the lower significant bits is returned. The sign of the number is ignored.
     */
    public var uintValue: UInt {
        return self.bigFloatOBJC.getUnsignedLongValue()
    }
    
    /**
     Returns the double value of the number. When the number can not be represented as a Double,
     the number is rounded towards zero. Inf is returned if it's too big.
     */
    public var doubleValue: Double {
        return self.bigFloatOBJC.getDoubleValue()
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
    public func stringValue(_ base: Int32 = 10, maxNumberOfDigits: Int = 18) -> String {
        var exponent = 0;
        var string = String(cString: self.bigFloatOBJC.getStringValue(inBase: base,
            exponentReference: &exponent,
            maxNumberOfDigits: maxNumberOfDigits),
                            encoding: String.Encoding.utf8)!
        if (string=="") {
            string="0.0"
        } else {
            let signOffset = string.hasPrefix("-") ? 1 : 0
            string.insert(".", at: string.index(after: string.index(string.startIndex, offsetBy:signOffset)))
            string.append("e\(exponent-1)")
        }
        return string
    }
    
    
    // MARK: Comparisons
    
    public func compare(_ bigFloat: BigFloat) -> ComparisonResult {
        let cmp = self.bigFloatOBJC.compare(withBigFloat: bigFloat.bigFloatOBJC)
        if cmp < 0 {
            return .orderedAscending
        } else if cmp > 0 {
            return .orderedDescending
        } else {
            return .orderedSame
        }
    }
    
    public func compare(_ double: Double) -> ComparisonResult {
        let cmp = self.bigFloatOBJC.compare(with: double)
        if cmp < 0 {
            return .orderedAscending
        } else if cmp > 0 {
            return .orderedDescending
        } else {
            return .orderedSame
        }
    }
    
    public func compare(_ uint: UInt) -> ComparisonResult {
        let cmp = self.bigFloatOBJC.compare(withUnsignedLong: uint)
        if cmp < 0 {
            return .orderedAscending
        } else if cmp > 0 {
            return .orderedDescending
        } else {
            return .orderedSame
        }
    }
    
    public func compare(_ int: Int) -> ComparisonResult {
        let cmp = self.bigFloatOBJC.compare(withLong: int)
        if cmp < 0 {
            return .orderedAscending
        } else if cmp > 0 {
            return .orderedDescending
        } else {
            return .orderedSame
        }
    }
    
    
    // MARK: Operations
    
    public func add(_ bigFloat: BigFloat) -> BigFloat {
        let result = BigFloat()
        BigFloat_OBJC.set(result.bigFloatOBJC, toSumOf: self.bigFloatOBJC, and: bigFloat.bigFloatOBJC)
        return result
    }
    
    public mutating func addInPlace(_ bigFloat: BigFloat) {
        BigFloat_OBJC.set(self.bigFloatOBJC, toSumOf: self.bigFloatOBJC, and: bigFloat.bigFloatOBJC)
    }
    
    public func add(_ uint: UInt) -> BigFloat {
        let result = BigFloat()
        BigFloat_OBJC.set(result.bigFloatOBJC, toSumOf: self.bigFloatOBJC, andUnsignedLong: uint)
        return result
    }
    
    public mutating func addInPlace(_ uint: UInt) {
        BigFloat_OBJC.set(self.bigFloatOBJC, toSumOf: self.bigFloatOBJC, andUnsignedLong: uint)
    }
    
    public var negation: BigFloat {
        let result = BigFloat()
        BigFloat_OBJC.set(result.bigFloatOBJC, toNegationOf: self.bigFloatOBJC)
        return result
    }
    
    public mutating func negateInPlace() {
        BigFloat_OBJC.set(self.bigFloatOBJC, toNegationOf: self.bigFloatOBJC)
    }
    
    public func subtract(_ bigFloat: BigFloat) -> BigFloat {
        let result = BigFloat()
        BigFloat_OBJC.set(result.bigFloatOBJC, toDifferenceOf: self.bigFloatOBJC, and: bigFloat.bigFloatOBJC)
        return result
    }
    
    public mutating func subtractInPlace(_ bigFloat: BigFloat) {
        BigFloat_OBJC.set(self.bigFloatOBJC, toDifferenceOf: self.bigFloatOBJC, and: bigFloat.bigFloatOBJC)
    }
    
    public func subtract(_ uint: UInt) -> BigFloat {
        let result = BigFloat()
        BigFloat_OBJC.set(result.bigFloatOBJC, toDifferenceOf: self.bigFloatOBJC, andUnsignedLong: uint)
        return result
    }
    
    public mutating func subtractInPlace(_ uint: UInt) {
        BigFloat_OBJC.set(self.bigFloatOBJC, toDifferenceOf: self.bigFloatOBJC, andUnsignedLong: uint)
    }
    
    public func subtractFromUInt(_ uint: UInt) -> BigFloat {
        let result = BigFloat()
        BigFloat_OBJC.set(result.bigFloatOBJC, toDifferenceOfUnsignedLong: uint, and: self.bigFloatOBJC)
        return result
    }
    
    public mutating func subtractFromUIntInPlace(_ uint: UInt) {
        BigFloat_OBJC.set(self.bigFloatOBJC, toDifferenceOfUnsignedLong: uint, and: self.bigFloatOBJC)
    }
    
    public func multiply(_ bigFloat: BigFloat) -> BigFloat {
        let result = BigFloat()
        BigFloat_OBJC.set(result.bigFloatOBJC, toProductOf: self.bigFloatOBJC, and: bigFloat.bigFloatOBJC)
        return result
    }
    
    public mutating func multiplyInPlace(_ bigFloat: BigFloat) {
        BigFloat_OBJC.set(self.bigFloatOBJC, toProductOf: self.bigFloatOBJC, and: bigFloat.bigFloatOBJC)
    }
    
    public func multiply(_ uint: UInt) -> BigFloat {
        let result = BigFloat()
        BigFloat_OBJC.set(result.bigFloatOBJC, toProductOf: self.bigFloatOBJC, andUnsignedLong: uint)
        return result
    }
    
    public mutating func multiplyInPlace(_ uint: UInt) {
        BigFloat_OBJC.set(self.bigFloatOBJC, toProductOf: self.bigFloatOBJC, andUnsignedLong: uint)
    }
    
    public func divide(_ bigFloat: BigFloat) -> BigFloat {
        let result = BigFloat()
        BigFloat_OBJC.set(result.bigFloatOBJC, toQuotientOf: self.bigFloatOBJC, and: bigFloat.bigFloatOBJC)
        return result
    }
    
    public mutating func divideInPlace(_ bigFloat: BigFloat) {
        BigFloat_OBJC.set(self.bigFloatOBJC, toQuotientOf: self.bigFloatOBJC, and: bigFloat.bigFloatOBJC)
    }
    
    public func divide(_ uint: UInt) -> BigFloat {
        let result = BigFloat()
        BigFloat_OBJC.set(result.bigFloatOBJC, toQuotientOf: self.bigFloatOBJC, andUnsignedLong: uint)
        return result
    }
    
    public mutating func divideInPlace(_ uint: UInt) {
        BigFloat_OBJC.set(self.bigFloatOBJC, toQuotientOf: self.bigFloatOBJC, andUnsignedLong: uint)
    }
    
    // TODO: The OBJC implementation also supports uint/bigFloat, what should we do with that?
    
    public var absoluteValue: BigFloat {
        let result = BigFloat()
        BigFloat_OBJC.set(result.bigFloatOBJC, toAbsoluteValueOf: self.bigFloatOBJC)
        return result
    }
    
    public mutating func absoluteValueInPlace() {
        BigFloat_OBJC.set(self.bigFloatOBJC, toAbsoluteValueOf: self.bigFloatOBJC)
    }
    
    public func power(_ exponent: UInt) -> BigFloat {
        let result = BigFloat()
        BigFloat_OBJC.set(result.bigFloatOBJC, to: self.bigFloatOBJC, toThePower: exponent)
        return result
    }
    
    public mutating func powerInPlace(_ exponent: UInt) {
        BigFloat_OBJC.set(self.bigFloatOBJC, to: self.bigFloatOBJC, toThePower: exponent)
    }
    
    
    // MARK: SetCompliant
    
    public var isNatural: Bool {
        // FIXME: Implement this
        return false
    }
    
    public var isInteger: Bool {
        // FIXME: Implement this
        return true
    }
}


// MARK: Equatable

public func == (left: BigFloat, right: BigFloat) -> Bool {
    return left.compare(right) == .orderedSame
}


// MARK: Comparable

public func < (left: BigFloat, right: BigFloat) -> Bool {
    return left.compare(right) == .orderedAscending
}

public func > (left: BigFloat, right: BigFloat) -> Bool {
    return left.compare(right) == .orderedDescending
}


// MARK: Addable

public func + (left: BigFloat, right: BigFloat) -> BigFloat {
    return left.add(right)
}

public func += (left: inout BigFloat, right: BigFloat) {
    left.addInPlace(right)
}


// MARK: Negatable

public prefix func - (bigFloat: BigFloat) -> BigFloat {
    return bigFloat.negation
}


// MARK: Subtractable

public func - (left: BigFloat, right: BigFloat) -> BigFloat {
    return left.subtract(right)
}

public func -= (left: inout BigFloat, right: BigFloat) {
    left.subtractInPlace(right)
}


// MARK: Multiplicable

public func * (left: BigFloat, right: BigFloat) -> BigFloat {
    return left.multiply(right)
}

public func *= (left: inout BigFloat, right: BigFloat) {
    left.multiplyInPlace(right)
}


// MARK: Dividable

public func / (left: BigFloat, right: BigFloat) -> BigFloat {
    return left.divide(right)
}

public func /= (left: inout BigFloat, right: BigFloat) {
    left.divideInPlace(right)
}


// MARK: Natural Powerable

public func ** (left: BigFloat, right: UInt) -> BigFloat {
    return left.power(right)
}


// MARK: Absolute Value

public func abs(_ bigFloat: BigFloat) -> BigFloat {
    return bigFloat.absoluteValue
}


// MARK: Sqrt

public func sqrt(_ bigFloat: BigFloat) -> BigFloat {
    let result = BigFloat()
    BigFloat_OBJC.set(result.bigFloatOBJC, toSquareRootOf: bigFloat.bigFloatOBJC)
    return result
}
