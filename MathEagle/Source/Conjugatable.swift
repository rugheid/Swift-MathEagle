//
//  Conjugatable.swift
//  MathEagle
//
//  Created by Rugen Heidbuchel on 18/06/15.
//  Copyright © 2015 Rugen Heidbuchel. All rights reserved.
//



// MARK: Conjugatable Protocol

public protocol Conjugatable {
    
    var conjugate: Self { get }
}

extension Int: Conjugatable {
    
    public var conjugate: Int { return self }
}
extension Int8: Conjugatable {
    
    public var conjugate: Int8 { return self }
}
extension Int16: Conjugatable {
    
    public var conjugate: Int16 { return self }
}
extension Int32: Conjugatable {
    
    public var conjugate: Int32 { return self }
}
extension Int64: Conjugatable {
    
    public var conjugate: Int64 { return self }
}
extension UInt: Conjugatable {
    
    public var conjugate: UInt { return self }
}
extension UInt8: Conjugatable {
    
    public var conjugate: UInt8 { return self }
}
extension UInt16: Conjugatable {
    
    public var conjugate: UInt16 { return self }
}
extension UInt32: Conjugatable {
    
    public var conjugate: UInt32 { return self }
}
extension UInt64: Conjugatable {
    
    public var conjugate: UInt64 { return self }
}
extension Float: Conjugatable {
    
    public var conjugate: Float { return self }
}
extension Double: Conjugatable {
    
    public var conjugate: Double { return self }
}
extension CGFloat: Conjugatable {
    
    public var conjugate: CGFloat { return self }
}
