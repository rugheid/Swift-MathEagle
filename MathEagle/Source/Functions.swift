//
//  Functions.swift
//  SwiftMath
//
//  Created by Rugen Heidbuchel on 27/01/15.
//  Copyright (c) 2015 Jorestha Solutions. All rights reserved.
//

import Foundation
import Accelerate


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



// MARK: Sequence Functions

/**
    Returns the sum of all elements in the sequence.

    :param: seq The sequence to sum.

    :returns: The sum of all elements in the sequence. When the sequence is
                empty zero is returned.
*/
public func sum <S: SequenceType where S.Generator.Element: protocol<Addable, IntegerLiteralConvertible>> (seq: S) -> S.Generator.Element {
    
    return reduce(seq, 0){ $0 + $1 }
}

/**
    Returns the sum of all elements in the array.

    :param: seq The array to sum.

    :returns: The sum of all elements in the array. When the array is empty
                zero is returned.
*/
public func sum(seq: [Float]) -> Float {
    
    var result: Float = 0
    vDSP_sve(seq, 1, &result, vDSP_Length(seq.count))
    return result
}

/**
    Returns the sum of all elements in the vector.

    :param: vector  The vector to sum.

    :returns: The sum of all elements in the vector. When the vector is empty
                zero is returned.
*/
public func sum(vector: Vector<Float>) -> Float {
    return sum(vector.elements)
}

/**
    Returns the sum of all elements in the array.

    :param: seq The array to sum.

    :returns: The sum of all elements in the array. When the array is empty
                zero is returned.
*/
public func sum(seq: [Double]) -> Double {
    
    var result: Double = 0
    vDSP_sveD(seq, 1, &result, vDSP_Length(seq.count))
    return result
}

/**
    Returns the sum of all elements in the vector.

    :param: vector  The vector to sum.

    :returns: The sum of all elements in the vector. When the vector is empty
                zero is returned.
*/
public func sum(vector: Vector<Double>) -> Double {
    return sum(vector.elements)
}


/**
    Returns the product of all elements in the sequence.
    
    :param: seq The sequence to take the product of.
*/
public func product <S: SequenceType where S.Generator.Element: protocol<Multiplicable, IntegerLiteralConvertible>> (seq: S) -> S.Generator.Element {
    
    return reduce(seq, 1){ $0 * $1 }
}


/**
    Returns the minimal element in the given sequence.

    :param: seq The sequence to get the minimum of.

    :returns: The minimum value of the given sequence.

    :exception: Throws an exception when the given sequence is empty.
*/
public func min <S: SequenceType where S.Generator.Element: protocol<Comparable, IntegerLiteralConvertible>> (seq: S) -> S.Generator.Element {
    
    var generator = seq.generate()
    if let initial = generator.next() {
        return reduce(seq, initial){ $0 < $1 ? $0 : $1 }
    } else {
        NSException(name: "Empty array", reason: "Can't compute minimum of an empty array.", userInfo: nil).raise()
        return 0
    }
}

/**
    Returns the minimal element in the given sequence.

    :param: seq The sequence to get the minimum of.

    :returns: The minimum value of the given sequence.

    :exception: Throws an exception when the given sequence is empty.
*/
public func min(seq: [Float]) -> Float {
    
    if seq.count == 0 {
        NSException(name: "Empty array", reason: "Can't compute minimum of an empty array.", userInfo: nil).raise()
    }
    
    var result: Float = 0
    vDSP_minv(seq, 1, &result, vDSP_Length(seq.count))
    return result
}

/**
    Returns the minimal element in the given vector.

    :param: vector  The vector to get the minimum of.

    :returns: The minimum value of the given vector.

    :exception: Throws an exception when the given vector is empty.
*/
public func min(vector: Vector<Float>) -> Float {
    
    return min(vector.elements)
}


/**
    Returns the maximal element in the given sequence.

    :param: seq The sequence to get the maximum of.
*/
public func max <S: SequenceType where S.Generator.Element: protocol<Comparable, IntegerLiteralConvertible>> (seq: S) -> S.Generator.Element {
    
    var generator = seq.generate()
    let initial = generator.next()!
    return reduce(seq, initial){ $0 > $1 ? $0 : $1 }
}