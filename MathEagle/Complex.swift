//
//  Complex.swift
//  MathEagle
//
//  Created by Rugen Heidbuchel on 05/03/15.
//  Copyright (c) 2015 Jorestha Solutions. All rights reserved.
//

import Foundation

struct Complex: Equatable, Addable, Negatable, Substractable, Multiplicable, Dividable, IntegerLiteralConvertible {
    
    var real: Double
    var imaginary: Double
    
    
    // MARK: Initialisation
    
    init(_ real: Double, _ imaginary: Double) {
        
        self.real = real
        self.imaginary = imaginary
    }
    
    init(modulus: Double, argument: Double) {
        
        self.real = modulus * cos(argument)
        self.imaginary = modulus * sin(argument)
    }
    
    init(integerLiteral value: IntegerLiteralType) {
        
        self.real = Double(value)
        self.imaginary = 0
    }
    
    static var imaginaryUnit: Complex {
        
        return Complex(0, 1)
    }
    
    
    // MARK: Basic Properties
    
    var modulus: Double {
        
        return sqrt(self.real**2 + self.imaginary**2)
    }
    
    var argument: Double {
        
        return atan(self.imaginary / self.real)
    }
    
}



// MARK: Function Extensions

func exp(z: Complex) -> Complex {
    
    let c = exp(z.real)
    return Complex(c * cos(z.imaginary), c * sin(z.imaginary))
}



// MARK: Equatable Protocol Conformance

func == (left: Complex, right: Complex) -> Bool {
    
    return left.real == right.real && left.imaginary == right.imaginary
}



// MARK: Addable Protocol Conformance

func + (left: Complex, right: Complex) -> Complex {
    
    return Complex(left.real + right.real, left.imaginary + right.imaginary)
}



// MARK: Negatable Protocol Conformance

prefix func - (z: Complex) -> Complex {
    
    return Complex(-z.real, -z.imaginary)
}



// MARK: Substractable Protocol Conformance

func - (left: Complex, right: Complex) -> Complex {
    
    return left + -right
}



// MARK: Multiplicable Protocol Conformance

func * (left: Complex, right: Complex) -> Complex {
    
    return Complex(left.real * right.real - left.imaginary * right.imaginary, left.real * right.imaginary + left.imaginary * right.real)
}



// MARK: Dividable Protocol Conformance

func / (left: Complex, right: Complex) -> Complex {
    
    let d = right.real**2 + right.imaginary**2
    return Complex((left.real * right.real + left.imaginary * right.imaginary) / d, (left.imaginary * right.real - left.real * right.imaginary) / d)
}