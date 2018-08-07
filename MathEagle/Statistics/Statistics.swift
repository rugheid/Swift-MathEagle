//
//  Statistics.swift
//  MathEagle
//
//  Created by Kelly Roach on 8/5/18.
//  Copyright © 2018 Jorestha Solutions. All rights reserved.
//

import Foundation

// NOTE: Swift's own "extension Array where Element : Comparable" gets us
// ".max()" and ".min()" .  Which have to be forced unwrapped with "!".  :-(

extension Array where Element: FloatingPoint {
    public func sum() -> Element {
        return self.reduce(0, +)
    }
    public func mean() -> Element {
        // "mu"
        return self.sum()/Element(self.count)
    }
    public func variance() -> Element {
        // "sigma^2"
        let mean = self.mean()
        return self.reduce(0, { $0+($1-mean)*($1-mean) })
    }
    public func stddev() -> Element {
        // "sigma"
        return sqrt(self.variance()/(Element(self.count)))
    }
    public func unbiased_stddev() -> Element {
        // "s"
        return sqrt(self.variance()/((Element(self.count)-1)))
    }
}

public protocol ComplexElement {
    init(_ real: Double, _ imaginary: Double)
    static func + (left: Self, right: Self) -> Self
    static func / (left: Self, right: Self) -> Self
}
extension Complex: ComplexElement {}
extension Array where Element: ComplexElement {
    public func sum() -> Element {
        return self.reduce(Element(0,0), +)
    }
    public func mean() -> Element {
        // "mu"
        return self.sum()/Element(Double(self.count),0)
    }
}

public protocol DoubleCastable {
    var asDouble: Double { get }
    init(_: Double)
}
extension Int: DoubleCastable {public var asDouble: Double { get {return Double(self)}}}
extension Int8: DoubleCastable {public var asDouble: Double { get {return Double(self)}}}
extension Int16: DoubleCastable {public var asDouble: Double { get {return Double(self)}}}
extension Int32: DoubleCastable {public var asDouble: Double { get {return Double(self)}}}
extension Int64: DoubleCastable {public var asDouble: Double { get {return Double(self)}}}
extension UInt: DoubleCastable {public var asDouble: Double { get {return Double(self)}}}
extension UInt8: DoubleCastable {public var asDouble: Double { get {return Double(self)}}}
extension UInt16: DoubleCastable {public var asDouble: Double { get {return Double(self)}}}
extension UInt32: DoubleCastable {public var asDouble: Double { get {return Double(self)}}}
extension UInt64: DoubleCastable {public var asDouble: Double { get {return Double(self)}}}

// For our applications (e.g. RandomTests.swift) which involve long arrays
// of small integers (e.g. Int8), we can't use sum() -> Int8 etc.,
// so we'll cast such arrays to [Double] before computing statistcs.
extension Array where Element: DoubleCastable {
    public func asDoubleArray() -> [Double] {
        return (self.map { $0.asDouble })
    }
}
