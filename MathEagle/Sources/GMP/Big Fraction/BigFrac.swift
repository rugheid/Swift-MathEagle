//
//  BigFrac.swift
//  MathEagle
//
//  Created by Rugen Heidbuchel on 16/04/16.
//  Copyright © 2016 Jorestha Solutions. All rights reserved.
//

import Foundation

public final class BigFrac: Comparable, Addable, Negatable, Subtractable, Multiplicable, Dividable, SetCompliant, CustomStringConvertible, Hashable, ExpressibleByIntegerLiteral {
    
    
    // MARK: Private Properties
    
    var bigFracOBJC: BigFrac_OBJC
    
    
    // MARK: Initialisers
    
    public init() {
        bigFracOBJC = BigFrac_OBJC()
    }
    
    public init(bigInt: BigInt) {
        bigFracOBJC = BigFrac_OBJC(bigIntOBJC: bigInt.bigIntOBJC)
    }
    
    public init(numerator: Int, denominator: Int) {
        bigFracOBJC = BigFrac_OBJC(longNumerator: numerator, denominator: denominator)
    }
    
    public convenience init(int: Int) {
        self.init(numerator: int, denominator: 1)
    }
    
    public required convenience init(integerLiteral value: IntegerLiteralType) {
        self.init(int: value)
    }
    
    public init(numerator: UInt, denominator: UInt) {
        bigFracOBJC = BigFrac_OBJC(unsignedLongNumerator: numerator, denominator: denominator)
    }
    
    public convenience init(uint: UInt) {
        self.init(numerator: uint, denominator: 1)
    }
    
    public init(string: String, base: Int32 = 10) {
        bigFracOBJC = BigFrac_OBJC(string: string.cString(using: String.Encoding.utf8)!, inBase: base)
    }
    
    
    // MARK: Deinit
    
    deinit {
        bigFracOBJC.clear()
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
    
    /**
     Returns the numerator of the fraction.
     */
    public var numerator: BigInt {
        var bigInt = BigInt()
        bigInt.bigIntOBJC = self.bigFracOBJC.numerator()
        return bigInt
    }
    
    /**
     Returns the denominator of the fraction.
     */
    public var denominator: BigInt {
        var bigInt = BigInt()
        bigInt.bigIntOBJC = self.bigFracOBJC.denominator()
        return bigInt
    }
    
    
    // MARK: Basic Methods
    
    /**
     Canonicalizes the fraction. This means the numerator and denominator don't have common factors and
     that the denominator is positive.
     */
    public func canonicalize() {
        self.bigFracOBJC.canonicalize()
    }
    
    
    // MARK: Conversions
    
    /**
     Returns the double value of the number. When the number can not be represented as a Double,
     the number is rounded towards zero. Inf is returned if it's too big.
     */
    public var doubleValue: Double {
        return self.bigFracOBJC.getDoubleValue()
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
        return String(cString: self.bigFracOBJC.getStringValue(inBase: base), encoding: String.Encoding.utf8)!
    }
    
    
    // MARK: Comparisons
    
    public func compare(_ bigFrac: BigFrac) -> ComparisonResult {
        let cmp = self.bigFracOBJC.compare(withBigFracOBJC: bigFrac.bigFracOBJC)
        if cmp < 0 {
            return .orderedAscending
        } else if cmp > 0 {
            return .orderedDescending
        } else {
            return .orderedSame
        }
    }
    
    
    // MARK: Operations
    
    public func add(_ bigFrac: BigFrac) -> BigFrac {
        let result = BigFrac()
        BigFrac_OBJC.set(result.bigFracOBJC, toSumOf: self.bigFracOBJC, and: bigFrac.bigFracOBJC)
        return result
    }
    
    public func addInPlace(_ bigFrac: BigFrac) {
        BigFrac_OBJC.set(self.bigFracOBJC, toSumOf: self.bigFracOBJC, and: bigFrac.bigFracOBJC)
    }
    
    public var negation: BigFrac {
        let result = BigFrac()
        BigFrac_OBJC.set(result.bigFracOBJC, toNegationOf: self.bigFracOBJC)
        return result
    }
    
    public func negateInPlace() {
        BigFrac_OBJC.set(self.bigFracOBJC, toNegationOf: self.bigFracOBJC)
    }
    
    public func subtract(_ bigFrac: BigFrac) -> BigFrac {
        let result = BigFrac()
        BigFrac_OBJC.set(result.bigFracOBJC, toDifferenceOf: self.bigFracOBJC, and: bigFrac.bigFracOBJC)
        return result
    }
    
    public func subtractInPlace(_ bigFrac: BigFrac) {
        BigFrac_OBJC.set(self.bigFracOBJC, toDifferenceOf: self.bigFracOBJC, and: bigFrac.bigFracOBJC)
    }
    
    public func multiply(_ bigFrac: BigFrac) -> BigFrac {
        let result = BigFrac()
        BigFrac_OBJC.set(result.bigFracOBJC, toProductOf: self.bigFracOBJC, and: bigFrac.bigFracOBJC)
        return result
    }
    
    public func multiplyInPlace(_ bigFrac: BigFrac) {
        BigFrac_OBJC.set(self.bigFracOBJC, toProductOf: self.bigFracOBJC, and: bigFrac.bigFracOBJC)
    }
    
    public func divide(_ bigFrac: BigFrac) -> BigFrac {
        let result = BigFrac()
        BigFrac_OBJC.set(result.bigFracOBJC, toQuotientOf: self.bigFracOBJC, and: bigFrac.bigFracOBJC)
        return result
    }
    
    public func divideInPlace(_ bigFrac: BigFrac) {
        BigFrac_OBJC.set(self.bigFracOBJC, toQuotientOf: self.bigFracOBJC, and: bigFrac.bigFracOBJC)
    }
    
    public var absoluteValue: BigFrac {
        let result = BigFrac()
        BigFrac_OBJC.set(result.bigFracOBJC, toAbsoluteValueOf: self.bigFracOBJC)
        return result
    }
    
    public func absoluteValueInPlace() {
        BigFrac_OBJC.set(self.bigFracOBJC, toAbsoluteValueOf: self.bigFracOBJC)
    }
    
    
    // MARK: SetCompliant
    
    public var isNatural: Bool {
        return self >= BigFrac()
    }
    
    public var isInteger: Bool {
        // TODO: Implement this
        return true
    }
}


// MARK: Equatable

public func == (left: BigFrac, right: BigFrac) -> Bool {
    return left.compare(right) == .orderedSame
}


// MARK: Comparable

public func < (left: BigFrac, right: BigFrac) -> Bool {
    return left.compare(right) == .orderedAscending
}

public func > (left: BigFrac, right: BigFrac) -> Bool {
    return left.compare(right) == .orderedDescending
}


// MARK: Addable

public func + (left: BigFrac, right: BigFrac) -> BigFrac {
    return left.add(right)
}

public func += (left: inout BigFrac, right: BigFrac) {
    left.addInPlace(right)
}


// MARK: Negatable

public prefix func - (bigInt: BigFrac) -> BigFrac {
    return bigInt.negation
}


// MARK: Subtractable

public func - (left: BigFrac, right: BigFrac) -> BigFrac {
    return left.subtract(right)
}

public func -= (left: inout BigFrac, right: BigFrac) {
    left.subtractInPlace(right)
}


// MARK: Multiplicable

public func * (left: BigFrac, right: BigFrac) -> BigFrac {
    return left.multiply(right)
}

public func *= (left: inout BigFrac, right: BigFrac) {
    left.multiplyInPlace(right)
}


// MARK: Dividable

public func / (left: BigFrac, right: BigFrac) -> BigFrac {
    return left.divide(right)
}

public func /= (left: inout BigFrac, right: BigFrac) {
    left.divideInPlace(right)
}


// MARK: Absolute Value

public func abs(_ bigInt: BigFrac) -> BigFrac {
    return bigInt.absoluteValue
}
