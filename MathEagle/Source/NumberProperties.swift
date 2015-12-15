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
public func digits(number: Int) -> [Int] {
    
    //TODO: Benchmark this method.
    return "\(abs(number))".characters.map{ Int("\($0)")! }
}

/**
 Returns an array containing the digits of the given big int from most to least significant digits.
 
 - parameter bigInt:  The big int to get the digits of.
 */
public func digits(bigInt: BigInt) -> [Int] {
    
    var stringValue = bigInt.stringValue
    
    if stringValue.hasPrefix("-") {
        stringValue.removeAtIndex(stringValue.characters.startIndex)
    }
    
    return stringValue.characters.map{ Int("\($0)")! }
}


/**
 Returns the number of digits of the given number.
 
 - parameter number: The number to get the number of digits of.
*/
public func numberOfDigits(var number: Int) -> Int {
    
    number = abs(number)
    
    var n = 1
    
    while number > 10 {
        
        if number > 100_000_000 {
            n += 8
            number /= 100_000_000
        }
        if number > 10_000 {
            n += 4
            number /= 10_000
        }
        if number > 100 {
            n += 2
            number /= 100
        }
        if number > 10 {
            n += 1
            number /= 10
        }
    }
    
    return n
}


/**
Returns whether the given number is pandigital.
 
 - parameter number: The number to check.
 - parameter includeZero: Whether or not zero should be included.
 
 - examples: 12345678 is a pandigital number without zero.
 10234568 is a pandigtal number with zero.
*/
public func isPandigital(number: Int, includeZero: Bool = false) -> Bool {
    
    var digitsPassed = Set<Int>()
    
    let digitsArray = digits(number)
    var max = digitsArray.count
    
    if includeZero { max-- }
    
    for digit in digitsArray {
        
        if digitsPassed.contains(digit) || digit > max || (!includeZero && digit == 0) {
            
            return false
        }
        
        digitsPassed.insert(digit)
    }
    
    return true
}