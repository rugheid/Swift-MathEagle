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
public func isPrime <X: protocol<Equatable, Comparable, Addable, Modulable, RealPowerable, IntegerLiteralConvertible>> (x: X) -> Bool {
    
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
 Returns true if the given number is composite. This means it's not prime.
 
 - parameter x: The number to check.
 
 - returns: true if the given unsigned integer is composite.
 */
public func isComposite <X: protocol<Equatable, Comparable, Addable, Modulable, RealPowerable, IntegerLiteralConvertible>> (x: X) -> Bool {
    
    return !isPrime(x)
}


/**
    Returns true if the given unsigned integers are coprimes. This means they have no common prime factors.

    - parameter a: The first unsigned integer
    - parameter b: The second unsigned integer

    - returns: true if the given unsigned integers are coprime.
*/
public func areCoprime <X: protocol<Equatable, Comparable, Negatable, Modulable, IntegerLiteralConvertible>> (a: X, _ b: X) -> Bool {
    
    return gcd(a, b) == 1
}


/**
    Returns a list of all primes up to (and including) the given integer.

    - parameter n: The upper bound

    - returns: All primes up to (and including) the given integer.
*/
public func primesUpTo <X: protocol<Comparable, Addable, Substractable, Multiplicable, RealPowerable, IntegerLiteralConvertible, IntCastable>> (x: X) -> [X] {
    
    if x <= 1 { return [] }
    
    var sieve = [Bool](count: (x - 1).asInt, repeatedValue: true)
    
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
    Returns the prime factors of the given integer in ascending order. Factors with higher multiplicity will appear multiple times. An empty array will be returned for all numbers smaller than or equal to 1.

    - parameter n: The integer to factorise

    - returns: The prime factors of the given integer in ascending order.
*/
public func primeFactors <X: protocol<Equatable, Comparable, Addable, Modulable, Dividable, IntegerLiteralConvertible>> (x: X) -> [X] {
    
    if x <= 1 { return [] }
    
    var i: X = 2
    
    while i < x {
        
        if x % i == 0 {
            
            return primeFactors(i) + primeFactors(x/i)
        }
        
        i = i + 1
    }
    
    return [x]
}