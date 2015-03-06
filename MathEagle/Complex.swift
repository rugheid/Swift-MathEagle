//
//  Complex.swift
//  MathEagle
//
//  Created by Rugen Heidbuchel on 05/03/15.
//  Copyright (c) 2015 Jorestha Solutions. All rights reserved.
//

import Foundation

struct Complex: Equatable, Addable, Negatable, Substractable, Multiplicable, Dividable, IntegerLiteralConvertible, Printable {
    
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
        
        return atan(self.imaginary / self.real) + (self.quadrant.rawValue >= 3 ? PI : 0)
    }
    
    var quadrant: Quadrant {
        
        if self.real >= 0 {
            
            return self.imaginary >= 0 ? .First : .Fourth
            
        } else {
            
            return self.imaginary >= 0 ? .Second : .Third
        }
    }
    
    var description: String {
        
        return "\(self.real) + \(self.imaginary)i"
    }
    
    
    // MARK: Fuzzy Equality
    
    func equals(z: Complex) -> Bool {
        
        return self.real == self.real && self.imaginary == z.imaginary
    }
    
    
    func equals(z: Complex, accuracy: Double) -> Bool {
        
        return self.real.equals(z.real, accuracy: accuracy) && self.imaginary.equals(z.imaginary, accuracy: accuracy)
    }
    
}



// MARK: Function Extensions

func exp(z: Complex) -> Complex {
    
    let c = exp(z.real)
    return Complex(c * cos(z.imaginary), c * sin(z.imaginary))
}



// MARK: Equatable Protocol Conformance

func == (left: Complex, right: Complex) -> Bool {
    
    return left.equals(right)
}

func == (left: Double, right: Complex) -> Bool {
    
    return left == right.real && right.imaginary == 0.0
}

func == (left: Complex, right: Double) -> Bool {
    
    return right == left
}



// MARK: Addable Protocol Conformance

func + (left: Complex, right: Complex) -> Complex {
    
    return Complex(left.real + right.real, left.imaginary + right.imaginary)
}

func + (left: Double, right: Complex) -> Complex {
    
    return Complex(left + right.real, right.imaginary)
}

func + (left: Complex, right: Double) -> Complex {
    
    return right + left
}



// MARK: Negatable Protocol Conformance

prefix func - (z: Complex) -> Complex {
    
    return Complex(-z.real, -z.imaginary)
}



// MARK: Substractable Protocol Conformance

func - (left: Complex, right: Complex) -> Complex {
    
    return Complex(left.real - right.real, left.imaginary - right.imaginary)
}

func - (left: Double, right: Complex) -> Complex {
    
    return Complex(left - right.real, -right.imaginary)
}

func - (left: Complex, right: Double) -> Complex {
    
    return Complex(left.real - right, left.imaginary)
}



// MARK: Multiplicable Protocol Conformance

func * (left: Complex, right: Complex) -> Complex {
    
    return Complex(left.real * right.real - left.imaginary * right.imaginary, left.real * right.imaginary + left.imaginary * right.real)
}

func * (left: Double, right: Complex) -> Complex {
    
    return Complex(left * right.real, left * right.imaginary)
}

func * (left: Complex, right: Double) -> Complex {
    
    return right * left
}



// MARK: Dividable Protocol Conformance

func / (left: Complex, right: Complex) -> Complex {
    
    let d = right.real**2 + right.imaginary**2
    return Complex((left.real * right.real + left.imaginary * right.imaginary) / d, (left.imaginary * right.real - left.real * right.imaginary) / d)
}

func / (left: Double, right: Complex) -> Complex {
    
    let d = right.real**2 + right.imaginary**2
    return Complex((left * right.real) / d, (-left * right.imaginary) / d)
}

func / (left: Complex, right: Double) -> Complex {
    
    return Complex(left.real / right, left.imaginary / right)
}



// MARK: Powers

func ** (left: Complex, right: Complex) -> Complex {
    
    return Complex(0, 0)
}

func ** (left: Double, right: Complex) -> Complex {
    
    return Complex(modulus: left ** right.real, argument: log(left) * right.imaginary)
}

func ** (left: Complex, right: Double) -> Complex {
    
    return Complex(modulus: left.modulus ** right, argument: right * left.argument)
}





// MARK: Quadrant Enum

enum Quadrant: Int {
    case First = 1, Second, Third, Fourth
}