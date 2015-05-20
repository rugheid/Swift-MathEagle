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

    :param: x The number to check for primality

    :returns: true if the given unsigned integer is prime.
*/
public func isPrime <X: protocol<Equatable, Comparable, Addable, Modulable, Powerable, IntegerLiteralConvertible>> (x: X) -> Bool {
    
    if x <= 3 { return x >= 2 }
    
    if x % 2 == 0 || x % 3 == 0 { return false }
    
    var p: X = 5
    
    while p <= X(x ** 0.5) {
        
        if x % p == 0 || x % (p + 2) == 0 { return false }
        
        p = p + 6
    }
    
    return true
}



/**
    Returns true if the given unsigned integers are coprimes. This means they have no common prime factors.

    :param: a The first unsigned integer
    :param: b The second unsigned integer

    :returns: true if the given unsigned integers are coprime.
*/
public func areCoprime <X: protocol<Equatable, Comparable, Negatable, Modulable, IntegerLiteralConvertible>> (a: X, b: X) -> Bool {
    
    return gcd(a, b) == 1
}


/**
    Returns a list of all primes up to (and including) the given integer.

    :param: n The upper bound

    :returns: All primes up to (and including) the given integer.
*/
public func primesUpTo(n: UInt) -> [UInt] {
    
    if n <= 1 { return [] }
    
    var sieve = [Bool](count: Int(n - 1), repeatedValue: true)
    
    for i: UInt in 2 ... UInt(sqrt(Double(n))) {
        
        if sieve[Int(i)-2] {
            
            var j = i*i
            
            while j <= n {
                
                sieve[Int(j)-2] = false
                
                j += i
            }
        }
    }
    
    var primes = [UInt]()
    
    for i in 0 ..< n-1 {
        
        if sieve[Int(i)] { primes.append(i+2) }
    }
    
    return primes
}


/**
    Returns the prime factors of the given integer in ascending order. Factors with higher multiplicity will appear multiple times. An empty array will be returned for all numbers smaller than or equal to 1.

    :param: n The integer to factorise

    :returns: The prime factors of the given integer in ascending order.
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