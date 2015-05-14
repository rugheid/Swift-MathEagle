//
//  Complex.swift
//  MathEagle
//
//  Created by Rugen Heidbuchel on 05/03/15.
//  Copyright (c) 2015 Jorestha Solutions. All rights reserved.
//

import Accelerate

public struct Complex: Equatable, Comparable, Addable, Negatable, Substractable, Multiplicable, Dividable, Powerable, SetCompliant, Conjugatable, FullMathValue, IntegerLiteralConvertible, FloatLiteralConvertible, MatrixCompatible, Printable {
    
    public var real: Double
    public var imaginary: Double
    
    var DSPDoubleComplexValue: DSPDoubleComplex {
        
        return DSPDoubleComplex(real: real, imag: imaginary)
    }
    
    var DSPDoubleSplitComplexValue: DSPDoubleSplitComplex {
        
        var r = UnsafeMutablePointer<Double>.alloc(1)
        r[0] = real
        var i = UnsafeMutablePointer<Double>.alloc(1)
        i[0] = imaginary
        return DSPDoubleSplitComplex(realp: r, imagp: i)
    }
    
    
    // MARK: Initialisation
    
    public init(_ complex: Complex) {
        self.real = complex.real
        self.imaginary = complex.imaginary
    }
    
    public init(_ real: Double, _ imaginary: Double) {
        
        self.real = real
        self.imaginary = imaginary
    }
    
    public init(modulus: Double, argument: Double) {
        
        self.real = modulus * cos(argument)
        self.imaginary = modulus * sin(argument)
    }
    
    public init(integerLiteral value: IntegerLiteralType) {
        
        self.real = Double(value)
        self.imaginary = 0
    }
    
    public init(floatLiteral value: FloatLiteralType) {
        self.real = Double(value)
        self.imaginary = 0
    }
    
    init(_ DSPDoubleSplitComplexValue: DSPDoubleSplitComplex) {
        
        self.real = DSPDoubleSplitComplexValue.realp[0]
        self.imaginary = DSPDoubleSplitComplexValue.imagp[0]
    }
    
    
    public static var imaginaryUnit: Complex {
        
        return Complex(0, 1)
    }
    
    
    // MARK: Basic Properties
    
    /**
        Returns the modulus of the complex number.
    */
    public var modulus: Double {
        
        return sqrt(self.real**2 + self.imaginary**2)
    }
    
    /**
        Returns the argument of the complex number.
    */
    public var argument: Double {
        
        return (self.real == 0.0 && self.imaginary == 0.0) ? 0 : atan(self.imaginary / self.real) + (self.quadrant.rawValue >= 3 ? PI : 0)
    }
    
    /**
        Returns the conjugate of the complex number.
    */
    public var conjugate: Complex {
        
        return Complex(self.real, -self.imaginary)
    }
    
    /**
        Returns the quadrant of the complex plane in which the complex number lies.
    */
    public var quadrant: Quadrant {
        
        if self.real >= 0 {
            
            return self.imaginary >= 0 ? .First : .Fourth
            
        } else {
            
            return self.imaginary >= 0 ? .Second : .Third
        }
    }
    
    /**
        Returns a description of the complex number of the form "a ± bi"
    */
    public var description: String {
        
        return self.imaginary < 0 ? "\(self.real) - \(-self.imaginary)i" : "\(self.real) + \(self.imaginary)i"
    }
    
    
    // MARK: Set Conformance
    
    public var isNatural: Bool {
        
        return self.real.isNatural && self.imaginary == 0.0
    }
    
    public var isInteger: Bool {
        
        return self.real.isInteger && self.imaginary == 0.0
    }
    
    public var isReal: Bool {
        
        return self.imaginary == 0.0
    }
    
    
    // MARK: Fuzzy Equality
    
    /**
        Returns true if the real and imaginary parts are equal.
    */
    public func equals(z: Complex) -> Bool {
        
        return self.real == self.real && self.imaginary == z.imaginary
    }
    
    
    public func equals(z: Complex, accuracy: Double) -> Bool {
        
        return self.real.equals(z.real, accuracy: accuracy) && self.imaginary.equals(z.imaginary, accuracy: accuracy)
    }
    
    
    
    // MARK: Randomizable Conformance
    
    /**
        Returns a random complex number.
    */
    public static func random() -> Complex {
        
        return Complex(Double.random(), Double.random())
    }
    
    
    /**
        Returns a random complex number in the given interval(s). When no interval is provided, random() will be used.
        When one interval is provided this interval will be used to restrict the real and imaginary parts.
        When two intervals are provided the first will be used for the real part, the second for the imaginary part.
    */
    public static func randomInInterval(intervals: ClosedInterval<Double>...) -> Complex {
        
        return randomInInterval(intervals)
    }
    
    
    /**
    Returns a random complex number in the given interval(s). When no interval is provided, random() will be used.
    When one interval is provided this interval will be used to restrict the real and imaginary parts.
    When two intervals are provided the first will be used for the real part, the second for the imaginary part.
    */
    public static func randomInInterval(intervals: [ClosedInterval<Double>]) -> Complex {
        
        if intervals.isEmpty { return self.random() }
        if intervals.count == 1 { return Complex(Double.randomInInterval([intervals[0]]), Double.randomInInterval([intervals[0]])) }
        return Complex(Double.randomInInterval([intervals[0]]), Double.randomInInterval([intervals[1]]))
    }
    
}



// MARK: Function Extensions

public func sqrt(z: Complex) -> Complex {
    
    return Complex(modulus: sqrt(z.modulus), argument: z.argument / 2)
}

public func exp(z: Complex) -> Complex {
    
    let c = exp(z.real)
    return Complex(c * cos(z.imaginary), c * sin(z.imaginary))
}

public func log(z: Complex) -> Complex {
    
    return Complex(log(z.modulus), z.argument)
}



// MARK: Equatable Protocol Conformance

public func == (left: Complex, right: Complex) -> Bool {
    
    return left.equals(right)
}

public func == (left: Double, right: Complex) -> Bool {
    
    return left == right.real && right.imaginary == 0.0
}

public func == (left: Complex, right: Double) -> Bool {
    
    return right == left
}



// MARK: Comparable Protocol Conformance

public func < (left: Complex, right: Complex) -> Bool {
    
    return left.modulus < right.modulus
}

public func > (left: Complex, right: Complex) -> Bool {
    
    return right < left
}



// MARK: Addable Protocol Conformance

public func + (left: Complex, right: Complex) -> Complex {
    
    return Complex(left.real + right.real, left.imaginary + right.imaginary)
}

public func + (left: Double, right: Complex) -> Complex {
    
    return Complex(left + right.real, right.imaginary)
}

public func + (left: Complex, right: Double) -> Complex {
    
    return right + left
}



// MARK: Negatable Protocol Conformance

public prefix func - (z: Complex) -> Complex {
    
    return Complex(-z.real, -z.imaginary)
}



// MARK: Substractable Protocol Conformance

public func - (left: Complex, right: Complex) -> Complex {
    
    return Complex(left.real - right.real, left.imaginary - right.imaginary)
}

public func - (left: Double, right: Complex) -> Complex {
    
    return Complex(left - right.real, -right.imaginary)
}

public func - (left: Complex, right: Double) -> Complex {
    
    return Complex(left.real - right, left.imaginary)
}



// MARK: Multiplicable Protocol Conformance

public func * (left: Complex, right: Complex) -> Complex {
    
    return Complex(left.real * right.real - left.imaginary * right.imaginary, left.real * right.imaginary + left.imaginary * right.real)
}

public func * (left: Double, right: Complex) -> Complex {
    
    return Complex(left * right.real, left * right.imaginary)
}

public func * (left: Complex, right: Double) -> Complex {
    
    return right * left
}



// MARK: Dividable Protocol Conformance

public func / (left: Complex, right: Complex) -> Complex {
    
    let d = right.real**2 + right.imaginary**2
    return Complex((left.real * right.real + left.imaginary * right.imaginary) / d, (left.imaginary * right.real - left.real * right.imaginary) / d)
}

public func / (left: Double, right: Complex) -> Complex {
    
    let d = right.real**2 + right.imaginary**2
    return Complex((left * right.real) / d, (-left * right.imaginary) / d)
}

public func / (left: Complex, right: Double) -> Complex {
    
    return Complex(left.real / right, left.imaginary / right)
}



// MARK: Powers

public func ** (left: Complex, right: Complex) -> Complex {
    
    return Complex(0, 0)
}

public func ** (left: Double, right: Complex) -> Complex {
    
    return Complex(modulus: left ** right.real, argument: log(left) * right.imaginary)
}

public func ** (left: Complex, right: Double) -> Complex {
    
    return Complex(modulus: left.modulus ** right, argument: right * left.argument)
}





// MARK: Quadrant Enum

public enum Quadrant: Int {
    case First = 1, Second, Third, Fourth
}




// MARK: DSPDoubleSplitComplex extension

extension DSPDoubleSplitComplex {
    
    init(_ complex: Complex) {
        
        self.realp = UnsafeMutablePointer<Double>.alloc(1)
        self.realp[0] = complex.real
        
        self.imagp = UnsafeMutablePointer<Double>.alloc(1)
        self.imagp[0] = complex.imaginary
    }
}