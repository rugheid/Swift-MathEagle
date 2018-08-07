//
//  Divisors.swift
//  MathEagle
//
//  Created by Rugen Heidbuchel on 06/06/15.
//  Copyright (c) 2015 Jorestha Solutions. All rights reserved.
//



/**
Returns the divisors of the given value, sorted from smaller values to larger values.
The value itself is included.
An empty list will be returned for values smaller than or equal to zero.

- parameter x: The value to calculate the divisors of

- returns: The divisors of the given value, sorted from smaller values to larger values. The value itself is included.

:example: divisors(10) returns [1, 2, 5, 10]
*/
public func divisors <X: Hashable & Equatable & Comparable & Modulable & Dividable & RealPowerable & ExpressibleByIntegerLiteral> (_ x: X) -> [X] where X.RealPowerType: Comparable & Addable & ExpressibleByIntegerLiteral {
    
    if x <= 0 { return [] }
    if x == 1 { return [1] }
    
    var div: Set<X> = [1, x]
    
    let d = root(x, order: 2)
    if d < 2 { return Array<X>(div) }
    
    var i: X.RealPowerType = 2
    
    while i <= d {
        
        if x % X(i) == 0 {
            div.insert(X(i))
            div.insert(x/X(i))
        }
        
        i = i + 1
    }
    return div.sorted()
}


/**
Returns the proper divisors of the given value, sorted from smaller values to larger values.
The value itself is not included.
An empty list will be returned for values smaller than or equal to 1.

- parameter x: The value to calculate the proper divisors of

- returns: The proper divisors of the given value, sorted from smaller values to larger values. The value itself is not included.

:example: divisors(10) returns [1, 2, 5]
*/
public func properDivisors <X: Hashable & Equatable & Comparable & Modulable & Dividable & RealPowerable & ExpressibleByIntegerLiteral> (_ x: X) -> [X] where X.RealPowerType: Comparable & Addable & ExpressibleByIntegerLiteral {
    
    if x <= 1 { return [] }
    
    var div: Set<X> = [1]
    
    let d = root(x, order: 2)
    if d < 2 { return Array<X>(div) }
    
    var i: X.RealPowerType = 2
    
    while i <= d {
        
        if x % X(i) == 0 {
            div.insert(X(i))
            if x/X(i) != X(i) { div.insert(x/X(i)) }
        }
        
        i = i + 1
    }
    
    return div.sorted()
}


/**
Returns whether the given number is a perfect number. This means the sum of it's proper divisors equals the number itself.

- parameter x: The number to check

- returns: true if the given number is a perfect number.
*/
public func isPerfect <X: Hashable & Equatable & Comparable & Addable & Modulable & Dividable & RealPowerable & ExpressibleByIntegerLiteral> (_ x: X) -> Bool where X.RealPowerType: Comparable & Addable & ExpressibleByIntegerLiteral {
    
    return sum(properDivisors(x)) == x
}


/**
Returns whether the given number is abundant (or excessive). This means the sum of it's proper divisors is
greater than the number itself.

- parameter x:   The number to check

- returns: true if the number is abundant.
*/
public func isAbundant <X: Hashable & Equatable & Comparable & Addable & Modulable & Dividable & RealPowerable & ExpressibleByIntegerLiteral> (_ x: X) -> Bool where X.RealPowerType: Comparable & Addable & ExpressibleByIntegerLiteral {
    
    return sum(properDivisors(x)) > x
}


/**
Returns a set containing all abundant number up to a given value. The value itself is also
included when it is abundant.

- parameter x:   The maximum allowed number to include.
*/
public func abundantsUpTo <X: Equatable & Comparable & Addable & Modulable & Dividable & RealPowerable & ExpressibleByIntegerLiteral> (_ x: X) -> Set<X> where X.RealPowerType: Comparable & Addable & ExpressibleByIntegerLiteral {
    
    if x < 12 { return [] }
    
    var abundants: Set<X> = [12]
    
    var i: X = 18
    while i <= x {
        
        if abundants.contains(i) {
            i = i + 1
            continue
        }
        
        if isAbundant(i) {
            
            var k = i
            
            while k <= x {
                abundants.insert(k)
                k = k + i
            }
        }
        
        i = i + 1
    }
    
    return abundants
}


/**
Returns whether the given number is deficient. This means the sum of it's proper divisors is
less than the number itself.

- parameter x:   The number to check

- returns: true if the number is deficient.
*/
public func isDeficient <X: Hashable & Equatable & Comparable & Addable & Modulable & Dividable & RealPowerable & ExpressibleByIntegerLiteral> (_ x: X) -> Bool where X.RealPowerType: Comparable & Addable & ExpressibleByIntegerLiteral {
    
    return sum(properDivisors(x)) < x
}


/**
Returns the greatest common divisor of the two given numbers.

- parameter a:   The first number
- parameter b:   The second number

- returns: The greatest common divisor of the two given numbers. When either a or b equals 0, the not-zero
number is returned.
*/
public func gcd <X: Equatable & Comparable & Negatable & Modulable & ExpressibleByIntegerLiteral> (_ a: X, _ b: X) -> X {
    
    if a == 0 || b == 0 { return a == 0 ? b : a }
    
    var c = a, d = b
    
    while d != 0 {
        
        let temp = d
        d = c % d
        c = temp
    }
    
    return c < 0 ? -c : c
}


/**
Returns the least common multiple of the two given numbers.

- parameter a:   The first number.
- parameter b:   The second number.

- returns: The least common multiple of the two given numbers. When either a or b equals zero, zero is returned.
*/
public func lcm <X: Equatable & Comparable & Negatable & Multiplicable & Dividable & Modulable & ExpressibleByIntegerLiteral> (_ a: X, _ b: X) -> X {
    
    if a == 0 || b == 0 { return 0 }
    
    let lcm = (a / gcd(a, b)) * b
    
    return lcm < 0 ? -lcm : lcm
}


/**
    Returns wether the given value is a k'th power, where k is the given exponent. So it returns whether
    there exists a given b for which b^exponent = x.

    - parameter x:               The value to check.
    - parameter exponent:        The exponent to which a number to be raised to become x.
    - parameter integersAllowed: Indicates whether the base should be natural or integer.
*/
public func isPower <X: RealPowerable> (_ x:X, _ order: Int, integersAllowed: Bool = true) -> Bool where X.RealPowerType: SetCompliant {
    
    //TODO: Edge cases here? Negative exponents, non integer exponents?
    //FIXME: function doesn't work for some values, see tests. The problem lies with the root function
    
    let rt = root(x, order: order)
    return integersAllowed ? rt.isInteger : rt.isNatural
}
