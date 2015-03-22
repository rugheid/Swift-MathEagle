//
//  Complex.swift
//  MathEagle
//
//  Created by Rugen Heidbuchel on 05/03/15.
//  Copyright (c) 2015 Jorestha Solutions. All rights reserved.
//

import Foundation

struct Complex: Equatable, Comparable, Addable, Negatable, Substractable, Multiplicable, Dividable, Powerable, SetCompliant, FullMathValue, IntegerLiteralConvertible, Printable {
    
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
    
    /**
        Returns the modulus of the complex number.
    */
    var modulus: Double {
        
        return sqrt(self.real**2 + self.imaginary**2)
    }
    
    /**
        Returns the argument of the complex number.
    */
    var argument: Double {
        
        return (self.real == 0.0 && self.imaginary == 0.0) ? 0 : atan(self.imaginary / self.real) + (self.quadrant.rawValue >= 3 ? PI : 0)
    }
    
    /**
        Returns the conjugate of the complex number.
    */
    var conjugate: Complex {
        
        return Complex(self.real, -self.imaginary)
    }
    
    /**
        Returns the quadrant of the complex plane in which the complex number lies.
    */
    var quadrant: Quadrant {
        
        if self.real >= 0 {
            
            return self.imaginary >= 0 ? .First : .Fourth
            
        } else {
            
            return self.imaginary >= 0 ? .Second : .Third
        }
    }
    
    /**
        Returns a description of the complex number of the form "a ± bi"
    */
    var description: String {
        
        return self.imaginary < 0 ? "\(self.real) - \(-self.imaginary)i" : "\(self.real) + \(self.imaginary)i"
    }
    
    
    // MARK: Set Conformance
    
    var isReal: Bool {
        
        return self.imaginary == 0.0;
    }
    
    
    // MARK: Fuzzy Equality
    
    /**
        Returns true if the real and imaginary parts are equal.
    */
    func equals(z: Complex) -> Bool {
        
        return self.real == self.real && self.imaginary == z.imaginary
    }
    
    
    func equals(z: Complex, accuracy: Double) -> Bool {
        
        return self.real.equals(z.real, accuracy: accuracy) && self.imaginary.equals(z.imaginary, accuracy: accuracy)
    }
    
    
    
    // MARK: Set Compliance
    
    var isNatural: Bool {
        
        return self.real.isNatural && self.imaginary == 0.0
    }
    
    var isInteger: Bool {
        
        return self.real.isInteger && self.imaginary == 0.0
    }
    
}



// MARK: Function Extensions

func sqrt(z: Complex) -> Complex {
    
    return Complex(modulus: sqrt(z.modulus), argument: z.argument / 2)
}

func exp(z: Complex) -> Complex {
    
    let c = exp(z.real)
    return Complex(c * cos(z.imaginary), c * sin(z.imaginary))
}

func log(z: Complex) -> Complex {
    
    return Complex(log(z.modulus), z.argument)
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



// MARK: Comparable Protocol Conformance

func < (left: Complex, right: Complex) -> Bool {
    
    return left.modulus < right.modulus
}

func > (left: Complex, right: Complex) -> Bool {
    
    return right < left
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