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
class Vector <T: MatrixCompatible> : ArrayLiteralConvertible, Equatable, SequenceType, Printable {
    
    /**
        Returns a list of all elements of the vector.
    */
    var elements = [T]()
    
    /**
        Creates an empty vector. elements will be [], length will be 0.
    */
    init() {}
    
    
    /**
        Creates a vector with the given elements.
    
        :param: elements An array containing the elements of the vector.
    */
    init(_ elements: [T]) {
        
        self.elements = elements
    }
    
    
    /**
        Creates a vector from an array literal.
    */
    required init(arrayLiteral elements: T...) {
        
        self.elements = elements
    }
    
    
    /**
        Creates a vector with the given length using the
        given generator. The generator takes an Int representing
        the index of the element. These indices start at 0 and
        go to length - 1.
    
        :param: length The number of elements the vector should have.
        :param: generator The generator used to generate the elements.
    */
    init(length: Int, generator: (Int) -> T) {
        
        self.elements = map(0..<length){ generator($0) }
    }
    
    
    /**
        Creates a vector of the given length filled with the
        given element.
    
        :param: element The element to fill the vector with.
    */
    convenience init(filledWith element: T, length: Int) {
        
        self.init(length: length, generator: { _ in element })
    }
    
    
    /**
        Creates a random vector with the given length.
        The elements in the vector are generated with
        the random function of the vector's type T.
    
        :param: length The number of elements the vector should have.
    */
    convenience init(randomWithLength length: Int) {
        
        self.init(length: length, generator: { _ in T.random() })
    }
    
    
    /**
        Creates a random vector with the given length.
        The elements in the vector are generated with
        the randomInInterval function of the vector's
        type T. This means the generated values will
        lie within the given interval(s).
    
        :param: length The number of elements the vector should have.
        :param: intervals The intervals in which the random generated
                    elements may lie.
    */
    convenience init(randomWithLength length: Int, intervals: ClosedInterval<T.RandomIntervalType>...) {
        
        self.init(length: length, generator: { _ in T.randomInInterval(intervals) })
    }
    
    
    // MARK: Subscript Methods
    
    /**
        Returns or sets the element at the given index.
    
        :param: index The index of the element to get/set.
    */
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
    
    /**
        Returns the subvector at the given index range.
    
        :param: indexRange A range representing the indices
                    of the subvector.
    */
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
    
    /**
        Returns a generator for the vector.
    */
    func generate() -> VectorGenerator<T> {
        
        return VectorGenerator(vector: self)
    }
    
    
    
    // MARK: Basic Properties
    
    /**
        Returns a copy of the vector.
    */
    var copy: Vector<T> {
        
        return Vector(self.elements)
    }
    
    /**
        Returns a description of the vector.
    
        :example: [1, 2, 3]
    */
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
        Returns the 2-norm. This means
        sqrt(element_0^2 + element_1^2 + ... + element_n^2).
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
        Returns the conjugate of the vector. This means
        every complex value a + bi is replaced by its
        conjugate a - bi. Non-complex values are left
        untouched.
    */
    var conjugate: Vector<T> {
        
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
        Returns the dot product with the given vector. This is the product
        of self as a row vector with the given vector as a column vector.
        The given vector has to be of the same type and length.
    
        :param: vector The vector to multiply with.
    
        :returns: A scalar of the same type as the two vectors.
    */
    func dotProduct(vector: Vector<T>) -> T {
        
        return vectorDotProduct(self, vector)
    }
    
    
    /**
        Returns the direct product with the given vector. This product is
        the product of self as a column vector with the given vector as a
        row vector. The two vectors need to be of the same type and length.
    
        :param: vector The vector to multiply with.
    
        :returns: A square matrix of the same type as the two vectors with
                    size equal to the vector's length.
    */
    func directProduct(vector: Vector<T>) -> Matrix<T> {
        
        return vectorDirectProduct(self, vector)
    }
    
}


// MARK: Vector Equality

/**
    Returns whether two vectors are equal. This means the vector's
    are of the same length and all elements at corresponding indices
    are equal.
*/
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

/**
    Returns the sum of the two given vectors. Both given vectors are left untouched.

    :exception: An exception is thrown when the two vectors are not of equal length.
*/
func + <T: MatrixCompatible> (left: Vector<T>, right: Vector<T>) -> Vector<T> {
    
    if left.length != right.length {
        
        NSException(name: "Unequal lengths", reason: "The left vector's length (\(left.length)) is not equal to the right vector's length (\(right.length))", userInfo: nil).raise()
    }
    
    return vcombine(left, right){ $0 + $1 }
}

/**
    Returns the sum of the two given vectors. Both given vectors are left untouched.

    :exception: An exception is thrown when the two vectors are not of equal length.
*/
func + (left: Vector<Float>, right: Vector<Float>) -> Vector<Float> {
    
    if left.length != right.length {
        
        NSException(name: "Unequal lengths", reason: "The left vector's length (\(left.length)) is not equal to the right vector's length (\(right.length))", userInfo: nil).raise()
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
func + (left: Vector<Double>, right: Vector<Double>) -> Vector<Double> {
    
    if left.length != right.length {
        
        NSException(name: "Unequal lengths", reason: "The left vector's length (\(left.length)) is not equal to the right vector's length (\(right.length))", userInfo: nil).raise()
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
prefix func - <T: MatrixCompatible> (vector: Vector<T>) -> Vector<T> {
    
    return vmap(vector){ -$0 }
}

/**
    Returns the negation of the given vector. The given vector
    is left untouched.
*/
prefix func - (vector: Vector<Float>) -> Vector<Float> {
    
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
prefix func - (vector: Vector<Double>) -> Vector<Double> {
    
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
func - <T: MatrixCompatible> (left: Vector<T>, right: Vector<T>) -> Vector<T> {
    
    if left.length != right.length {
        
        NSException(name: "Unequal lengths", reason: "The left vector's length (\(left.length)) is not equal to the right vector's length (\(right.length))", userInfo: nil).raise()
    }
    
    return vcombine(left, right){ $0 - $1 }
}

/**
    Returns the difference of the two given vectors.

    :exception: An exception is thrown when the two vectors
    are not of equal length.
*/
func - (left: Vector<Float>, right: Vector<Float>) -> Vector<Float> {
    
    if left.length != right.length {
        
        NSException(name: "Unequal lengths", reason: "The left vector's length (\(left.length)) is not equal to the right vector's length (\(right.length))", userInfo: nil).raise()
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
func - (left: Vector<Double>, right: Vector<Double>) -> Vector<Double> {
    
    if left.length != right.length {
        
        NSException(name: "Unequal lengths", reason: "The left vector's length (\(left.length)) is not equal to the right vector's length (\(right.length))", userInfo: nil).raise()
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
func * <T: MatrixCompatible> (scalar: T, vector: Vector<T>) -> Vector<T> {
    
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
func * (scalar: Float, vector: Vector<Float>) -> Vector<Float> {
    
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
func * (scalar: Double, vector: Vector<Double>) -> Vector<Double> {
    
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
func * <T: MatrixCompatible> (vector: Vector<T>, scalar: T) -> Vector<T> {
    
    return scalar * vector
}

/**
    Returns the product of the given scalar and the
    given vector. This means every element in the given
    vector is multiplied with the given scalar.
    The given vector is left untouched.
*/
func * (vector: Vector<Float>, scalar: Float) -> Vector<Float> {
    
    return scalar * vector
}

/**
    Returns the product of the given scalar and the
    given vector. This means every element in the given
    vector is multiplied with the given scalar.
    The given vector is left untouched.
*/
func * (vector: Vector<Double>, scalar: Double) -> Vector<Double> {
    
    return scalar * vector
}



/**
    Returns the division of the given vector by the
    given scalar. This means every element in the given
    vector is divided by the given scalar.
    The given vector is left untouched.
*/
func / <T: MatrixCompatible> (vector: Vector<T>, scalar: T) -> Vector<T> {
    
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
func / (vector: Vector<Float>, scalar: Float) -> Vector<Float> {
    
    var elements = [Float](count: vector.length, repeatedValue: 0)
    
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
func / (vector: Vector<Double>, scalar: Double) -> Vector<Double> {
    
    var elements = [Double](count: vector.length, repeatedValue: 0)
    
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
func vectorDotProduct <T: MatrixCompatible> (left: Vector<T>, right: Vector<T>) -> T {
    
    if left.length != right.length {
        
        NSException(name: "Unequal lengths", reason: "The two given vectors have uneqaul lengths.", userInfo: nil).raise()
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
func vectorDotProduct(left: Vector<Float>, right: Vector<Float>) -> Float {
    
    if left.length != right.length {
        
        NSException(name: "Unequal lengths", reason: "The two given vectors have uneqaul lengths.", userInfo: nil).raise()
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
func vectorDotProduct(left: Vector<Double>, right: Vector<Double>) -> Double {
    
    if left.length != right.length {
        
        NSException(name: "Unequal lengths", reason: "The two given vectors have uneqaul lengths.", userInfo: nil).raise()
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
func * <T: MatrixCompatible> (left: Vector<T>, right: Vector<T>) -> Matrix<T> {
    
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
func * (left: Vector<Float>, right: Vector<Float>) -> Matrix<Float> {
    
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
func * (left: Vector<Double>, right: Vector<Double>) -> Matrix<Double> {
    
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
func vectorDirectProduct <T: MatrixCompatible> (left: Vector<T>, right: Vector<T>) -> Matrix<T> {
    
    if left.length != right.length {
        
        NSException(name: "Unequal lengths", reason: "The lengths of the two vectors are not equal.", userInfo: nil).raise()
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

/**
    Returns the direct product of the two given vectors.
    This is the product of left as a column vector and
    right as a row vector. The result is a square matrix
    with size equal to the length of the two vectors.

    :exception: An exception will be thrown when the two
                    given vectors are not of equal length.
*/
func vectorDirectProduct(left: Vector<Double>, right: Vector<Double>) -> Matrix<Double> {
    
    if left.length != right.length {
        
        NSException(name: "Unequal lengths", reason: "The lengths of the two vectors are not equal.", userInfo: nil).raise()
    }
    
    if left.length == 0 {
        return Matrix<Double>()
    }
    
    var elements = [Double](count: left.length*left.length, repeatedValue: 0)
    
    cblas_dgemm(CblasRowMajor, CblasNoTrans, CblasNoTrans, Int32(left.length), Int32(left.length), 1, 1, left.elements, 1, right.elements, Int32(left.length), 1, &elements, Int32(left.length))
    
    return Matrix(elementsList: elements, rows: left.length)
}



// MARK: Vector Functional Methods

/**
    Returns a new vector created by using the given
    transform on every element of the given vector.

    :param: vector The vector to map.
    :param: transform The function used to transform
                the elements in the given vector.
*/
func vmap <T: MatrixCompatible, U: MatrixCompatible> (vector: Vector<T>, transform: (T) -> U) -> Vector<U> {
    
    return Vector(map(vector.elements, transform))
}

/**
    Returns a single value created by reducing the
    given vector with the given combine function.
    First the combine function is called on the
    given initial value and the first element of
    the given vector. The yielded value is then used
    to combine with the second element of the given
    vector, and so on.

    :param: vector The vector to reduce.
    :param: initial The initial vector to use in the
                reduction proces.
    :param: combine The function used to combine two
                values and reduce the vector.
*/
func vreduce <T: MatrixCompatible, U> (vector: Vector<T>, initial: U, combine: (U, T) -> U) -> U {
    
    return reduce(vector.elements, initial, combine)
}

/**
    Returns a new vector created by combining the
    two given vectors element by element. This means
    the two first elements are combined to form the
    first element of the new vector. The two second
    elements are combined to form the second element
    of the new vector, and so on.

    :param: left The first vector in the combination.
                The elements from this vector will be
                passed as first element in the combine
                function.
    :param: right The second vector in the combination.
                The elements from this vector will be
                passed as second element in the combine
                function.
    :param: combine The function used to combine according
                elements from the two vectors.

    :exception: An exception will be thrown when the
                    two given vectors are not of equal
                    length.
*/
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



// MARK: Vector Sorting

/**
    Sorts the given vector in place.

    :param: vector The vector to sort in place.
    :param: ascending True means the vector should be sorted in
                ascending order, otherwise it's sorted in
                descending order.
*/
func vsort <T: MatrixCompatible> (inout vector: Vector<T>, ascending: Bool = true) {
    
    vector.elements.sort(){ ascending ? $0 < $1 : $0 > $1 }
}




// MARK: - Additional Structs

// MARK: - VectorGenerator

/**
    A struct representing a vector generator. This is used to
    iterate over the vector.
*/
struct VectorGenerator <T: MatrixCompatible> : GeneratorType {
    
    /**
        The generator of the elements array of the vector.
    */
    private var generator: IndexingGenerator<Array<T>>
    
    /**
        Creates a new generator with the given vector.
    
        :param: vector The vector the generator should iterate over.
    */
    init(vector: Vector<T>) {
        
        self.generator = vector.elements.generate()
    }
    
    /**
        Returns the next element in the vector if there is any.
        Otherwise nil is returned.
    */
    mutating func next() -> T? {
        return self.generator.next()
    }
}