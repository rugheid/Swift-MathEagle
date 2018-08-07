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

    - parameter x: The value to calculate the sign of
    
    - returns: -1 if the value is smaller than 0, 0 if the value is 0 and 1 if the value is bigger than 0
*/
public func sign <X: Equatable & Comparable & ExpressibleByIntegerLiteral> (_ x: X) -> Int {
    
    if x == 0 { return 0 }
    else if x < 0 { return -1 }
    else { return 1 }
}


/**
 Returns the absolute value of the given value.
 
 - parameter x: The value to get the absolute value from.
 */
public func abs <X: Equatable & Comparable & ExpressibleByIntegerLiteral & Negatable> (_ x: X) -> X {
    let sgn = sign(x)
    if sgn == 0 {
        return 0
    } else if sgn == -1 {
        return -x
    } else {
        return x
    }
}


/**
    Returns the factorial of the given value, aka x!
    
    - parameter x:   The value to caculate the factorial of

    - returns: The factorial of the given value

    :exceptions: Throws an exception if the given value is not a natural number.
*/
public func factorial <X: Comparable & Addable & Subtractable & Multiplicable & SetCompliant & ExpressibleByIntegerLiteral> (_ x: X) -> X {
    
    if x < 0 {
        
        NSException(name: NSExceptionName(rawValue: "x < 0"), reason: "The factorial does not exist for n < 0.", userInfo: nil).raise()
    }
    
    if !x.isInteger {
        
        NSException(name: NSExceptionName(rawValue: "x not integer"), reason: "The factorial only exists for integers.", userInfo: nil).raise()
    }
    
    if x <= 1 { return 1 }
    
    var result: X = 1
    var mult: X = 2
    
    while mult <= x {
        
        result = result * mult
        mult += 1
    }
    
    return result
    
//    if x <= 1 { return 1 }
//    
//    return x * factorial(x-1)
}


/**
    Returns an array containing the factorials up to the given value. This means it contains the factorial
    of all values smaller than or equal to the given value. The index in the array corresponds to the argument
    of the factorial, so factorialsUpTo(x)[i] == factorial(i).

    :example: factorialsUpTo(5) returns [1, 1, 2, 6, 24, 120]
*/
public func factorialsUpTo <X: Comparable & Addable & Subtractable & Multiplicable & SetCompliant & ExpressibleByIntegerLiteral> (_ x: X) -> [X] {
    
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
public func fib <X: Hashable & Addable & Subtractable & ExpressibleByIntegerLiteral> (_ n: X) -> X {
    
    var memo: [X: X] = [0: 0, 1: 1]
    return memoFib(n, memo: &memo)
}

private func memoFib <X: Hashable & Addable & Subtractable & ExpressibleByIntegerLiteral> (_ n: X, memo: inout [X: X]) -> X {
    
    if let answer = memo[n] { return answer }
    
    let answer = memoFib(n-1, memo: &memo) + memoFib(n-2, memo: &memo)
    memo[n] = answer
    
    return answer
}


/**
 Returns the gamma function, evaluated in the given point, with the given precision.
 
 - parameter z: The point to evaluate the gamma function in.
 - parameter precision: The number of fractional digits required.
*/
public func gamma(_ z: Double, precision n: Int = 7) -> Double {
    // Some theory used from http://en.literateprograms.org/Gamma_function_with_Spouge's_formula_(Mathematica)
    
    // TODO: Benchmark this method + add checks for natural and half natural numbers
    
    var x = z
    x -= 1.0
    
    let a = Int(ceil(1.26 * Double(n)))
    
    var sum = 1.0
    
    for k in 1 ..< a {
        
        var c = Double(a - k) ** (Double(k) - 0.5)
        c *= exp(Double(a - k))
        c /= sqrt(2.0 * PI) * Double(factorial(k-1))
        
        if k % 2 == 0 { c *= -1 }
        
        sum += c / (x + Double(k))
    }
    
    sum *= (x + Double(a)) ** (x + 0.5)
    sum *= exp(-(x + Double(a)))
    sum *= sqrt(2.0 * PI)
    
    return sum
}


/**
 Returns the Euler totient (aka Euler phi) function for the given n.
 
 - parameter n: The number to get the euler totient function for
 */
public func eulerTotient <X: Multiplicable & Negatable & Subtractable & Addable & Equatable & Comparable & Modulable & Dividable & ExpressibleByIntegerLiteral> (_ nRaw: X) -> X {
    
    var n = abs(nRaw)
    var result = n
    
    var p: X = 2
    while p*p <= n {
        if (n % p == 0) {
            while (n % p == 0) {
                n = n / p
            }
            result = result - result / p
        }
        p += 1
    }
    
    if (n > 1) {
        result = result - result / n
    }
    
    return result
}
