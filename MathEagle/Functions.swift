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
func sign <X: protocol<Equatable, Comparable, IntegerLiteralConvertible>> (x: X) -> Int {
    
    if x == 0 { return 0 }
    else if x < 0 { return -1 }
    else { return 1 }
}


/**
    Returns the divisors of the given value, sorted from smaller values to larger values.
    The value itself is included.
    An empty list will be returned for values smaller than or equal to zero.

    :param: x The value to calculate the divisors of

    :returns: The divisors of the given value, sorted from smaller values to larger values. The value itself is included.

    :example: divisors(10) returns [1, 2, 5, 10]
*/
func divisors <X: protocol<Equatable, Comparable, Modulable, Dividable, Powerable, IntegerLiteralConvertible> where X.PowerType: protocol<Comparable, Addable, IntegerLiteralConvertible>> (x: X) -> [X] {
    
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
func properDivisors <X: protocol<Equatable, Comparable, Modulable, Dividable, Powerable, IntegerLiteralConvertible> where X.PowerType: protocol<Comparable, Addable, IntegerLiteralConvertible>> (x: X) -> [X] {
    
    if x <= 1 { return [] }
    
    var div: [X] = [1]
    
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
    Returns whether the given number is a perfect number. This means the sum of it's proper divisors equals the number itself.

    :param: x The number to check

    :returns: true if the given number is a perfect number.
*/
func isPerfect <X: protocol<Equatable, Comparable, Addable, Modulable, Dividable, Powerable, IntegerLiteralConvertible> where X.PowerType: protocol<Comparable, Addable, IntegerLiteralConvertible>> (x: X) -> Bool {
    
    var zero: X = 0
    let sum = reduce(properDivisors(x), zero){ $0 + $1 }
    
    return sum == x
}


/**
    Returns the greatest common divisor of the two given numbers.

    :param: a The first number
    :param: b The second number

    :returns: The greatest common divisor of the two given numbers. When either a or b equals 0, 1 is returned.
*/
func gcd <X: protocol<Equatable, Modulable, IntegerLiteralConvertible>> (var a: X, var b: X) -> X {
    
    if a == 0 || b == 0 { return a == 0 ? b : a }
    
    while b != 0 {
        
        let temp = b
        b = a % b
        a = temp
    }
    
    return a
}


/**
    Returns the factorial of the given value, aka x!
    
    :param: x The value to caculate the factorial of

    :returns: The factorial of the given value

    :exceptions: Throws an exception if the given value is not a natural number.
*/
func factorial <X: protocol<Comparable, Substractable, Multiplicable, SetCompliant, IntegerLiteralConvertible>> (x: X) -> X {
    
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
    Returns the n'th Fibonacci number, with fib(0) = 0 and fib(1) = 1
*/
func fib <X: protocol<Hashable, Addable, Substractable, IntegerLiteralConvertible>> (n: X) -> X {
    
    var memo: [X: X] = [0: 0, 1: 1]
    return memoFib(n, &memo)
}

private func memoFib <X: protocol<Hashable, Addable, Substractable, IntegerLiteralConvertible>> (n: X, inout memo: [X: X]) -> X {
    
    if let answer = memo[n] { return answer }
    
    let answer = memoFib(n-1, &memo) + memoFib(n-2, &memo)
    memo[n] = answer
    
    return answer
}



// MARK: Sequence Functions

/**
    Returns the sum of all elements in the sequence.

    :param: seq The sequence to sum.
*/
func sum <S: SequenceType where S.Generator.Element: protocol<Addable, IntegerLiteralConvertible>> (seq: S) -> S.Generator.Element {
    
    return reduce(seq, 0){ $0 + $1 }
}


/**
    Returns the product of all elements in the sequence.
    
    :param: seq The sequence to take the product of.
*/
func product <S: SequenceType where S.Generator.Element: protocol<Multiplicable, IntegerLiteralConvertible>> (seq: S) -> S.Generator.Element {
    
    return reduce(seq, 1){ $0 * $1 }
}