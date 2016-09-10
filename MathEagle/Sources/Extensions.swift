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
    
    public var isNegative: Bool {
        
        return self < 0
    }
    
    public var isPositive: Bool {
        
        return self >= 0
    }
    
    
    // MARK: Set Compliance
    
    public var isNatural: Bool {
        
        return self.truncatingRemainder(dividingBy: 1.0) == Double(0.0) && self >= 0.0
    }
    
    public var isInteger: Bool {
        
        return self.truncatingRemainder(dividingBy: 1.0) == Double(0.0)
    }
    
    
    // MARK: Fuzzy Equals
    
    public func equals(_ x: Double, accuracy: Double) -> Bool {
        
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
    
    public var isNegative: Bool {
        
        return self < 0
    }
    
    public var isPositive: Bool {
        
        return self >= 0
    }
    
    
    // MARK: Set Compliance
    
    public var isNatural: Bool {
        
        return self.truncatingRemainder(dividingBy: 1.0) == 0.0 && self >= 0.0
    }
    
    public var isInteger: Bool {
        
        return self.truncatingRemainder(dividingBy: 1.0) == 0.0
    }
}



// MARK: CGFloat Extensions

extension CGFloat {
    
    
    // MARK: Basic Properties
    
    public var isNegative: Bool {
        
        return self < 0
    }
    
    public var isPositive: Bool {
        
        return self >= 0
    }
    
    
    // MARK: Set Compliance
    
    public var isNatural: Bool {
        
        return self.truncatingRemainder(dividingBy: 1.0) == 0.0 && self >= 0.0
    }
    
    public var isInteger: Bool {
        
        return self.truncatingRemainder(dividingBy: 1.0) == 0.0
    }
}



// MARK: Int Extensions

extension Int {
    
    
    // MARK: Basic Properties
    
    public var isNegative: Bool {
        
        return self < 0
    }
    
    public var isPositive: Bool {
        
        return self >= 0
    }
    
    
    // MARK: Set Compliance
    
    public var isNatural: Bool {
        
        return !self.isNegative
    }
    
    public var isInteger: Bool {
        
        return true
    }
}



// MARK: Int8 Extensions

extension Int8 {
    
    
    // MARK: Basic Properties
    
    public var isNegative: Bool {
        
        return self < 0
    }
    
    public var isPositive: Bool {
        
        return self >= 0
    }
    
    
    // MARK: Set Compliance
    
    public var isNatural: Bool {
        
        return !self.isNegative
    }
    
    public var isInteger: Bool {
        
        return true
    }
}



// MARK: Int16 Extensions

extension Int16 {
    
    
    // MARK: Basic Properties
    
    public var isNegative: Bool {
        
        return self < 0
    }
    
    public var isPositive: Bool {
        
        return self >= 0
    }
    
    
    // MARK: Set Compliance
    
    public var isNatural: Bool {
        
        return !self.isNegative
    }
    
    public var isInteger: Bool {
        
        return true
    }
}



// MARK: Int32 Extensions

extension Int32 {
    
    
    // MARK: Basic Properties
    
    public var isNegative: Bool {
        
        return self < 0
    }
    
    public var isPositive: Bool {
        
        return self >= 0
    }
    
    
    // MARK: Set Compliance
    
    public var isNatural: Bool {
        
        return !self.isNegative
    }
    
    public var isInteger: Bool {
        
        return true
    }
}



// MARK: Int64 Extensions

extension Int64 {
    
    
    // MARK: Basic Properties
    
    public var isNegative: Bool {
        
        return self < 0
    }
    
    public var isPositive: Bool {
        
        return self >= 0
    }
    
    
    // MARK: Set Compliance
    
    public var isNatural: Bool {
        
        return !self.isNegative
    }
    
    public var isInteger: Bool {
        
        return true
    }
}



// MARK: UInt Extensions

extension UInt {
    
    
    // MARK: Basic Properties
    
    public var isNegative: Bool {
        
        return false
    }
    
    public var isPositive: Bool {
        
        return true
    }
    
    
    // MARK: Set Compliance
    
    public var isNatural: Bool {
        
        return true
    }
    
    public var isInteger: Bool {
        
        return true
    }
}



// MARK: UInt8 Extensions

extension UInt8 {
    
    
    // MARK: Basic Properties
    
    public var isNegative: Bool {
        
        return false
    }
    
    public var isPositive: Bool {
        
        return true
    }
    
    
    // MARK: Set Compliance
    
    public var isNatural: Bool {
        
        return true
    }
    
    public var isInteger: Bool {
        
        return true
    }
}



// MARK: UInt16 Extensions

extension UInt16 {
    
    
    // MARK: Basic Properties
    
    public var isNegative: Bool {
        
        return false
    }
    
    public var isPositive: Bool {
        
        return true
    }
    
    
    // MARK: Set Compliance
    
    public var isNatural: Bool {
        
        return true
    }
    
    public var isInteger: Bool {
        
        return true
    }
}



// MARK: UInt32 Extensions

extension UInt32 {
    
    
    // MARK: Basic Properties
    
    public var isNegative: Bool {
        
        return false
    }
    
    public var isPositive: Bool {
        
        return true
    }
    
    
    // MARK: Set Compliance
    
    public var isNatural: Bool {
        
        return true
    }
    
    public var isInteger: Bool {
        
        return true
    }
}



// MARK: UInt64 Extensions

extension UInt64 {
    
    
    // MARK: Basic Properties
    
    public var isNegative: Bool {
        
        return false
    }
    
    public var isPositive: Bool {
        
        return true
    }
    
    
    // MARK: Set Compliance
    
    public var isNatural: Bool {
        
        return true
    }
    
    public var isInteger: Bool {
        
        return true
    }
}
