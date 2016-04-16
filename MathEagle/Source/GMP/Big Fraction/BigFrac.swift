//
//  BigFrac.swift
//  MathEagle
//
//  Created by Rugen Heidbuchel on 16/04/16.
//  Copyright © 2016 Jorestha Solutions. All rights reserved.
//

import Foundation

public struct BigFrac: Equatable, Comparable, Addable, Negatable, Subtractable, Multiplicable, Dividable, SetCompliant, CustomStringConvertible, Hashable, IntegerLiteralConvertible {
    
    
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
    
    public init(int: Int) {
        self.init(numerator: int, denominator: 1)
    }
    
    public init(integerLiteral value: IntegerLiteralType) {
        self.init(int: value)
    }
    
    public init(numerator: UInt, denominator: UInt) {
        bigFracOBJC = BigFrac_OBJC(unsignedLongNumerator: numerator, denominator: denominator)
    }
    
    public init(uint: UInt) {
        self.init(numerator: uint, denominator: 1)
    }
    
    public init(string: String, base: Int32 = 10) {
        bigFracOBJC = BigFrac_OBJC(string: string.cStringUsingEncoding(NSUTF8StringEncoding)!, inBase: base)
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
    public func stringValue(base: Int32 = 10) -> String {
        return String(CString: self.bigFracOBJC.getStringValueInBase(base), encoding: NSUTF8StringEncoding)!
    }
    
    
    // MARK: Comparisons
    
    public func compare(bigFrac: BigFrac) -> NSComparisonResult {
        let cmp = self.bigFracOBJC.compareWithBigFracOBJC(bigFrac.bigFracOBJC)
        if cmp < 0 {
            return .OrderedAscending
        } else if cmp > 0 {
            return .OrderedDescending
        } else {
            return .OrderedSame
        }
    }
    
    
    // MARK: Operations
    
    public func add(bigFrac: BigFrac) -> BigFrac {
        let result = BigFrac()
        BigFrac_OBJC.set(result.bigFracOBJC, toSumOf: self.bigFracOBJC, and: bigFrac.bigFracOBJC)
        return result
    }
    
    public mutating func addInPlace(bigFrac: BigFrac) {
        BigFrac_OBJC.set(self.bigFracOBJC, toSumOf: self.bigFracOBJC, and: bigFrac.bigFracOBJC)
    }
    
    public var negation: BigFrac {
        let result = BigFrac()
        BigFrac_OBJC.set(result.bigFracOBJC, toNegationOf: self.bigFracOBJC)
        return result
    }
    
    public mutating func negateInPlace() {
        BigFrac_OBJC.set(self.bigFracOBJC, toNegationOf: self.bigFracOBJC)
    }
    
    public func subtract(bigFrac: BigFrac) -> BigFrac {
        let result = BigFrac()
        BigFrac_OBJC.set(result.bigFracOBJC, toDifferenceOf: self.bigFracOBJC, and: bigFrac.bigFracOBJC)
        return result
    }
    
    public mutating func subtractInPlace(bigFrac: BigFrac) {
        BigFrac_OBJC.set(self.bigFracOBJC, toDifferenceOf: self.bigFracOBJC, and: bigFrac.bigFracOBJC)
    }
    
    public func multiply(bigFrac: BigFrac) -> BigFrac {
        let result = BigFrac()
        BigFrac_OBJC.set(result.bigFracOBJC, toProductOf: self.bigFracOBJC, and: bigFrac.bigFracOBJC)
        return result
    }
    
    public mutating func multiplyInPlace(bigFrac: BigFrac) {
        BigFrac_OBJC.set(self.bigFracOBJC, toProductOf: self.bigFracOBJC, and: bigFrac.bigFracOBJC)
    }
    
    public func divide(bigFrac: BigFrac) -> BigFrac {
        let result = BigFrac()
        BigFrac_OBJC.set(result.bigFracOBJC, toQuotientOf: self.bigFracOBJC, and: bigFrac.bigFracOBJC)
        return result
    }
    
    public mutating func divideInPlace(bigFrac: BigFrac) {
        BigFrac_OBJC.set(self.bigFracOBJC, toQuotientOf: self.bigFracOBJC, and: bigFrac.bigFracOBJC)
    }
    
    public var absoluteValue: BigFrac {
        let result = BigFrac()
        BigFrac_OBJC.set(result.bigFracOBJC, toAbsoluteValueOf: self.bigFracOBJC)
        return result
    }
    
    public mutating func absoluteValueInPlace() {
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
    return left.compare(right) == .OrderedSame
}


// MARK: Comparable

public func < (left: BigFrac, right: BigFrac) -> Bool {
    return left.compare(right) == .OrderedAscending
}

public func > (left: BigFrac, right: BigFrac) -> Bool {
    return left.compare(right) == .OrderedDescending
}


// MARK: Addable

public func + (left: BigFrac, right: BigFrac) -> BigFrac {
    return left.add(right)
}

public func += (inout left: BigFrac, right: BigFrac) {
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

public func -= (inout left: BigFrac, right: BigFrac) {
    left.subtractInPlace(right)
}


// MARK: Multiplicable

public func * (left: BigFrac, right: BigFrac) -> BigFrac {
    return left.multiply(right)
}

public func *= (inout left: BigFrac, right: BigFrac) {
    left.multiplyInPlace(right)
}


// MARK: Dividable

public func / (left: BigFrac, right: BigFrac) -> BigFrac {
    return left.divide(right)
}

public func /= (inout left: BigFrac, right: BigFrac) {
    left.divideInPlace(right)
}


// MARK: Absolute Value

public func abs(bigInt: BigFrac) -> BigFrac {
    return bigInt.absoluteValue
}
