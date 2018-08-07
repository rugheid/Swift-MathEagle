//
//  Vector.swift
//  SwiftMath
//
//  Created by Rugen Heidbuchel on 30/12/14.
//  Copyright (c) 2014 Jorestha Solutions. All rights reserved.
//

import Foundation
import Accelerate

/**
    A generic class representing a vector with the given type.
*/
open class Vector <T: MatrixCompatible> : ExpressibleByArrayLiteral, Equatable, Sequence, CustomStringConvertible {
    
    /**
        Returns a list of all elements of the vector.
    */
    open var elements = [T]()
    
    /**
        Creates an empty vector. elements will be [], length will be 0.
    */
    public init() {}
    
    
    /**
        Creates a vector with the given elements.
    
        - parameter elements: An array containing the elements of the vector.
    */
    public init(_ elements: [T]) {
        
        self.elements = elements
    }
    
    
    /**
        Creates a vector from an array literal.
    */
    public required init(arrayLiteral elements: T...) {
        
        self.elements = elements
    }
    
    
    /**
        Creates a vector with the given length using the
        given generator. The generator takes an Int representing
        the index of the element. These indices start at 0 and
        go to length - 1.
    
        - parameter length: The number of elements the vector should have.
        - parameter generator: The generator used to generate the elements.
    */
    public init(length: Int, generator: (Int) -> T) {
        
        self.elements = (0..<length).map{ generator($0) }
    }
    
    
    /**
        Creates a vector of the given length filled with the
        given element.
    
        - parameter element: The element to fill the vector with.
    */
    public convenience init(filledWith element: T, length: Int) {
        
        self.init(length: length, generator: { _ in element })
    }
    
    
    /**
        Creates a random vector with the given length.
        The elements in the vector are generated with
        the random function of the vector's type T.
    
        - parameter length: The number of elements the vector should have.
    */
    public convenience init(randomWithLength length: Int) {
        
        self.init(T.randomArray(length))
    }
    
    
    /**
        Creates a random vector with the given length.
        The elements in the vector are generated with
        the randomIn function of the vector's
        type T. This means the generated values will
        lie within the given range.
    
        - parameter length: The number of elements the vector should have.
        - parameter range: The range in which the random generated
                    elements may lie.
    */
    public convenience init(randomWithLength length: Int, range: Range<T.RandomRangeType>) {
        
        self.init(length: length, generator: { _ in T.random(range) })
    }
    
    /**
     Creates a random vector with the given length.
     The elements in the vector are generated with
     the randomIn function of the vector's
     type T. This means the generated values will
     lie within the given range.
     
     - parameter length: The number of elements the vector should have.
     - parameter range: The range in which the random generated
     elements may lie.
     */
    public convenience init(randomWithLength length: Int, range: ClosedRange<T.RandomRangeType>) {
        
        self.init(length: length, generator: { _ in T.random(range) })
    }
    
    /**
     Creates a random vector with the given length.
     The elements in the vector are generated with
     the randomIn function of the vector's
     type T. This means the generated values will
     lie within the given range.
     
     - parameter length: The number of elements the vector should have.
     - parameter range: The range in which the random generated
     elements may lie.
     */
    public convenience init(randomWithLength length: Int, range: CountableRange<T.RandomCountableRangeType>) {
        
        self.init(length: length, generator: { _ in T.random(range) })
    }
    
    /**
     Creates a random vector with the given length.
     The elements in the vector are generated with
     the randomIn function of the vector's
     type T. This means the generated values will
     lie within the given range.
     
     - parameter length: The number of elements the vector should have.
     - parameter range: The range in which the random generated
     elements may lie.
     */
    public convenience init(randomWithLength length: Int, range: CountableClosedRange<T.RandomCountableRangeType>) {
        
        self.init(length: length, generator: { _ in T.random(range) })
    }
    
    
    // MARK: Subscript Methods
    
    /**
        Returns or sets the element at the given index.
    
        - parameter index: The index of the element to get/set.
    */
    open subscript(index: Int) -> T {
        
        get {
            
            if index < 0 || index >= self.length {
                
                NSException(name: NSExceptionName(rawValue: "Index out of bounds"), reason: "The index \(index) is out of bounds.", userInfo: nil).raise()
            }
            
            return self.elements[index]
        }
        
        set(newValue) {
            
            if index < -1 || index > self.length {
                
                NSException(name: NSExceptionName(rawValue: "Index out of bounds"), reason: "The index \(index) is out of bounds.", userInfo: nil).raise()
            }
            
            
        }
    }
    
    /**
     Returns the subvector at the given index range.
     
     - parameter indexRange: A range representing the indices
     of the subvector.
     */
    open subscript(indexRange: CountableRange<Int>) -> Vector<T> {
        
        if indexRange.lowerBound < 0 {
            
            NSException(name: NSExceptionName(rawValue: "Lower index out of bounds"), reason: "The range's startIndex \(indexRange.lowerBound) is out of bounds.", userInfo: nil).raise()
        }
        
        if indexRange.upperBound >= self.length {
            
            NSException(name: NSExceptionName(rawValue: "Upper index out of bounds"), reason: "The range's endIndex is out of bounds.", userInfo: nil).raise()
        }
        
        var returnElements = [T]()
        
        for i in indexRange {
            
            returnElements.append(self.elements[i])
        }
        
        return Vector(returnElements)
    }
    
    /**
        Returns the subvector at the given index range.
    
        - parameter indexRange: A range representing the indices
                    of the subvector.
    */
    open subscript(indexRange: CountableClosedRange<Int>) -> Vector<T> {
        
        if indexRange.lowerBound < 0 {
            
            NSException(name: NSExceptionName(rawValue: "Lower index out of bounds"), reason: "The range's startIndex \(indexRange.lowerBound) is out of bounds.", userInfo: nil).raise()
        }
        
        if indexRange.upperBound >= self.length {
            
            NSException(name: NSExceptionName(rawValue: "Upper index out of bounds"), reason: "The range's endIndex is out of bounds.", userInfo: nil).raise()
        }
        
        var returnElements = [T]()
        
        for i in indexRange {
            
            returnElements.append(self.elements[i])
        }
        
        return Vector(returnElements)
    }
    
    
    // MARK: Sequence Type Adoption
    
    /**
        Returns a generator for the vector.
    */
    open func makeIterator() -> VectorGenerator<T> {
        
        return VectorGenerator(vector: self)
    }
    
    
    
    // MARK: Basic Properties
    
    /**
        Returns a copy of the vector.
    */
    open var copy: Vector<T> {
        
        return Vector(self.elements)
    }
    
    /**
        Returns a description of the vector.
    
        :example: [1, 2, 3]
    */
    open var description: String {
        
        return self.elements.description
    }
    
    /**
        Returns the length, the number of elements.
    */
    open var length: Int {
        
        return self.elements.count
    }
    
    /**
        Returns the 2-norm. This means
        sqrt(element_0^2 + element_1^2 + ... + element_n^2).
    */
    open var norm: T.RealPowerType {
        
        if self.length == 0 {
            
            NSException(name: NSExceptionName(rawValue: "No elements"), reason: "A vector with no elements has no norm.", userInfo: nil).raise()
        }
        
        var sum = self.elements[0]*self.elements[0]
        
        for i in 1 ..< self.length {
            
            let element = self.elements[i]
            
            sum = sum + element*element
        }
        
        return root(sum, order: 2)
    }
    
    
    /**
        Returns the conjugate of the vector. This means
        every complex value a + bi is replaced by its
        conjugate a - bi. Non-complex values are left
        untouched.
    */
    open var conjugate: Vector<T> {
        
        return vmap(self){ $0.conjugate }
    }
    
    
//    var maxElement: T {
//        
//        
//    }
    
    
    /**
        Returns whether the vector is empty. This means
        it doesn't contain any elements, so it's length equals zero.
    */
    open var isEmpty: Bool {
        
        return self.length == 0
    }
    
    
    /**
        Returns whether the vector contains only zeros.
    */
    open var isZero: Bool {
        
        for element in self {
            
            if element != 0 { return false }
        }
        
        return true
    }
    
    
    
    // MARK: Operator Functions
    
    /**
        Returns the dot product with the given vector. This is the product
        of self as a row vector with the given vector as a column vector.
        The given vector has to be of the same type and length.
    
        - parameter vector: The vector to multiply with.
    
        - returns: A scalar of the same type as the two vectors.
    */
    open func dotProduct(_ vector: Vector<T>) -> T {
        
        return vectorDotProduct(self, vector)
    }
    
    
    /**
        Returns the direct product with the given vector. This product is
        the product of self as a column vector with the given vector as a
        row vector. The two vectors need to be of the same type and length.
    
        - parameter vector: The vector to multiply with.
    
        - returns: A square matrix of the same type as the two vectors with
                    size equal to the vector's length.
    */
    open func directProduct(_ vector: Vector<T>) -> Matrix<T> {
        
        return vectorDirectProduct(self, vector)
    }
    
}


// MARK: Vector Equality

/**
    Returns whether two vectors are equal. This means the vector's
    are of the same length and all elements at corresponding indices
    are equal.
*/
public func == <T: MatrixCompatible> (left: Vector<T>, right: Vector<T>) -> Bool {
    
    if left.length != right.length {
        
        return false
    }
    
    for i in 0 ..< left.length {
        
        if left[i] != right[i] { return false }
    }
    
    return true
}


// MARK: Vector Addition

/**
    Returns the sum of the two given vectors. Both given vectors are left untouched.

    :exception: An exception is thrown when the two vectors are not of equal length.
*/
public func + <T: MatrixCompatible> (left: Vector<T>, right: Vector<T>) -> Vector<T> {
    
    if left.length != right.length {
        
        NSException(name: NSExceptionName(rawValue: "Unequal lengths"), reason: "The left vector's length (\(left.length)) is not equal to the right vector's length (\(right.length))", userInfo: nil).raise()
    }
    
    return vcombine(left, right){ $0 + $1 }
}

/**
    Returns the sum of the two given vectors. Both given vectors are left untouched.

    :exception: An exception is thrown when the two vectors are not of equal length.
*/
public func + (left: Vector<Float>, right: Vector<Float>) -> Vector<Float> {
    
    if left.length != right.length {
        
        NSException(name: NSExceptionName(rawValue: "Unequal lengths"), reason: "The left vector's length (\(left.length)) is not equal to the right vector's length (\(right.length))", userInfo: nil).raise()
    }
    
//    var elements = [Float](count: left.length, repeatedValue: 0)
//    
//    vDSP_vadd(left.elements, 1, right.elements, 1, &elements, 1, vDSP_Length(left.length))
//    
//    return Vector(elements)
    
    var elements = right.elements
    
    cblas_saxpy(Int32(left.length), 1.0, left.elements, 1, &elements, 1)
    
    return Vector(elements)
    
//    var elements = right.elements
//    
//    catlas_saxpby(Int32(left.length), 1.0, left.elements, 1, 1.0, &elements, 1)
//    
//    return Vector(elements)
}

/**
    Returns the sum of the two given vectors. Both given vectors are left untouched.

    :exception: An exception is thrown when the two vectors are not of equal length.
*/
public func + (left: Vector<Double>, right: Vector<Double>) -> Vector<Double> {
    
    if left.length != right.length {
        
        NSException(name: NSExceptionName(rawValue: "Unequal lengths"), reason: "The left vector's length (\(left.length)) is not equal to the right vector's length (\(right.length))", userInfo: nil).raise()
    }
    
//    var elements = [Double](count: left.length, repeatedValue: 0)
//    
//    vDSP_vaddD(left.elements, 1, right.elements, 1, &elements, 1, vDSP_Length(left.length))
//    
//    return Vector(elements)
    
    var elements = right.elements
    
    cblas_daxpy(Int32(left.length), 1.0, left.elements, 1, &elements, 1)
    
    return Vector(elements)
    
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

/**
    Returns the negation of the given vector. The given vector
    is left untouched.
*/
public prefix func - <T: MatrixCompatible> (vector: Vector<T>) -> Vector<T> {
    
    return vmap(vector){ -$0 }
}

/**
    Returns the negation of the given vector. The given vector
    is left untouched.
*/
public prefix func - (vector: Vector<Float>) -> Vector<Float> {
    
//    var elements = [Float](count: vector.length, repeatedValue: 0)
//    
//    vDSP_vneg(vector.elements, 1, &elements, 1, vDSP_Length(vector.length))
//    
//    return Vector(elements)
    
    let returnVector = vector.copy
    
    cblas_sscal(Int32(vector.length), -1.0, &(returnVector.elements), 1)
    
    return returnVector
}

/**
    Returns the negation of the given vector. The given vector
    is left untouched.
*/
public prefix func - (vector: Vector<Double>) -> Vector<Double> {
    
//    var elements = [Double](count: vector.length, repeatedValue: 0)
//    
//    vDSP_vnegD(vector.elements, 1, &elements, 1, vDSP_Length(vector.length))
//    
//    return Vector(elements)
    
    let returnVector = vector.copy
    
    cblas_dscal(Int32(vector.length), -1.0, &(returnVector.elements), 1)
    
    return returnVector
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


// MARK: Vector Subtraction

/**
    Returns the difference of the two given vectors.
    
    :exception: An exception is thrown when the two vectors
                    are not of equal length.
*/
public func - <T: MatrixCompatible> (left: Vector<T>, right: Vector<T>) -> Vector<T> {
    
    if left.length != right.length {
        
        NSException(name: NSExceptionName(rawValue: "Unequal lengths"), reason: "The left vector's length (\(left.length)) is not equal to the right vector's length (\(right.length))", userInfo: nil).raise()
    }
    
    return vcombine(left, right){ $0 - $1 }
}

/**
    Returns the difference of the two given vectors.

    :exception: An exception is thrown when the two vectors
    are not of equal length.
*/
public func - (left: Vector<Float>, right: Vector<Float>) -> Vector<Float> {
    
    if left.length != right.length {
        
        NSException(name: NSExceptionName(rawValue: "Unequal lengths"), reason: "The left vector's length (\(left.length)) is not equal to the right vector's length (\(right.length))", userInfo: nil).raise()
    }
    
//    var elements = [Float](count: left.length, repeatedValue: 0)
//    
//    vDSP_vsub(right.elements, 1, left.elements, 1, &elements, 1, vDSP_Length(left.length))
//    
//    return Vector(elements)
    
    var elements = left.elements
    
    cblas_saxpy(Int32(left.length), -1.0, right.elements, 1, &elements, 1)
    
    return Vector(elements)
    
//    var elements = Array(right.elements)
//    
//    catlas_saxpby(Int32(left.length), 1.0, left.elements, 1, -1.0, &elements, 1)
//    
//    return Vector(elements)
}

/**
    Returns the difference of the two given vectors.

    :exception: An exception is thrown when the two vectors
    are not of equal length.
*/
public func - (left: Vector<Double>, right: Vector<Double>) -> Vector<Double> {
    
    if left.length != right.length {
        
        NSException(name: NSExceptionName(rawValue: "Unequal lengths"), reason: "The left vector's length (\(left.length)) is not equal to the right vector's length (\(right.length))", userInfo: nil).raise()
    }
    
//    var elements = [Double](count: left.length, repeatedValue: 0)
//    
//    vDSP_vsubD(right.elements, 1, left.elements, 1, &elements, 1, vDSP_Length(left.length))
//    
//    return Vector(elements)
    
//    var elements = Array(left.elements)
//    
//    cblas_daxpy(Int32(left.length), -1.0, right.elements, 1, &elements, 1)
//    
//    return Vector(elements)
    
    var elements = right.elements
    
    catlas_daxpby(Int32(left.length), 1.0, left.elements, 1, -1.0, &elements, 1)
    
    return Vector(elements)
}


// MARK: Vector Scalar Multiplication and Division

/**
    Returns the product of the given scalar and the
    given vector. This means every element in the given
    vector is multiplied with the given scalar.
    The given vector is left untouched.
*/
public func * <T: MatrixCompatible> (scalar: T, vector: Vector<T>) -> Vector<T> {
    
    var elements = vector.elements
    
    for i in 0 ..< vector.length {
        
        elements[i] = elements[i] * scalar
    }
    
    return Vector(elements)
}

/**
    Returns the product of the given scalar and the
    given vector. This means every element in the given
    vector is multiplied with the given scalar.
    The given vector is left untouched.
*/
public func * (scalar: Float, vector: Vector<Float>) -> Vector<Float> {
    
//    var elements = [Float](count: vector.length, repeatedValue: 0)
//    
//    vDSP_vsmul(vector.elements, 1, [scalar], &elements, 1, vDSP_Length(vector.length))
//    
//    return Vector(elements)
    
    var elements = vector.elements
    
    cblas_sscal(Int32(vector.length), scalar, &elements, 1)
    
    return Vector(elements)
}

/**
    Returns the product of the given scalar and the
    given vector. This means every element in the given
    vector is multiplied with the given scalar.
    The given vector is left untouched.
*/
public func * (scalar: Double, vector: Vector<Double>) -> Vector<Double> {
    
//    var elements = [Double](count: vector.length, repeatedValue: 0)
//    
//    vDSP_vsmulD(vector.elements, 1, [scalar], &elements, 1, vDSP_Length(vector.length))
//    
//    return Vector(elements)
    
    var elements = vector.elements
    
    cblas_dscal(Int32(vector.length), scalar, &elements, 1)
    
    return Vector(elements)
}

/**
    Returns the product of the given scalar and the
    given vector. This means every element in the given
    vector is multiplied with the given scalar.
    The given vector is left untouched.
*/
public func * <T: MatrixCompatible> (vector: Vector<T>, scalar: T) -> Vector<T> {
    
    return scalar * vector
}

/**
    Returns the product of the given scalar and the
    given vector. This means every element in the given
    vector is multiplied with the given scalar.
    The given vector is left untouched.
*/
public func * (vector: Vector<Float>, scalar: Float) -> Vector<Float> {
    
    return scalar * vector
}

/**
    Returns the product of the given scalar and the
    given vector. This means every element in the given
    vector is multiplied with the given scalar.
    The given vector is left untouched.
*/
public func * (vector: Vector<Double>, scalar: Double) -> Vector<Double> {
    
    return scalar * vector
}



/**
    Returns the division of the given vector by the
    given scalar. This means every element in the given
    vector is divided by the given scalar.
    The given vector is left untouched.
*/
public func / <T: MatrixCompatible> (vector: Vector<T>, scalar: T) -> Vector<T> {
    
    var elements = vector.elements
    
    for i in 0 ..< vector.length {
        
        elements[i] = elements[i] / scalar
    }
    
    return Vector(elements)
}

/**
    Returns the division of the given vector by the
    given scalar. This means every element in the given
    vector is divided by the given scalar.
    The given vector is left untouched.
*/
public func / (vector: Vector<Float>, scalar: Float) -> Vector<Float> {
    
    var elements = [Float](repeating: 0, count: vector.length)
    
    vDSP_vsdiv(vector.elements, 1, [scalar], &elements, 1, vDSP_Length(vector.length))
    
    return Vector(elements)
    
//    var elements = vector.copy.elements
//    
//    cblas_sscal(Int32(vector.length), 1/scalar, &elements, 1)
//    
//    return Vector(elements)
}

/**
    Returns the division of the given vector by the
    given scalar. This means every element in the given
    vector is divided by the given scalar.
    The given vector is left untouched.
*/
public func / (vector: Vector<Double>, scalar: Double) -> Vector<Double> {
    
    var elements = [Double](repeating: 0, count: vector.length)
    
    vDSP_vsdivD(vector.elements, 1, [scalar], &elements, 1, vDSP_Length(vector.length))
    
    return Vector(elements)
    
//    var elements = vector.copy.elements
//    
//    cblas_dscal(Int32(vector.length), 1/scalar, &elements, 1)
//    
//    return Vector(elements)
}


// MARK: Vector Dot Product

/**
    Returns the dot product of the two given vectors.
    This is equal to left[0]*right[0] + ... + left[n]*right[n]
    for two vectors of length n+1.

    :exception: An exception will be thrown when the two vectors
                    are not of equal length.
*/
public func vectorDotProduct <T: MatrixCompatible> (_ left: Vector<T>, _ right: Vector<T>) -> T {
    
    if left.length != right.length {
        
        NSException(name: NSExceptionName(rawValue: "Unequal lengths"), reason: "The two given vectors have uneqaul lengths.", userInfo: nil).raise()
    }
    
    return sum(vcombine(left, right){ $0 * $1 })
}

/**
    Returns the dot product of the two given vectors.
    This is equal to left[0]*right[0] + ... + left[n]*right[n]
    for two vectors of length n+1.

    :exception: An exception will be thrown when the two vectors
                    are not of equal length.
*/
public func vectorDotProduct(_ left: Vector<Float>, _ right: Vector<Float>) -> Float {
    
    if left.length != right.length {
        
        NSException(name: NSExceptionName(rawValue: "Unequal lengths"), reason: "The two given vectors have uneqaul lengths.", userInfo: nil).raise()
    }
    
    var result: Float = 0
    
    vDSP_dotpr(left.elements, 1, right.elements, 1, &result, vDSP_Length(left.length))
    
    return result
}

/**
    Returns the dot product of the two given vectors.
    This is equal to left[0]*right[0] + ... + left[n]*right[n]
    for two vectors of length n+1.

    :exception: An exception will be thrown when the two vectors
                    are not of equal length.
*/
public func vectorDotProduct(_ left: Vector<Double>, _ right: Vector<Double>) -> Double {
    
    if left.length != right.length {
        
        NSException(name: NSExceptionName(rawValue: "Unequal lengths"), reason: "The two given vectors have uneqaul lengths.", userInfo: nil).raise()
    }
    
    var result: Double = 0
    
    vDSP_dotprD(left.elements, 1, right.elements, 1, &result, vDSP_Length(left.length))
    
    return result
}



// MARK: Vector Direct Product

/**
    Returns the direct product of the two given vectors.
    This is the product of left as a column vector and
    right as a row vector. The result is a square matrix
    with size equal to the length of the two vectors.

    :exception: An exception will be thrown when the two
                    given vectors are not of equal length.
*/
public func * <T: MatrixCompatible> (left: Vector<T>, right: Vector<T>) -> Matrix<T> {
    
    return vectorDirectProduct(left, right)
}

/**
    Returns the direct product of the two given vectors.
    This is the product of left as a column vector and
    right as a row vector. The result is a square matrix
    with size equal to the length of the two vectors.

    :exception: An exception will be thrown when the two
                    given vectors are not of equal length.
*/
public func * (left: Vector<Float>, right: Vector<Float>) -> Matrix<Float> {
    
    return vectorDirectProduct(left, right)
}

/**
    Returns the direct product of the two given vectors.
    This is the product of left as a column vector and
    right as a row vector. The result is a square matrix
    with size equal to the length of the two vectors.

    :exception: An exception will be thrown when the two
                    given vectors are not of equal length.
*/
public func * (left: Vector<Double>, right: Vector<Double>) -> Matrix<Double> {
    
    return vectorDirectProduct(left, right)
}

/**
    Returns the direct product of the two given vectors.
    This is the product of left as a column vector and
    right as a row vector. The result is a square matrix
    with size equal to the length of the two vectors.

    :exception: An exception will be thrown when the two
                    given vectors are not of equal length.
*/
public func vectorDirectProduct <T: MatrixCompatible> (_ left: Vector<T>, _ right: Vector<T>) -> Matrix<T> {
    
    if left.length != right.length {
        
        NSException(name: NSExceptionName(rawValue: "Unequal lengths"), reason: "The lengths of the two vectors are not equal.", userInfo: nil).raise()
    }
    
    return Matrix(elementsList: left.elements, columns: 1) * Matrix(elementsList: right.elements, rows: 1)
}

/**
    Returns the direct product of the two given vectors.
    This is the product of left as a column vector and
    right as a row vector. The result is a square matrix
    with size equal to the length of the two vectors.

    :exception: An exception will be thrown when the two
                    given vectors are not of equal length.
*/
public func vectorDirectProduct(_ left: Vector<Float>, _ right: Vector<Float>) -> Matrix<Float> {
    
    if left.length != right.length {
        
        NSException(name: NSExceptionName(rawValue: "Unequal lengths"), reason: "The lengths of the two vectors are not equal.", userInfo: nil).raise()
    }
    
    if left.length == 0 {
        return Matrix<Float>()
    }
    
    var elements = [Float](repeating: 0, count: left.length*left.length)
    
    cblas_sgemm(CblasRowMajor, CblasNoTrans, CblasNoTrans, Int32(left.length), Int32(left.length), 1, 1, left.elements, 1, right.elements, Int32(left.length), 1, &elements, Int32(left.length))
    
    return Matrix(elementsList: elements, rows: left.length)
}

/**
    Returns the direct product of the two given vectors.
    This is the product of left as a column vector and
    right as a row vector. The result is a square matrix
    with size equal to the length of the two vectors.

    :exception: An exception will be thrown when the two
                    given vectors are not of equal length.
*/
public func vectorDirectProduct(_ left: Vector<Double>, _ right: Vector<Double>) -> Matrix<Double> {
    
    if left.length != right.length {
        
        NSException(name: NSExceptionName(rawValue: "Unequal lengths"), reason: "The lengths of the two vectors are not equal.", userInfo: nil).raise()
    }
    
    if left.length == 0 {
        return Matrix<Double>()
    }
    
    var elements = [Double](repeating: 0, count: left.length*left.length)
    
    cblas_dgemm(CblasRowMajor, CblasNoTrans, CblasNoTrans, Int32(left.length), Int32(left.length), 1, 1, left.elements, 1, right.elements, Int32(left.length), 1, &elements, Int32(left.length))
    
    return Matrix(elementsList: elements, rows: left.length)
}



// MARK: Vector Functional Methods

/**
    Returns a new vector created by using the given
    transform on every element of the given vector.

    - parameter vector: The vector to map.
    - parameter transform: The function used to transform
                the elements in the given vector.
*/
public func vmap <T: MatrixCompatible, U: MatrixCompatible> (_ vector: Vector<T>, transform: (T) -> U) -> Vector<U> {
    
    return Vector(vector.elements.map(transform))
}

/**
    Returns a single value created by reducing the
    given vector with the given combine function.
    First the combine function is called on the
    given initial value and the first element of
    the given vector. The yielded value is then used
    to combine with the second element of the given
    vector, and so on.

    - parameter vector: The vector to reduce.
    - parameter initial: The initial vector to use in the
                reduction proces.
    - parameter combine: The function used to combine two
                values and reduce the vector.
*/
public func vreduce <T: MatrixCompatible, U> (_ vector: Vector<T>, initial: U, combine: (U, T) -> U) -> U {
    
    return vector.elements.reduce(initial, combine)
}

/**
    Returns a new vector created by combining the
    two given vectors element by element. This means
    the two first elements are combined to form the
    first element of the new vector. The two second
    elements are combined to form the second element
    of the new vector, and so on.

    - parameter left: The first vector in the combination.
                The elements from this vector will be
                passed as first element in the combine
                function.
    - parameter right: The second vector in the combination.
                The elements from this vector will be
                passed as second element in the combine
                function.
    - parameter combine: The function used to combine according
                elements from the two vectors.

    :exception: An exception will be thrown when the
                    two given vectors are not of equal
                    length.
*/
public func vcombine <T: MatrixCompatible, U: MatrixCompatible, V: MatrixCompatible> (_ left: Vector<T>, _ right: Vector<U>, combine: (T, U) -> V) -> Vector<V> {
    
    if left.length != right.length {
        
        NSException(name: NSExceptionName(rawValue: "Unequal lengths"), reason: "The lengths of the two vectors are not equal.", userInfo: nil).raise()
    }
    
    var vectorElements = [V]()
    
    for i in 0 ..< left.length {
        
        vectorElements.append(combine(left[i], right[i]))
    }
    
    return Vector(vectorElements)
}



// MARK: Vector Sorting

/**
    Sorts the given vector in place.

    - parameter vector: The vector to sort in place.
    - parameter ascending: True means the vector should be sorted in
                ascending order, otherwise it's sorted in
                descending order.
*/
public func vsort <T: MatrixCompatible> (_ vector: inout Vector<T>, ascending: Bool = true) {
    
    vector.elements.sort { ascending ? $0 < $1 : $0 > $1 }
}




// MARK: - Additional Structs

// MARK: - VectorGenerator

/**
    A struct representing a vector generator. This is used to
    iterate over the vector.
*/
public struct VectorGenerator <T: MatrixCompatible> : IteratorProtocol {
    
    /**
        The generator of the elements array of the vector.
    */
    fileprivate var generator: IndexingIterator<Array<T>>
    
    /**
        Creates a new generator with the given vector.
    
        - parameter vector: The vector the generator should iterate over.
    */
    public init(vector: Vector<T>) {
        
        self.generator = vector.elements.makeIterator()
    }
    
    /**
        Returns the next element in the vector if there is any.
        Otherwise nil is returned.
    */
    public mutating func next() -> T? {
        return self.generator.next()
    }
}
