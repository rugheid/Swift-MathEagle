//
//  Fraction.swift
//  MathEagle
//
//  Created by Rugen Heidbuchel on 20/04/16.
//  Copyright © 2016 Jorestha Solutions. All rights reserved.
//

public struct Fraction: CustomStringConvertible {
    
    // MARK: Properties
    
    // TODO: Add checks as willSet?
    public var numerator: Int
    public var denominator: Int
    
    // MARK: Init
    
    public init(numerator: Int, denominator: Int) {
        
        if denominator == 0 {
            NSException(name: NSExceptionName(rawValue: "Zero Denominator"), reason: "The denominator of a Fraction can't be zero.", userInfo: nil).raise()
        }
        
        self.numerator = numerator
        self.denominator = denominator
    }
    
    public init(string: String) {
        
        let components = string.components(separatedBy: "/")
        
        if components.count == 1 {
            self.numerator = Int(components.first!)!
            self.denominator = 1
        } else if components.count == 2 {
            self.numerator = Int(components.first!)!
            self.denominator = Int(components[1])!
        } else {
            NSException(name: NSExceptionName(rawValue: "Wrong format"), reason: "The string provided for the fraction was not of proper format.", userInfo: nil).raise()
            fatalError()
        }
    }
    
    // MARK: Basic Methods
    
    /**
     Canonicalizes the fraction. This means the denominator will never be negative and zero will be
     represented as 0/1.
     */
    public mutating func canonicalize() {
        
        if self.denominator.isNegative {
            self.numerator *= -1
            self.denominator *= -1
        }
        
        if self.numerator == 0 {
            self.denominator = 1
        }
        
        let g = gcd(self.denominator, self.numerator)
        self.numerator /= g
        self.denominator /= g
    }
    
    // MARK: Basic Properties
    
    /**
     Returns a description for the fraction. This is in the form <numerator>/<denominator>.
     The fraction will not be canonicalized first.
     */
    public var description: String {
        return "\(self.numerator)/\(self.denominator)"
    }
    
    /**
     Returns the double value of the fraction.
     */
    public var doubleValue: Double {
        return Double(self.numerator) / Double(self.denominator)
    }
}
