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
Returns whether the given number is pandigital. This means all it's digits are distinct and
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