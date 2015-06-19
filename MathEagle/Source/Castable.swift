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
extension UInt: IntCastable {
    public var asInt: Int {
        return Int(self)
    }
}