//
//  Extensions.swift
//  SwiftMath
//
//  Created by Rugen Heidbuchel on 27/01/15.
//  Copyright (c) 2015 Jorestha Solutions. All rights reserved.
//

import Foundation


// MARK: Double Extensions

extension Double {
    
    
    // MARK: Basic Properties
    
    func isNegative() -> Bool {
        
        return self < 0
    }
    
    func isPositive() -> Bool {
        
        return self >= 0
    }
    
    
    // MARK: Set Compliance
    
    func isNatural() -> Bool {
        
        return self % 1.0 == 0.0 && self >= 0.0
    }
    
    func isInteger() -> Bool {
        
        return self % 1.0 == 0.0
    }
}



// MARK: Float Extensions

extension Float {
    
    
    // MARK: Basic Properties
    
    func isNegative() -> Bool {
        
        return self < 0
    }
    
    func isPositive() -> Bool {
        
        return self >= 0
    }
    
    
    // MARK: Set Compliance
    
    func isNatural() -> Bool {
        
        return self % 1.0 == 0.0 && self >= 0.0
    }
    
    func isInteger() -> Bool {
        
        return self % 1.0 == 0.0
    }
}



// MARK: Int Extensions

extension Int {
    
    
    // MARK: Basic Properties
    
    func isNegative() -> Bool {
        
        return self < 0
    }
    
    func isPositive() -> Bool {
        
        return self >= 0
    }
    
    
    // MARK: Set Compliance
    
    func isNatural() -> Bool {
        
        return !self.isNegative()
    }
    
    func isInteger() -> Bool {
        
        return true
    }
}