//
//  BigInt.swift
//  MathEagle
//
//  Created by Rugen Heidbuchel on 13/12/15.
//  Copyright © 2015 Jorestha Solutions. All rights reserved.
//

import Foundation

public class BigInt: BigInt_OBJC {
    
    
    // MARK: Initialisers
    
    public override init() {
        super.init()
    }
    
    public init(int: Int) {
        super.init(long: int)
    }
    
    public init(uint: UInt) {
        super.init(unsignedLong: uint)
    }
    
    public override init(double: Double) {
        super.init(double: double)
    }
    
    public init(string: String, base: Int32 = 10) {
        super.init(string: string.cStringUsingEncoding(NSUTF8StringEncoding)!, inBase: base)
    }
    
    
    // MARK: Conversions
    
    public var intValue: Int {
        return super.getLongValue()
    }
    
    public var uintValue: UInt {
        return super.getUnsignedLongValue()
    }
    
    public var doubleValue: Double {
        return super.getDoubleValue()
    }
    
    public var stringValue: String {
        return stringValue()
    }
    
    public func stringValue(base: Int32 = 10) -> String {
        return String(CString: super.getStringValueInBase(base), encoding: NSUTF8StringEncoding)!
    }
}