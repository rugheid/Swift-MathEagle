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

:param: x The value to calculate the divisors of

:returns: The divisors of the given value, sorted from smaller values to larger values. The value itself is included.

:example: divisors(10) returns [1, 2, 5, 10]
*/
public func divisors <X: protocol<Equatable, Comparable, Modulable, Dividable, Powerable, IntegerLiteralConvertible> where X.PowerType: protocol<Comparable, Addable, IntegerLiteralConvertible>> (x: X) -> [X] {
    
    if x <= 0 { return [] }
    if x == 1 { return [1] }
    
    var div = [1, x]
    
    let d = x ** 0.5
    if d < 2 { return div }
    
    var i: X.PowerType = 2
    
    while i <= d {
        
        if x % X(i) == 0 {
            div.append(X(i))
            div.append(x/X(i))
        }
        
        i = i + 1
    }
    
    return div.sorted(){ $0 < $1 }
}


/**
Returns the proper divisors of the given value, sorted from smaller values to larger values.
The value itself is not included.
An empty list will be returned for values smaller than or equal to 1.

:param: x The value to calculate the proper divisors of

:returns: The proper divisors of the given value, sorted from smaller values to larger values. The value itself is not included.

:example: divisors(10) returns [1, 2, 5]
*/
public func properDivisors <X: protocol<Equatable, Comparable, Modulable, Dividable, Powerable, IntegerLiteralConvertible> where X.PowerType: protocol<Comparable, Addable, IntegerLiteralConvertible>> (x: X) -> [X] {
    
    if x <= 1 { return [] }
    
    var div: [X] = [1]
    
    let d = x ** 0.5
    if d < 2 { return div }
    
    var i: X.PowerType = 2
    
    while i <= d {
        
        if x % X(i) == 0 {
            div.append(X(i))
            if x/X(i) != X(i) { div.append(x/X(i)) }
        }
        
        i = i + 1
    }
    
    return div.sorted(){ $0 < $1 }
}


/**
Returns whether the given number is a perfect number. This means the sum of it's proper divisors equals the number itself.

:param: x The number to check

:returns: true if the given number is a perfect number.
*/
public func isPerfect <X: protocol<Equatable, Comparable, Addable, Modulable, Dividable, Powerable, IntegerLiteralConvertible> where X.PowerType: protocol<Comparable, Addable, IntegerLiteralConvertible>> (x: X) -> Bool {
    
    return sum(properDivisors(x)) == x
}


/**
Returns whether the given number is abundant (or excessive). This means the sum of it's proper divisors is
greater than the number itself.

:param: x   The number to check

:returns: true if the number is abundant.
*/
public func isAbundant <X: protocol<Equatable, Comparable, Addable, Modulable, Dividable, Powerable, IntegerLiteralConvertible> where X.PowerType: protocol<Comparable, Addable, IntegerLiteralConvertible>> (x: X) -> Bool {
    
    return sum(properDivisors(x)) > x
}


/**
Returns a set containing all abundant number up to a given value. The value itself is also
included when it is abundant.

:param: x   The maximum allowed number to include.
*/
public func abundantsUpTo <X: protocol<Equatable, Comparable, Addable, Modulable, Dividable, Powerable, IntegerLiteralConvertible> where X.PowerType: protocol<Comparable, Addable, IntegerLiteralConvertible>> (x: X) -> Set<X> {
    
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

:param: x   The number to check

:returns: true if the number is deficient.
*/
public func isDeficient <X: protocol<Equatable, Comparable, Addable, Modulable, Dividable, Powerable, IntegerLiteralConvertible> where X.PowerType: protocol<Comparable, Addable, IntegerLiteralConvertible>> (x: X) -> Bool {
    
    return sum(properDivisors(x)) < x
}


/**
Returns the greatest common divisor of the two given numbers.

:param: a   The first number
:param: b   The second number

:returns: The greatest common divisor of the two given numbers. When either a or b equals 0, the not-zero
number is returned.
*/
public func gcd <X: protocol<Equatable, Comparable, Negatable, Modulable, IntegerLiteralConvertible>> (a: X, b: X) -> X {
    
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

:param: a   The first number.
:param: b   The second number.

:returns: The least common multiple of the two given numbers. When either a or b equals zero, zero is returned.
*/
public func lcm <X: protocol<Equatable, Comparable, Negatable, Multiplicable, Dividable, Modulable, IntegerLiteralConvertible>> (a: X, b: X) -> X {
    
    if a == 0 || b == 0 { return 0 }
    
    let lcm = (a / gcd(a, b)) * b
    
    return lcm < 0 ? -lcm : lcm
}