//
//  Functions.swift
//  SwiftMath
//
//  Created by Rugen Heidbuchel on 27/01/15.
//  Copyright (c) 2015 Jorestha Solutions. All rights reserved.
//

import Foundation


// MARK: Sign

func sign <X: FullMathValue> (x: X) -> Int {
    
    if x == 0 { return 0 }
    else if x < 0 { return -1 }
    else { return 1 }
}


// MARK: Factorial

func factorial(x: Int) -> Int {
    
    if x < 0 {
        
        NSException(name: "x < 0", reason: "The factorial does not exist for n < 0.", userInfo: nil).raise()
    }
    
    if x <= 1 { return 1 }
    
    return x * factorial(x-1)
}

func factorial(x: UInt) -> UInt {
    
    if x < 0 {
        
        NSException(name: "x < 0", reason: "The factorial does not exist for n < 0.", userInfo: nil).raise()
    }
    
    if x <= 1 { return 1 }
    
    return x * factorial(x-1)
}

func factorial(x: UInt8) -> UInt8 {
    
    if x < 0 {
        
        NSException(name: "x < 0", reason: "The factorial does not exist for n < 0.", userInfo: nil).raise()
    }
    
    if x <= 1 { return 1 }
    
    return x * factorial(x-1)
}

func factorial(x: UInt16) -> UInt16 {
    
    if x < 0 {
        
        NSException(name: "x < 0", reason: "The factorial does not exist for n < 0.", userInfo: nil).raise()
    }
    
    if x <= 1 { return 1 }
    
    return x * factorial(x-1)
}

func factorial(x: UInt32) -> UInt32 {
    
    if x < 0 {
        
        NSException(name: "x < 0", reason: "The factorial does not exist for n < 0.", userInfo: nil).raise()
    }
    
    if x <= 1 { return 1 }
    
    return x * factorial(x-1)
}

func factorial(x: UInt64) -> UInt64 {
    
    if x < 0 {
        
        NSException(name: "x < 0", reason: "The factorial does not exist for n < 0.", userInfo: nil).raise()
    }
    
    if x <= 1 { return 1 }
    
    return x * factorial(x-1)
}

func factorial(x: Float) -> Float {
    
    if x < 0 {
        
        NSException(name: "x < 0", reason: "The factorial does not exist for n < 0.", userInfo: nil).raise()
    }
    
//    if 
    
    if x <= 1 { return 1 }
    
    return x * factorial(x-1)
}