//
//  Random.swift
//  MathEagle
//
//  Created by Rugen Heidbuchel on 01/04/15.
//  Copyright (c) 2015 Jorestha Solutions. All rights reserved.
//

import Foundation



// MARK: Randomizable Protocol

protocol Randomizable {
    
    class func random() -> Self
}



// MARK: Conformance extensions

extension UInt: Randomizable {
    
    static func random() -> UInt {
        
        return UInt(arc4random())
    }
}

extension Int: Randomizable {
    
    static func random() -> Int {
        
        let sign = arc4random_uniform(2) == 0 ? 1 : -1
        return Int(arc4random()) * sign
    }
}

extension Float: Randomizable {
    
    static func random() -> Float {
        
        let sign: Float = arc4random_uniform(2) == 0 ? 1 : -1
        return Float(arc4random()) * sign
    }
}

extension Double: Randomizable {
    
    static func random() -> Double {
        
        let sign: Double = arc4random_uniform(2) == 0 ? 1 : -1
        return Double(arc4random()) * sign
    }
}