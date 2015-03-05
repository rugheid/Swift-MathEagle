//
//  Prime.swift
//  MathEagle
//
//  Created by Rugen Heidbuchel on 05/03/15.
//  Copyright (c) 2015 Jorestha Solutions. All rights reserved.
//

import Foundation


/**
    Returns true if the given integer is prime.

    :param: n The number to check for primality

    :returns: true if the given integer is prime.
*/
func isPrime(n: Int) -> Bool {
    
    if n <= 3 { return n >= 2 }
    
    if n % 2 == 0 || n % 3 == 0 { return false }
    
    var p = 5
    
    while p <= Int(sqrt(Double(n))) {
        
        if n % p == 0 || n % (p + 2) == 0 { return false }
        
        p += 6
    }
    
    return true
}


/**
    Returns a list of all primes up to (and including) the given integer.

    :param: n The upper bound

    :returns: All primes up to (and including) the given integer.
*/
func primesUpTo(n: Int) -> [Int] {
    
    if n <= 1 { return [] }
    
    var sieve = [Bool](count: n-1, repeatedValue: true)
    
    for i in 2 ... Int(sqrt(Double(n))) {
        
        if sieve[i-2] {
            
            var j = i*i
            
            while j <= n {
                
                sieve[j-2] = false
                
                j += i
            }
        }
    }
    
    var primes = [Int]()
    
    for i in 0 ..< n-1 {
        
        if sieve[i] { primes.append(i+2) }
    }
    
    return primes
}


/**
    Returns the prime factors of the given integer in ascending order. Factors with higher multiplicity will appear multiple times.

    :param: n The integer to factorise

    :returns: The prime factors of the given integer in ascending order.
*/
func primeFactors(n: Int) -> [Int] {
    
    if n <= 1 { return [] }
    
    for i in 2 ..< n {
        
        if n % i == 0 {
            
            return primeFactors(i) + primeFactors(n/i)
        }
    }
    
    return [n]
}