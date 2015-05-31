//
//  ArrayGenerators.swift
//  MathEagle
//
//  Created by Rugen Heidbuchel on 31/05/15.
//  Copyright (c) 2015 Jorestha Solutions. All rights reserved.
//

import Foundation


/**
    Returns an array of the given length. The first element is the given initial value.
    Following elements will be incremented by increment.

    :example: rampedArray(initialValue: 2, increment: 3, length: 4) will return
                [2, 5, 8, 11]
*/
public func rampedArray <T: Addable> (#initialValue: T, #increment: T, #length: Int) -> [T] {
    
    var array = [T]()
    
    var element = initialValue
    
    for _ in 0 ..< length {
        array.append(element)
        element = element + increment
    }
    
    return array
}