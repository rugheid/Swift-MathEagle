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
 
 - parameter length: The number of elements the array should have.
 - parameter initialValue: The first value of the array. Default 0.
 - parameter increment: The difference between two adjecent elements. Default 1.
 
 :example: rampedArray(length: 4, initialValue: 2, increment: 3) will return
 [2, 5, 8, 11]
*/
public func rampedArray <T: ExpressibleByIntegerLiteral & Addable> (length: Int, initialValue: T = 0, increment: T = 1) -> [T] {
    
    var array = [T]()
    
    var element = initialValue
    
    for _ in 0 ..< length {
        array.append(element)
        element = element + increment
    }
    
    return array
}
