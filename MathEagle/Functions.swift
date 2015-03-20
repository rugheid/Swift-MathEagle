//
//  Functions.swift
//  SwiftMath
//
//  Created by Rugen Heidbuchel on 27/01/15.
//  Copyright (c) 2015 Jorestha Solutions. All rights reserved.
//

import Foundation


/**
    Returns the sign of the given value. Returns -1, 0 or 1.

    :param: x The value to calculate the sign of
    
    :returns:   -1 if the value is smaller than 0, 0 if the value is 0 and 1 if the value is bigger than 0
*/
func sign <X: FullMathValue> (x: X) -> Int {
    
    if x == 0 { return 0 }
    else if x < 0 { return -1 }
    else { return 1 }
}


/**
    Returns the factorial of the given value, aka x!
    
    :param: x The value to caculate the factorial of

    :returns: The factorial of the given value

    :exceptions: Throws an exception if the given value is not a natural number.
*/
func factorial <X: BasicMathValue> (x: X) -> X {
    
    if x < 0 {
        
        NSException(name: "x < 0", reason: "The factorial does not exist for n < 0.", userInfo: nil).raise()
    }
    
    if !x.isInteger {
        
        NSException(name: "x not integer", reason: "The factorial only exists for integers.", userInfo: nil).raise()
    }
    
    if x <= 1 { return 1 }
    
    return x * factorial(x-1)
}