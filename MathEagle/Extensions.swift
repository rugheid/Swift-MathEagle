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
    
    
    // MARK: Fuzzy Equals
    
    func equals(x: Double, accuracy: Double) -> Bool {
        
        let absSelf = abs(self)
        let absX = abs(x)
        let diff = abs(absSelf - absX)
        
        if self == x { return true }
        
        return diff < accuracy
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



// MARK: Int8 Extensions

extension Int8 {
    
    
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



// MARK: Int16 Extensions

extension Int16 {
    
    
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



// MARK: Int32 Extensions

extension Int32 {
    
    
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



// MARK: Int64 Extensions

extension Int64 {
    
    
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



// MARK: UInt Extensions

extension UInt {
    
    
    // MARK: Basic Properties
    
    func isNegative() -> Bool {
        
        return false
    }
    
    func isPositive() -> Bool {
        
        return true
    }
    
    
    // MARK: Set Compliance
    
    func isNatural() -> Bool {
        
        return true
    }
    
    func isInteger() -> Bool {
        
        return true
    }
}



// MARK: UInt8 Extensions

extension UInt8 {
    
    
    // MARK: Basic Properties
    
    func isNegative() -> Bool {
        
        return false
    }
    
    func isPositive() -> Bool {
        
        return true
    }
    
    
    // MARK: Set Compliance
    
    func isNatural() -> Bool {
        
        return true
    }
    
    func isInteger() -> Bool {
        
        return true
    }
}



// MARK: UInt16 Extensions

extension UInt16 {
    
    
    // MARK: Basic Properties
    
    func isNegative() -> Bool {
        
        return false
    }
    
    func isPositive() -> Bool {
        
        return true
    }
    
    
    // MARK: Set Compliance
    
    func isNatural() -> Bool {
        
        return true
    }
    
    func isInteger() -> Bool {
        
        return true
    }
}



// MARK: UInt32 Extensions

extension UInt32 {
    
    
    // MARK: Basic Properties
    
    func isNegative() -> Bool {
        
        return false
    }
    
    func isPositive() -> Bool {
        
        return true
    }
    
    
    // MARK: Set Compliance
    
    func isNatural() -> Bool {
        
        return true
    }
    
    func isInteger() -> Bool {
        
        return true
    }
}



// MARK: UInt64 Extensions

extension UInt64 {
    
    
    // MARK: Basic Properties
    
    func isNegative() -> Bool {
        
        return false
    }
    
    func isPositive() -> Bool {
        
        return true
    }
    
    
    // MARK: Set Compliance
    
    func isNatural() -> Bool {
        
        return true
    }
    
    func isInteger() -> Bool {
        
        return true
    }
}