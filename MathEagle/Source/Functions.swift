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
    
    :returns: -1 if the value is smaller than 0, 0 if the value is 0 and 1 if the value is bigger than 0
*/
public func sign <X: protocol<Equatable, Comparable, IntegerLiteralConvertible>> (x: X) -> Int {
    
    if x == 0 { return 0 }
    else if x < 0 { return -1 }
    else { return 1 }
}


/**
    Returns the factorial of the given value, aka x!
    
    :param: x   The value to caculate the factorial of

    :returns: The factorial of the given value

    :exceptions: Throws an exception if the given value is not a natural number.
*/
public func factorial <X: protocol<Comparable, Substractable, Multiplicable, SetCompliant, IntegerLiteralConvertible>> (x: X) -> X {
    
    if x < 0 {
        
        NSException(name: "x < 0", reason: "The factorial does not exist for n < 0.", userInfo: nil).raise()
    }
    
    if !x.isInteger {
        
        NSException(name: "x not integer", reason: "The factorial only exists for integers.", userInfo: nil).raise()
    }
    
    if x <= 1 { return 1 }
    
    return x * factorial(x-1)
}


/**
    Returns an array containing the factorials up to the given value. This means it contains the factorial
    of all values smaller than or equal to the given value. The index in the array corresponds to the argument
    of the factorial, so factorialsUpTo(x)[i] == factorial(i).

    :example: factorialsUpTo(5) returns [1, 1, 2, 6, 24, 120]
*/
public func factorialsUpTo <X: protocol<Comparable, Addable, Substractable, Multiplicable, SetCompliant, IntegerLiteralConvertible>> (x: X) -> [X] {
    
    if x < 0 { return [] }
    
    var factorials: [X] = [1]
    var i: X = 1
    
    while i <= x {
        
        factorials.append(factorials.last! * i)
        
        i = i + 1
    }
    
    return factorials
}


/**
    Returns the n'th Fibonacci number, with fib(0) = 0 and fib(1) = 1
*/
public func fib <X: protocol<Hashable, Addable, Substractable, IntegerLiteralConvertible>> (n: X) -> X {
    
    var memo: [X: X] = [0: 0, 1: 1]
    return memoFib(n, &memo)
}

private func memoFib <X: protocol<Hashable, Addable, Substractable, IntegerLiteralConvertible>> (n: X, inout memo: [X: X]) -> X {
    
    if let answer = memo[n] { return answer }
    
    let answer = memoFib(n-1, &memo) + memoFib(n-2, &memo)
    memo[n] = answer
    
    return answer
}
