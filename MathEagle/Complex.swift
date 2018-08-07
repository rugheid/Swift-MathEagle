//
//  Complex.swift
//  MathEagle
//
//  Created by Rugen Heidbuchel on 05/03/15.
//  Copyright (c) 2015 Jorestha Solutions. All rights reserved.
//

import Accelerate

public struct Complex: Comparable, Addable, Negatable, Subtractable, Multiplicable, Dividable, NaturalPowerable, IntegerPowerable, RealPowerable, SetCompliant, Conjugatable, MatrixCompatible, ExpressibleByIntegerLiteral, ExpressibleByFloatLiteral, CustomStringConvertible {
    
    public typealias NaturalPowerType = Complex
    public typealias IntegerPowerType = Complex
    public typealias RealPowerType = Complex
    
    
    public var real: Double
    public var imaginary: Double
    
    var DSPDoubleComplexValue: DSPDoubleComplex {
        
        return DSPDoubleComplex(real: real, imag: imaginary)
    }
    
    var DSPDoubleSplitComplexValue: DSPDoubleSplitComplex {
        
        let r = UnsafeMutablePointer<Double>.allocate(capacity: 1)
        r[0] = real
        let i = UnsafeMutablePointer<Double>.allocate(capacity: 1)
        i[0] = imaginary
        return DSPDoubleSplitComplex(realp: r, imagp: i)
    }
    
    
    // MARK: Initialisation
    
    public init(_ real: Int) {
        self.real=Double(real)
        self.imaginary=0.0
    }
    
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
        return (self.real == 0.0 && self.imaginary == 0.0) ? 0 : atan2(self.imaginary,self.real)
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
        if self.real==0 && self.imaginary==0 {
            return .first
        } else if self.imaginary>=0 && self.real>0 {
            return .first
        } else if self.real<=0 && self.imaginary>0 {
            return .second
        } else if self.imaginary<=0 && self.real<0 {
            return .third
        } else {
            return .fourth
        }
    }
    
    /**
        Returns a description of the complex number of the form "a ± bi"
    */
    public var description: String {
        
        return self.imaginary < 0 ? "\(self.real) - \(-self.imaginary)i" : "\(self.real) + \(self.imaginary)i"
    }
    
    
    // MARK: SetCompliant Protocol
    
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
    public func equals(_ z: Complex) -> Bool {
        
        return self.real == z.real && self.imaginary == z.imaginary
    }
    
    
    public func equals(_ z: Complex, accuracy: Double) -> Bool {
        
        return self.real.equals(z.real, accuracy: accuracy) && self.imaginary.equals(z.imaginary, accuracy: accuracy)
    }
    
    
    
    // MARK: Randomizable Protocol
    
    public typealias RandomRangeType = Complex
    public typealias RandomCountableRangeType = Int

    public static func random() -> Complex {
        // Complex random() returns random Complex in unit square
        // between 0 and 1+i .
        return Complex(Double.random(), Double.random())
    }

    public static func random(_ upperBound: Complex) -> Complex {
        return Complex(Double.random(upperBound.real), Double.random(upperBound.imaginary))
    }
    
    public static func random(_ range: Range<Complex>) -> Complex {
        let lowerBound=range.lowerBound
        let upperBound=range.upperBound
        var x_0=lowerBound.real
        var x_1=upperBound.real
        var y_0=lowerBound.imaginary
        var y_1=upperBound.imaginary
        if (x_1<x_0) {
            swap(&x_0,&x_1)
        }
        if (y_1<y_0) {
            swap(&y_0,&y_1)
        }
        return Complex(Double.random(x_0..<x_1),
                       Double.random(y_0..<y_1))
    }
    
    public static func random(_ range: ClosedRange<Complex>) -> Complex {
        let lowerBound=range.lowerBound
        let upperBound=range.upperBound
        var x_0=lowerBound.real
        var x_1=upperBound.real
        var y_0=lowerBound.imaginary
        var y_1=upperBound.imaginary
        if (x_1<x_0) {
            swap(&x_0,&x_1)
        }
        if (y_1<y_0) {
            swap(&y_0,&y_1)
        }
        return Complex(Double.random(x_0...x_1),
                       Double.random(y_0...y_1))
    }

    public static func random(_ range: CountableRange<Int>) -> Complex {
        return Complex(Double.random(Double(range.lowerBound)...Double(range.upperBound)),0.0)
    }
    
    public static func random(_ range: CountableClosedRange<Int>) -> Complex {
        return Complex(Double.random(Double(range.lowerBound)..<Double(range.upperBound)),0.0)
    }
    
    public static func randomArray(_ length: Int, upperBound: Complex) -> [Complex] {
        var array = [Complex](repeating: 0, count: length)
        for i in 0..<length {
            array[i] = random(upperBound)
        }
        return array
    }

    public static func randomArray(_ length: Int, range: Range<RandomRangeType>) -> [Complex] {
        var array = [Complex](repeating: 0, count: length)
        for i in 0..<length {
            array[i] = random(range)
        }
        return array
    }
    
    public static func randomArray(_ length: Int, range: ClosedRange<RandomRangeType>) -> [Complex] {
        var array = [Complex](repeating: 0, count: length)
        for i in 0..<length {
            array[i] = random(range)
        }
        return array
    }
}



// MARK: Function Extensions

public func sqrt(_ z: Complex) -> Complex {
    
    return Complex(modulus: sqrt(z.modulus), argument: z.argument / 2)
}

public func exp(_ z: Complex) -> Complex {
    
    let c = exp(z.real)
    return Complex(c * cos(z.imaginary), c * sin(z.imaginary))
}

public func log(_ z: Complex) -> Complex {
    
    return Complex(log(z.modulus), z.argument)
}



// MARK: Equatable Protocol

public func == (left: Complex, right: Complex) -> Bool {
    
    return left.equals(right)
}

//public func == (left: Double, right: Complex) -> Bool {
//    
//    return left == right.real && right.imaginary == 0.0
//}
//
//public func == (left: Complex, right: Double) -> Bool {
//    
//    return right == left
//}



// MARK: Comparable Protocol

public func < (left: Complex, right: Complex) -> Bool {
    // Returning false allows MathEagle to create Swift ranges
    // of Complex's such as Complex(0.0,0.0)..<Complex(1.0,1.0)
    // that can be passed to Complex.randomArray(N,range:range)
    return false
}

public func > (left: Complex, right: Complex) -> Bool {
    return false
}



// MARK: Addable Protocol

public func + (left: Complex, right: Complex) -> Complex {
    
    return Complex(left.real + right.real, left.imaginary + right.imaginary)
}

public func + (left: Double, right: Complex) -> Complex {
    
    return Complex(left + right.real, right.imaginary)
}

public func + (left: Complex, right: Double) -> Complex {
    
    return right + left
}


public func += (left: inout Complex, right: Complex) {
    
    left.real += right.real
    left.imaginary += right.imaginary
}



// MARK: Negatable Protocol

public prefix func - (z: Complex) -> Complex {
    
    return Complex(-z.real, -z.imaginary)
}



// MARK: Subtractable Protocol

public func - (left: Complex, right: Complex) -> Complex {
    
    return Complex(left.real - right.real, left.imaginary - right.imaginary)
}

public func - (left: Double, right: Complex) -> Complex {
    
    return Complex(left - right.real, -right.imaginary)
}

public func - (left: Complex, right: Double) -> Complex {
    
    return Complex(left.real - right, left.imaginary)
}



// MARK: Multiplicable Protocol

public func * (left: Complex, right: Complex) -> Complex {
    
    return Complex(left.real * right.real - left.imaginary * right.imaginary, left.real * right.imaginary + left.imaginary * right.real)
}

public func * (left: Double, right: Complex) -> Complex {
    
    return Complex(left * right.real, left * right.imaginary)
}

public func * (left: Complex, right: Double) -> Complex {
    
    return right * left
}

public func * (left: UInt, right: Complex) -> Complex {
    
    return Complex(Double(left) * right.real, Double(left) * right.imaginary)
}

public func * (left: Complex, right: UInt) -> Complex {
    
    return right * left
}

public func * (left: Int, right: Complex) -> Complex {
    
    return Complex(Double(left) * right.real, Double(left) * right.imaginary)
}

public func * (left: Complex, right: Int) -> Complex {
    
    return right * left
}



// MARK: Dividable Protocol

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
    // The basic principle is x^y = exp(y*log(x)) where log is the
    // the principal branch that makes log(r*exp(i*theta)) = log(r)+i*theta
    // for real r and theta where theta is in the half-open interval
    // (-PI,PI] .  Case x==0, especially when also y==0, is controversial.
    // The def of exp is the well known Maclaurin series from calculus.
    if (left==0) {
        // Some error checking provision for Re(right)<0 could be done here.
        return Complex(0,0)
    } else {
        return exp(right*log(left))
    }
}

public func ** (left: Double, right: Complex) -> Complex {
    
    return Complex(modulus: left ** right.real, argument: log(left) * right.imaginary)
}

public func ** (left: Complex, right: UInt) -> Complex {
    
    return Complex(modulus: left.modulus ** right, argument: Double(right) * left.argument)
}

public func ** (left: Complex, right: Int) -> Complex {
    
    return Complex(modulus: left.modulus ** right, argument: Double(right) * left.argument)
}

public func ** (left: Complex, right: Double) -> Complex {
    
    return Complex(modulus: left.modulus ** right, argument: right * left.argument)
}





// MARK: Quadrant Enum

public enum Quadrant: Int {
    case first = 1, second, third, fourth
}




// MARK: DSPDoubleSplitComplex extension

extension DSPDoubleSplitComplex {
    init(_ complex: Complex) {
        let realp = UnsafeMutablePointer<Double>.allocate(capacity: 1)
        let imagp = UnsafeMutablePointer<Double>.allocate(capacity: 1)
        realp[0] = complex.real
        imagp[0] = complex.imaginary
        self.init(realp:realp, imagp:imagp)
    }
}
