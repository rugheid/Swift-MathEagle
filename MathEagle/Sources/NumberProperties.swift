//
//  NumberProperties.swift
//  MathEagle
//
//  Created by Rugen Heidbuchel on 05/12/15.
//  Copyright © 2015 Jorestha Solutions. All rights reserved.
//


/**
Returns an array containing the digits of the given number from most to least significant digits.

- parameter number:  The number to get the digits of.
*/
public func digits(_ number: Int) -> [Int] {
    
    //TODO: Benchmark this method.
    return "\(abs(number))".characters.map{ Int("\($0)")! }
}

/**
 Returns an array containing the digits of the given big int from most to least significant digits.
 
 - parameter bigInt:  The big int to get the digits of.
 */
public func digits(_ bigInt: BigInt) -> [Int] {
    
    var stringValue = bigInt.stringValue
    
    if stringValue.hasPrefix("-") {
        stringValue.remove(at: stringValue.characters.startIndex)
    }
    
    return stringValue.characters.map{ Int("\($0)")! }
}


/**
 Returns the number of digits of the given number.
 
 - parameter number: The number to get the number of digits of.
*/
public func numberOfDigits(_ number: Int) -> Int {
    
    var n = abs(number)
    
    var nr = 1
    
    while n > 10 {
        
        if n > 100_000_000 {
            nr += 8
            n /= 100_000_000
        }
        if n > 10_000 {
            nr += 4
            n /= 10_000
        }
        if n > 100 {
            nr += 2
            n /= 100
        }
        if n > 10 {
            nr += 1
            n /= 10
        }
    }
    
    return nr
}


/**
Returns whether the given number is pandigital.
 
 - parameter number: The number to check.
 - parameter includeZero: Whether or not zero should be included.
 
 - examples: 12345678 is a pandigital number without zero.
 10234568 is a pandigtal number with zero.
*/
public func isPandigital(_ number: Int, includeZero: Bool = false) -> Bool {
    
    var digitsPassed = Set<Int>()
    
    let digitsArray = digits(number)
    var maximum = digitsArray.count
    
    if includeZero { maximum -= 1 }
    
    for digit in digitsArray {
        
        if digitsPassed.contains(digit) || digit > maximum || (!includeZero && digit == 0) {
            
            return false
        }
        
        digitsPassed.insert(digit)
    }
    
    return true
}
