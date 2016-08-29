//
//  SequenceFunctions.swift
//  MathEagle
//
//  Created by Rugen Heidbuchel on 08/06/15.
//  Copyright (c) 2015 Jorestha Solutions. All rights reserved.
//

import Accelerate



// MARK: Sum

/**
    Returns the sum of all elements in the sequence.

    - parameter seq: The sequence to sum.

    - returns: The sum of all elements in the sequence. When the sequence is
                empty zero is returned.
*/
public func sum <S: SequenceType where S.Generator.Element: protocol<Addable, IntegerLiteralConvertible>> (seq: S) -> S.Generator.Element {
    
    return seq.reduce(0){ $0 + $1 }
}


/**
Returns the sum of all elements in the array.

- parameter seq: The array to sum.

- returns: The sum of all elements in the array. When the array is empty
zero is returned.
*/
public func sum(seq: [Float]) -> Float {
    
    var result: Float = 0
    vDSP_sve(seq, 1, &result, vDSP_Length(seq.count))
    return result
}


/**
Returns the sum of all elements in the vector.

- parameter vector:  The vector to sum.

- returns: The sum of all elements in the vector. When the vector is empty
zero is returned.
*/
public func sum(vector: Vector<Float>) -> Float {
    return sum(vector.elements)
}

/**
Returns the sum of all elements in the array.

- parameter seq: The array to sum.

- returns: The sum of all elements in the array. When the array is empty
zero is returned.
*/
public func sum(seq: [Double]) -> Double {
    
    var result: Double = 0
    vDSP_sveD(seq, 1, &result, vDSP_Length(seq.count))
    return result
}

/**
Returns the sum of all elements in the vector.

- parameter vector:  The vector to sum.

- returns: The sum of all elements in the vector. When the vector is empty
zero is returned.
*/
public func sum(vector: Vector<Double>) -> Double {
    return sum(vector.elements)
}



// MARK: Product


/**
Returns the product of all elements in the sequence.

- parameter seq: The sequence to take the product of.
*/
public func product <S: SequenceType where S.Generator.Element: protocol<Multiplicable, IntegerLiteralConvertible>> (seq: S) -> S.Generator.Element {
    
    return seq.reduce(1){ $0 * $1 }
}



// MARK: Min


/**
Returns the minimal element in the given sequence.

- parameter seq: The sequence to get the minimum of.

- returns: The minimum value of the given sequence.

:exception: Throws an exception when the given sequence is empty.
*/
public func min <S: SequenceType where S.Generator.Element: protocol<Comparable, IntegerLiteralConvertible>> (seq: S) -> S.Generator.Element {
    
    var generator = seq.generate()
    if let initial = generator.next() {
        return seq.reduce(initial){ $0 < $1 ? $0 : $1 }
    } else {
        NSException(name: "Empty array", reason: "Can't compute minimum of an empty array.", userInfo: nil).raise()
        return 0
    }
}

/**
Returns the minimal element in the given sequence.

- parameter seq: The sequence to get the minimum of.

- returns: The minimum value of the given sequence.

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

- parameter vector:  The vector to get the minimum of.

- returns: The minimum value of the given vector.

:exception: Throws an exception when the given vector is empty.
*/
public func min(vector: Vector<Float>) -> Float {
    
    return min(vector.elements)
}



// MARK: Max


/**
Returns the maximal element in the given sequence.

- parameter seq: The sequence to get the maximum of.
*/
public func max <S: SequenceType where S.Generator.Element: protocol<Comparable, IntegerLiteralConvertible>> (seq: S) -> S.Generator.Element {
    
    var generator = seq.generate()
    let initial = generator.next()!
    return seq.reduce(initial){ $0 > $1 ? $0 : $1 }
}