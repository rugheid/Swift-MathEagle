//
//  Prime.swift
//  MathEagle
//
//  Created by Rugen Heidbuchel on 05/03/15.
//  Copyright (c) 2015 Jorestha Solutions. All rights reserved.
//

import Foundation


/**
    Returns true if the given number is prime.

    - parameter x: The number to check for primality

    - returns: true if the given number is prime.
*/
public func isPrime <X: Equatable & Comparable & Negatable & Addable & Modulable & RealPowerable & ExpressibleByIntegerLiteral> (_ x: X) -> Bool {
    
    // NOTE: In abstract algebra, an element p of a commutative ring is said
    // to be prime if it is not zero and whenever p divides xy, then p divides
    // x or p divides y .  In this sense, we count -p as an integer prime if
    // p is a positive integer prime. The caller is free to check the sign of
    // input x first, before calling our isPrime .  This approach leads to
    // pleasing answers for other questions such as isComposite(-1000000) etc.
    
    if x < 0 { return isPrime(-x) }
    
    if x <= 3 { return x >= 2 }
    
    if x % 2 == 0 || x % 3 == 0 { return false }
    
    var p: X = 5
    
    while p <= X(root(x, order: 2)) {
        
        if x % p == 0 || x % (p + 2) == 0 { return false }
        
        p = p + 6
    }
    
    return true
}


/**
 Returns true if the given number is composite. A number is composite if it is
 the product of two or more not necessarily distinct primes.
 
 - parameter x: The number to check.
 
 - returns: true if the given integer is composite.
 */
public func isComposite <X: Equatable & Comparable & Negatable & Addable & Modulable & RealPowerable & ExpressibleByIntegerLiteral> (_ x: X) -> Bool {
    
    return abs(x)>3 && !isPrime(x)
}


/**
    Returns true if the given unsigned integers are coprimes. This means they have no common prime factors.

    - parameter a: The first unsigned integer
    - parameter b: The second unsigned integer

    - returns: true if the given unsigned integers are coprime.
*/
public func areCoprime <X: Equatable & Comparable & Negatable & Modulable & ExpressibleByIntegerLiteral> (_ a: X, _ b: X) -> Bool {
    
    return gcd(b, a) == 1
}


/**
    Returns a list of all primes up to (and including) the given integer.

    - parameter n: The upper bound

    - returns: All primes up to (and including) the given integer.
*/
public func primesUpTo <X: Comparable & Addable & Subtractable & Multiplicable & RealPowerable & ExpressibleByIntegerLiteral & IntCastable> (_ x: X) -> [X] {
    
    if x <= 1 { return [] }
    
    var sieve = [Bool](repeating: true, count: (x - 1).asInt)
    
    var i: X = 2
    while i <= X(root(x, order: 2)) {
        
        if sieve[i.asInt - 2] {
            
            var j = i*i
            
            while j <= x {
                
                sieve[j.asInt - 2] = false
                
                j = j + i
            }
        }
        
        i = i + 1
    }
    
    var primes = [X]()
    
    i = 0
    while i < (x - 1) {
        
        if sieve[i.asInt] { primes.append(i + 2) }
        
        i = i + 1
    }
    
    return primes
}


/**
    Returns the prime factors of the given number in ascending order. Factors with higher multiplicity will appear multiple times. An empty array will be returned for all numbers smaller than or equal to 1.

    - parameter n: The number to factorise

    - returns: The prime factors of the given integer in ascending order.
*/
public func primeFactors <X: Equatable & Comparable & Addable & Modulable & Dividable & RealPowerable & ExpressibleByIntegerLiteral & IntCastable> (_ x: X) -> [X] {
    
    if x <= 1 { return [] }
    
    var i: X = 2
    
    while i <= X(root(x, order: 2)) {
        
        if x % i == 0 {
            
            return primeFactors(i) + primeFactors(x/i)
        }
        
        i = i + 1
    }
    
    return [x]
}


private var primeFactors = [Int:[Int]]()

/**
 Returns the prime factors of the given integer in ascending order. Factors with higher multiplicity will appear multiple times. An empty array will be returned for all numbers smaller than or equal to 1.
 This version is optimised for Ints.
 
 - parameter n: The integer to factorise
 
 - returns: The prime factors of the given integer in ascending order.
 */
public func primeFactors(_ x: Int) -> [Int] {
    
    if x <= 1 { return [] }
    
    if let factors = primeFactors[x] {
        // Return cached answer calculated in prior call
        return factors
    }
    
    var i = 2
    
    while i <= Int(root(x, order: 2)) {
        
        if x % i == 0 {
            
            return primeFactors(i) + primeFactors(x/i)
        }
        
        i = i + 1
    }
    
    return [x]
}
