//
//  Castable.swift
//  MathEagle
//
//  Created by Rugen Heidbuchel on 19/06/15.
//  Copyright © 2015 Jorestha Solutions. All rights reserved.
//

import Foundation


// MARK: IntCastable

public protocol IntCastable {
    var asInt: Int { get }
}

extension Int: IntCastable {
    public var asInt: Int {
        return self
    }
}
extension Int8: IntCastable {
    public var asInt: Int {
        return Int(self)
    }
}
extension Int16: IntCastable {
    public var asInt: Int {
        return Int(self)
    }
}
extension Int32: IntCastable {
    public var asInt: Int {
        return Int(self)
    }
}
extension Int64: IntCastable {
    public var asInt: Int {
        return Int(self)
    }
}
extension UInt: IntCastable {
    public var asInt: Int {
        return Int(self)
    }
}
extension UInt8: IntCastable {
    public var asInt: Int {
        return Int(self)
    }
}
extension UInt16: IntCastable {
    public var asInt: Int {
        return Int(self)
    }
}
extension UInt32: IntCastable {
    public var asInt: Int {
        return Int(self)
    }
}
extension UInt64: IntCastable {
    public var asInt: Int {
        return Int(self)
    }
}
extension Float: IntCastable {
    public var asInt: Int {
        return Int(self)
    }
}
extension Double: IntCastable {
    public var asInt: Int {
        return Int(self)
    }
}