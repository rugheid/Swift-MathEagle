//
//  Vector.swift
//  SwiftMath
//
//  Created by Rugen Heidbuchel on 30/12/14.
//  Copyright (c) 2014 Jorestha Solutions. All rights reserved.
//

import Foundation
import Accelerate

class Vector <T: MatrixCompatible> : ArrayLiteralConvertible, Equatable, SequenceType, Printable {
    
    var elements = [T]()
    
    // empty init
    init() {}
    
    init(_ elements: [T]) {
        
        self.elements = elements
    }
    
    required init(arrayLiteral elements: T...) {
        
        self.elements = elements
    }
    
    init(length: Int, generator: (Int) -> T) {
        
        for i in 0 ..< length {
            
            self.elements.append(generator(i))
        }
    }
    
    convenience init(filledWith element: T, length: Int) {
        
        self.init(length: length, generator: { (i) -> T in element })
    }
    
    
    // MARK: Subscript Methods
    
    subscript(index: Int) -> T {
        
        get {
            
            if index < 0 || index >= self.length {
                
                NSException(name: "Index out of bounds", reason: "The index \(index) is out of bounds.", userInfo: nil).raise()
            }
            
            return self.elements[index]
        }
        
        set(newValue) {
            
            if index < -1 || index > self.length {
                
                NSException(name: "Index out of bounds", reason: "The index \(index) is out of bounds.", userInfo: nil).raise()
            }
            
            
        }
    }
    
    subscript(indexRange: Range<Int>) -> Vector<T> {
        
        if indexRange.startIndex < 0 {
            
            NSException(name: "Lower index out of bounds", reason: "The range's startIndex \(indexRange.startIndex) is out of bounds.", userInfo: nil).raise()
        }
        
        if indexRange.endIndex >= self.length {
            
            NSException(name: "Upper index out of bounds", reason: "The range's endIndex is out of bounds.", userInfo: nil).raise()
        }
        
        var returnElements = [T]()
        
        for i in indexRange {
            
            returnElements.append(self.elements[i])
        }
        
        return Vector(returnElements)
    }
    
    
    // MARK: Sequence Type Adoption
    
    func generate() -> VectorGenerator<T> {
        
        return VectorGenerator(vector: self)
    }
    
    
    
    // MARK: Basic Properties
    
    var copy: Vector<T> {
        
        return Vector(self.elements)
    }
    
    var description: String {
        
        return self.elements.description
    }
    
    /**
        Returns the length, the number of elements.
    */
    var length: Int {
        
        return self.elements.count
    }
    
    /**
        Returns the 2-norm. This means sqrt(element_0^2 + element_1^2 + ... + element_n^2)
    */
    var norm: T.PowerType {
        
        if self.length == 0 {
            
            NSException(name: "No elements", reason: "A vector with no elements has no norm.", userInfo: nil).raise()
        }
        
        var sum = self.elements[0]*self.elements[0]
        
        for i in 1 ..< self.length {
            
            let element = self.elements[i]
            
            sum = sum + element*element
        }
        
        return sum ** 0.5
    }
    
    
    /**
        Returns the conjugate of the vector.
    */
    var conjugate: Vector<T> {
        
        return vmap(self){ $0.conjugate }
    }
    
    
//    var maxElement: T {
//        
//        
//    }
    
    
    /**
        Returns whether the vector is empty. This means it doesn't contain any elements, so it's length equals zero.
    */
    var isEmpty: Bool {
        
        return self.length == 0
    }
    
    
    /**
        Returns whether the vector contains only zeros.
    */
    var isZero: Bool {
        
        for element in self {
            
            if element != 0 { return false }
        }
        
        return true
    }
    
    
    
    // MARK: Operator Functions
    
    /**
        Returns the dot product with the given vector. This is the product of self as a row vector with the given vector as a column vector. The given vector has to be of the same type and length.
    
        :param: vector The vector to multiply with.
    
        :returns: A scalar of the same type as the two vectors.
    */
    func dotProduct(vector: Vector<T>) -> T {
        
        let product = Matrix([self.elements]) * Matrix([vector.elements]).transpose
        
        return product[0][0]
    }
    
    
    /**
        Returns the direct product with the given vector. This product is the product of self as a column vector with the given vector as a row vector. The two vectors need to be of the same type and length.
    
        :param: vector The vector to multiply with.
    
        :returns: A square matrix of the same type as the two vectors with size equal to the vector's length.
    */
    func directProduct(vector: Vector<T>) -> Matrix<T> {
        
        return vectorDirectProduct(self, vector)
    }
    
}


// MARK: Vector Equality

func == <T: MatrixCompatible> (left: Vector<T>, right: Vector<T>) -> Bool {
    
    if left.length != right.length {
        
        return false
    }
    
    for i in 0 ..< left.length {
        
        if left[i] != right[i] { return false }
    }
    
    return true
}


// MARK: Vector Addition

func + <T: MatrixCompatible> (left: Vector<T>, right: Vector<T>) -> Vector<T> {
    
    if left.length != right.length {
        
        NSException(name: "Unequal lengths", reason: "The left vector's length (\(left.length)) is not equal to the right vector's length (\(right.length))", userInfo: nil).raise()
    }
    
    return vcombine(left, right){ $0 + $1 }
}

func + (left: Vector<Float>, right: Vector<Float>) -> Vector<Float> {
    
    // vDSP_vadd turned out to be the fastest option
    //                  ~ 280 times faster than without accelerate
    // Also tried:
    // cblas_saxpy      ~ 202 times faster than without accelerate
    // catlas_saxbpy     ~ 217 times faster than without accelerate
    
    if left.length != right.length {
        
        NSException(name: "Unequal lengths", reason: "The left vector's length (\(left.length)) is not equal to the right vector's length (\(right.length))", userInfo: nil).raise()
    }
    
    var elements = [Float](count: left.length, repeatedValue: 0)
    
    vDSP_vadd(left.elements, 1, right.elements, 1, &elements, 1, vDSP_Length(left.length))
    
    return Vector(elements)
    
//    var elements = right.elements
//    
//    cblas_saxpy(Int32(left.length), 1.0, left.elements, 1, &elements, 1)
//    
//    return Vector(elements)
    
//    var elements = right.elements
//    
//    catlas_saxpby(Int32(left.length), 1.0, left.elements, 1, 1.0, &elements, 1)
//    
//    return Vector(elements)
}

func + (left: Vector<Double>, right: Vector<Double>) -> Vector<Double> {
    
    // vDSP_vaddD turned out to be the fastest option
    //                  ~ 250 times faster than without accelerate
    // Also tried:
    // cblas_daxpy      ~ 200 times faster than without accelerate
    // catlas_daxbpy     ~ 213 times faster than without accelerate
    
    if left.length != right.length {
        
        NSException(name: "Unequal lengths", reason: "The left vector's length (\(left.length)) is not equal to the right vector's length (\(right.length))", userInfo: nil).raise()
    }
    
    var elements = [Double](count: left.length, repeatedValue: 0)
    
    vDSP_vaddD(left.elements, 1, right.elements, 1, &elements, 1, vDSP_Length(left.length))
    
    return Vector(elements)
    
//    var elements = right.elements
//    
//    cblas_daxpy(Int32(left.length), 1.0, left.elements, 1, &elements, 1)
//    
//    return Vector(elements)
    
//    var elements = right.elements
//    
//    catlas_daxpby(Int32(left.length), 1.0, left.elements, 1, 1.0, &elements, 1)
//    
//    return Vector(elements)
}

//func + (left: Vector<Complex>, right: Vector<Complex>) -> Vector<Complex> {
//    
//    var elements = map(Array(count: left.length, repeatedValue: Complex(0, 0))){ DSPDoubleSplitComplex($0) }
//    
//    let l = map(left.elements){ $0.DSPDoubleSplitComplexValue }
//    let r = map(right.elements){ $0.DSPDoubleSplitComplexValue }
//    
//    vDSP_zvaddD(l, 1, r, 1, &elements, 1, vDSP_Length(left.length))
//    
//    return Vector(map(elements){ Complex($0) })
//}


// MARK: Vector Negation

prefix func - <T: MatrixCompatible> (vector: Vector<T>) -> Vector<T> {
    
    return vmap(vector){ -$0 }
}

prefix func - (vector: Vector<Float>) -> Vector<Float> {
    
    // vDSP_vneg turned out to be the fastest option
    //                  ~ 67 times faster than without accelerate
    // Also tried:
    // cblas_sscal      ~ 53 times faster than without accelerate
    
    var elements = [Float](count: vector.length, repeatedValue: 0)
    
    vDSP_vneg(vector.elements, 1, &elements, 1, vDSP_Length(vector.length))
    
    return Vector(elements)
    
//    let returnVector = vector.copy
//    
//    cblas_sscal(Int32(vector.length), -1.0, &(returnVector.elements), 1)
//    
//    return returnVector
}

prefix func - (vector: Vector<Double>) -> Vector<Double> {
    
    // vDSP_vnegD turned out to be the fastest option
    //                  ~ 68 times faster than without accelerate
    // Also tried:
    // cblas_dscal      ~ 48 times faster than without accelerate
    
    var elements = [Double](count: vector.length, repeatedValue: 0)
    
    vDSP_vnegD(vector.elements, 1, &elements, 1, vDSP_Length(vector.length))
    
    return Vector(elements)
    
//    let returnVector = vector.copy
//    
//    cblas_dscal(Int32(vector.length), -1.0, &(returnVector.elements), 1)
//    
//    return returnVector
}

//prefix func - (vector: Vector<Complex>) -> Vector<Complex> {
//    
//    var elements = map(Array(count: vector.length, repeatedValue: Complex(0, 0))){ DSPDoubleSplitComplex($0) }
//    let v = map(vector.elements){ $0.DSPDoubleSplitComplexValue }
//    
//    vDSP_zvnegD(v, 1, &elements, 1, vDSP_Length(vector.length))
//    
//    return Vector(map(elements){ Complex($0) })
//}


// MARK: Vector Substraction

func - <T: MatrixCompatible> (left: Vector<T>, right: Vector<T>) -> Vector<T> {
    
    // To keep this implementation as general as possible, we don't use (left + -right), because T must then be Addable and Negatable.
    // User-defined structs or classes can be Substractable however without being Negatable.
    // You could for example make String Substractable, without making it Negatable.
    
    if left.length != right.length {
        
        NSException(name: "Unequal lengths", reason: "The left vector's length (\(left.length)) is not equal to the right vector's length (\(right.length))", userInfo: nil).raise()
    }
    
    return vcombine(left, right){ $0 - $1 }
}

func - (left: Vector<Float>, right: Vector<Float>) -> Vector<Float> {
    
    // vDSP_vsub turned out to be the fastest option
    //                  ~ 280 times faster than without accelerate
    // Also tried:
    // cblas_saxpy      ~ 206 times faster than without accelerate
    // catlas_saxbpy     ~ 201 times faster than without accelerate
    
    if left.length != right.length {
        
        NSException(name: "Unequal lengths", reason: "The left vector's length (\(left.length)) is not equal to the right vector's length (\(right.length))", userInfo: nil).raise()
    }
    
    var elements = [Float](count: left.length, repeatedValue: 0)
    
    vDSP_vsub(right.elements, 1, left.elements, 1, &elements, 1, vDSP_Length(left.length))
    
    return Vector(elements)
    
//    var elements = left.elements
//    
//    cblas_saxpy(Int32(left.length), -1.0, right.elements, 1, &elements, 1)
//    
//    return Vector(elements)
    
//    var elements = right.elements
//    
//    catlas_saxpby(Int32(left.length), 1.0, left.elements, 1, -1.0, &elements, 1)
//    
//    return Vector(elements)
}

func - (left: Vector<Double>, right: Vector<Double>) -> Vector<Double> {
    
    // vDSP_vsubD turned out to be the fastest option
    //                  ~ 251 times faster than without accelerate
    // Also tried:
    // cblas_daxpy      ~ 199 times faster than without accelerate
    // catlas_daxbpy     ~ 205 times faster than without accelerate
    
    if left.length != right.length {
        
        NSException(name: "Unequal lengths", reason: "The left vector's length (\(left.length)) is not equal to the right vector's length (\(right.length))", userInfo: nil).raise()
    }
    
    var elements = [Double](count: left.length, repeatedValue: 0)
    
    vDSP_vsubD(right.elements, 1, left.elements, 1, &elements, 1, vDSP_Length(left.length))
    
    return Vector(elements)
    
//    var elements = left.elements
//    
//    cblas_daxpy(Int32(left.length), -1.0, right.elements, 1, &elements, 1)
//    
//    return Vector(elements)
    
//    var elements = right.elements
//    
//    catlas_daxpby(Int32(left.length), 1.0, left.elements, 1, -1.0, &elements, 1)
//    
//    return Vector(elements)
}


// MARK: Vector Scalar Multiplication and Division

func * <T: MatrixCompatible> (scalar: T, vector: Vector<T>) -> Vector<T> {
    
    var elements = vector.elements
    
    for i in 0 ..< vector.length {
        
        elements[i] = elements[i] * scalar
    }
    
    return Vector(elements)
}

func * (scalar: Float, vector: Vector<Float>) -> Vector<Float> {
    
    // vDSP_vsmul turned out to be the fastest option
    //                  ~ 87 times faster than without accelerate
    // Also tried:
    // cblas_sscal      ~ 73 times faster than without accelerate
    
    var elements = [Float](count: vector.length, repeatedValue: 0)
    
    vDSP_vsmul(vector.elements, 1, [scalar], &elements, 1, vDSP_Length(vector.length))
    
    return Vector(elements)
    
//    var elements = vector.copy.elements
//    
//    cblas_sscal(Int32(vector.length), scalar, &elements, 1)
//    
//    return Vector(elements)
}

func * (scalar: Double, vector: Vector<Double>) -> Vector<Double> {
    
    // vDSP_vsmulD turned out to be the fastest option
    //                  ~ 89 times faster than without accelerate
    // Also tried:
    // cblas_dscal      ~ 81 times faster than without accelerate
    
    var elements = [Double](count: vector.length, repeatedValue: 0)
    
    vDSP_vsmulD(vector.elements, 1, [scalar], &elements, 1, vDSP_Length(vector.length))
    
    return Vector(elements)
    
//    var elements = vector.copy.elements
//    
//    cblas_dscal(Int32(vector.length), scalar, &elements, 1)
//    
//    return Vector(elements)
}

func * <T: MatrixCompatible> (vector: Vector<T>, scalar: T) -> Vector<T> {
    
    return scalar * vector
}

func / <T: MatrixCompatible> (vector: Vector<T>, scalar: T) -> Vector<T> {
    
    var elements = vector.elements
    
    for i in 0 ..< vector.length {
        
        elements[i] = elements[i] / scalar
    }
    
    return Vector(elements)
}

func / (vector: Vector<Float>, scalar: Float) -> Vector<Float> {
    
    // vDSP_vsdiv turned out to be the fastest option
    //                  ~ 90 times faster than without accelerate
    // Also tried:
    // cblas_sscal      ~ 82 times faster than without accelerate, but less accurate
    
    var elements = [Float](count: vector.length, repeatedValue: 0)
    
    vDSP_vsdiv(vector.elements, 1, [scalar], &elements, 1, vDSP_Length(vector.length))
    
    return Vector(elements)
    
//    var elements = vector.copy.elements
//    
//    cblas_sscal(Int32(vector.length), 1/scalar, &elements, 1)
//    
//    return Vector(elements)
}

func / (vector: Vector<Double>, scalar: Double) -> Vector<Double> {
    
    // vDSP_vsdivD turned out to be the fastest option
    //                  ~ 86 times faster than without accelerate
    // Also tried:
    // cblas_dscal      ~ 81 times faster than without accelerate, but less accurate
    
    var elements = [Double](count: vector.length, repeatedValue: 0)
    
    vDSP_vsdivD(vector.elements, 1, [scalar], &elements, 1, vDSP_Length(vector.length))
    
    return Vector(elements)
    
//    var elements = vector.copy.elements
//    
//    cblas_dscal(Int32(vector.length), 1/scalar, &elements, 1)
//    
//    return Vector(elements)
}


// MARK: Vector Direct Product

func * <T: MatrixCompatible> (left: Vector<T>, right: Vector<T>) -> Matrix<T> {
    
    return vectorDirectProduct(left, right)
}

func * (left: Vector<Float>, right: Vector<Float>) -> Matrix<Float> {
    
    return vectorDirectProduct(left, right)
}

/**
Returns the direct product of the two given vectors. Here left is taken as a column vector and right as a row vector.
The two vectors need to have the same length.

:param: left The left vector (column vector)
:param: right The right vector (row vector)

:return: A square matrix with size equal to the vector's length.
*/
func vectorDirectProduct <T: MatrixCompatible> (left: Vector<T>, right: Vector<T>) -> Matrix<T> {
    
    if left.length != right.length {
        
        NSException(name: "Unequal lengths", reason: "The lengths of the two vectors are not equal.", userInfo: nil).raise()
    }
    
    return Matrix([left.elements]).transpose * Matrix([right.elements])
}

func vectorDirectProduct(left: Vector<Float>, right: Vector<Float>) -> Matrix<Float> {
    
    if left.length != right.length {
        
        NSException(name: "Unequal lengths", reason: "The lengths of the two vectors are not equal.", userInfo: nil).raise()
    }
    
    if left.length == 0 {
        return Matrix<Float>()
    }
    
    var elements = [Float](count: left.length*left.length, repeatedValue: 0)
    
    cblas_sgemm(CblasRowMajor, CblasNoTrans, CblasNoTrans, Int32(left.length), Int32(left.length), 1, 1, left.elements, 1, right.elements, Int32(left.length), 1, &elements, Int32(left.length))
    
    return Matrix(elementsList: elements, rows: left.length)
}


// MARK: Vector Functional Methods

func vmap <T: MatrixCompatible, U: MatrixCompatible> (vector: Vector<T>, transform: (T) -> U) -> Vector<U> {
    
    return Vector(map(vector.elements, transform))
}

func vreduce <T: MatrixCompatible, U> (vector: Vector<T>, initial: U, combine: (U, T) -> U) -> U {
    
    return reduce(vector.elements, initial, combine)
}

func vcombine <T: MatrixCompatible, U: MatrixCompatible, V: MatrixCompatible> (left: Vector<T>, right: Vector<U>, combine: (T, U) -> V) -> Vector<V> {
    
    if left.length != right.length {
        
        NSException(name: "Unequal lengths", reason: "The lengths of the two vectors are not equal.", userInfo: nil).raise()
    }
    
    var vectorElements = [V]()
    
    for i in 0 ..< left.length {
        
        vectorElements.append(combine(left[i], right[i]))
    }
    
    return Vector(vectorElements)
}


// MARK: - Vector Generators

// MARK: Double Generators

func randomDoubleVector(ofLength length: Int) -> Vector<Double> {
    
    return Vector(length: length, generator: { (i) -> Double in
        return Double(arc4random())/Double(UINT32_MAX)
    })
}

func randomDoubleVector(ofLength length: Int, #min: Double, #max: Double) -> Vector<Double> {
    
    return Vector(length: length, generator: { (i) -> Double in
        return min + Double(arc4random())/Double(UINT32_MAX)*(max-min)
    })
}



// MARK: - Additional Structs

// MARK: - VectorGenerator

struct VectorGenerator <T: MatrixCompatible> : GeneratorType {
    
    let vector: Vector<T>
    
    var index = 0
    
    init(vector: Vector<T>) {
        
        self.vector = vector
    }
    
    mutating func next() -> T? {
        
        if index >= vector.length {
            
            return nil
        }
        
        let element = vector[index]
        
        index++
        
        return element
    }
}