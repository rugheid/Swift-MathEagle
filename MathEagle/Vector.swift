//
//  Vector.swift
//  SwiftMath
//
//  Created by Rugen Heidbuchel on 30/12/14.
//  Copyright (c) 2014 Jorestha Solutions. All rights reserved.
//

import Foundation

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
    
    
    
    // MARK: Computed Properties
    
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
    
    
//    var maxElement: T {
//        
//        
//    }
    
    
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
        
        if self.length != vector.length {
            
            NSException(name: "Unequal lengths", reason: "The lengths of the two vectors are not equal.", userInfo: nil).raise()
        }
        
        return Matrix([self.elements]).transpose * Matrix([vector.elements])
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
    
    return combine(left, right){ $0 + $1 }
}


// MARK: Vector Negation

prefix func - <T: MatrixCompatible> (vector: Vector<T>) -> Vector<T> {
    
    return vmap(vector){ -$0 }
}


// MARK: Vector Substraction

func - <T: MatrixCompatible> (left: Vector<T>, right: Vector<T>) -> Vector<T> {
    
    // To keep this implementation as general as possible, we don't use (left + -right), because T must then be Addable and Negatable.
    // User-defined structs or classes can be Substractable however without being Negatable.
    // You could for example make String Substractable, without making it Negatable.
    
    if left.length != right.length {
        
        NSException(name: "Unequal lengths", reason: "The left vector's length (\(left.length)) is not equal to the right vector's length (\(right.length))", userInfo: nil).raise()
    }
    
    return left + -right
}


// MARK: Vector Scalar Multiplication and Division

func * <T: MatrixCompatible> (scalar: T, vector: Vector<T>) -> Vector<T> {
    
    var elements = vector.elements
    
    for i in 0 ..< vector.length {
        
        elements[i] = elements[i] * scalar
    }
    
    return Vector(elements)
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


// MARK: Vector Direct Product

func * <T: MatrixCompatible> (left: Vector<T>, right: Vector<T>) -> Matrix<T> {
    
    return left.directProduct(right)
}


// MARK: Vector Functional Methods

func vmap <T: MatrixCompatible, U: MatrixCompatible> (vector: Vector<T>, transform: (T) -> U) -> Vector<U> {
    
    return Vector(map(vector.elements, transform))
}

func reduce <T: MatrixCompatible, U> (vector: Vector<T>, initial: U, combine: (U, T) -> U) -> U {
    
    return reduce(vector.elements, initial, combine)
}

func combine <T: MatrixCompatible, U: MatrixCompatible, V: MatrixCompatible> (left: Vector<T>, right: Vector<U>, combine: (T, U) -> V) -> Vector<V> {
    
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