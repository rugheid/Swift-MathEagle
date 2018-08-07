//
//  Permutation.swift
//  MathEagle
//
//  Created by Rugen Heidbuchel on 27/05/15.
//  Copyright (c) 2015 Jorestha Solutions. All rights reserved.
//

import Foundation


/**
    A class representing a permutation.
*/
open class Permutation: ExpressibleByArrayLiteral, Equatable, CustomStringConvertible, Hashable {
    
    
    // MARK: Class Settings
    
    /**
        Defines how the descriptions of Permuations are formatted.
    */
    open static var descriptionType: DescriptionType = .arrayRepresentation
    
    
    
    // MARK: Inner Structure
    
    /**
        Returns the array representation of the permutation.
        The indices start at 1. Every element represents the position
        of the element that will take it's place.
    
        :example: [3, 1, 0, 4]
    */
    open var arrayRepresentation = [Int]()
    
    
    
    // MARK: Initialisers
    
    /**
        Creates an empty permutation.
    */
    public init() {}
    
    
    /**
        Creates a permutation with the given array representation.
    
        :exception: An exception is thrown when the array representation is not valid.
    */
    public init(arrayRepresentation: [Int]) {
        
        if !isValidArrayRepresentation(arrayRepresentation) {
            NSException(name: NSExceptionName(rawValue: "Invalid Array Representation"), reason: "The given array representation is not a valid array representation.", userInfo: nil).raise()
        }
        
        self.arrayRepresentation = arrayRepresentation
    }
    
    
    /**
        Creates a permutation from an array literal.
    
        :exception: Throws an exception when the array representation is not valid.
    */
    public convenience required init(arrayLiteral elements: Int...) {
        
        self.init(arrayRepresentation: elements)
    }
    
    
    /**
        Creates an identity permutation of the given length.
    
        - parameter length:  The length of the permutation.
    
        :exception: Throws an exception when the given length is negative.
    */
    public init(identity length: Int) {
        
        if length < 0 {
            NSException(name: NSExceptionName(rawValue: "Negative Length"), reason: "A permutation can not have a negative length.", userInfo: nil).raise()
        }
        
        self.arrayRepresentation = []
        
        if length > 0 {
            for i in 0 ..< length {
                self.arrayRepresentation.append(i)
            }
        }
    }
    
    
    
    // MARK: Subscripts
    
    /**
        Returns the element at the given index.
        
        - parameter index:   The index to take the element from.
    */
    open subscript(index: Int) -> Int {
        
        return self.element(index)
    }
    
    
    /**
        Returns the elements at the given index range:
    
        - parameter indexRange:  The indices to take the elements from.
    */
    open subscript(indexRange: CountableClosedRange<Int>) -> [Int] {
        
        get {
            var slice = [Int]()
            
            for index in indexRange {
                slice.append(self.arrayRepresentation[index])
            }
            
            return slice
        }
        
        set(newElements) {
            self.arrayRepresentation.replaceSubrange(indexRange, with: newElements)
        }
    }
    
    
    
    // MARK: Properties
    
    /**
        Returns the length of the permutation.
    */
    open var length: Int {
        
        return self.arrayRepresentation.count
    }
    
    
    /**
        Returns a description of the permutation. The formatting of this description can be set
        using Permutation's `descriptionType` property.
    */
    open var description: String {
        
        switch Permutation.descriptionType {
            
        case .arrayRepresentation:
            
            return self.arrayRepresentation.description
            
        case .wordRepresentation:
            
            return self.wordRepresentation
        }
    }
    
    
    /**
        Returns a hash value for the permutation.
    */
    open var hashValue: Int {
        
        //FIXME: This is a bad implementation, think of a better one.
        return sum(self.arrayRepresentation)
    }
    
    
    /**
        Returns a dictionary representation of the permutation.
    
        :example: [1, 0, 2] is represented as [0: 1, 1: 0, 2: 2]
    */
    open var dictionaryRepresentation: [Int: Int] {
        
        get {
            
            var dict = [Int: Int]()
            
            for (index, element) in self.arrayRepresentation.enumerated() {
                dict[index] = element
            }
            
            return dict
        }
    }
    
    
    /**
        Returns the one-line notation or word representation of the permutation.
    
        :example: 3 2 0 1
    */
    open var wordRepresentation: String {
        
        return self.arrayRepresentation.reduce(""){ $0 + " \($1)" }
    }
    
    
    /**
        Returns a set containing the cycles of this permutation.
    */
    open var cycles: Set<Cycle> {
        
        get {
            
            //TODO: Save memory here by doing everything in place?
            
            var indices = Set<Int>(rampedArray(length: self.length))
            
            let arrayRepresentation = self.arrayRepresentation
            var cycles = Set<Cycle>()
            
            while !indices.isEmpty {
                
                let begin = indices.first!
                let element = arrayRepresentation[begin]
                if element == begin {
                    cycles.insert(Cycle([element]))
                }
                
                var cycle = [begin]
                indices.remove(begin)
                var index = element
                while index != begin {
                    cycle.append(index)
                    indices.remove(index)
                    index = arrayRepresentation[index]
                }
                
                cycles.insert(Cycle(cycle))
            }
            
            return cycles
        }
        
        //TODO: Implement setter
    }
    
    
    /**
        Returns an array containing the fixed points of the permutation in ascending order.
    
        :example: The permutation [0, 2, 1, 3] returns [0, 3]
    */
    open var fixedPoints: [Int] {
        
        var fixedPoints = [Int]()
        
        for (index, element) in self.arrayRepresentation.enumerated() {
            
            if index == element { fixedPoints.append(index) }
        }
        
        return fixedPoints
    }
    
    
    /**
        Returns the number of fixed points of the permutation.
    
        :example: The permutation [0, 2, 1, 3] has 2 fixed points (0 and 3).
    */
    open var numberOfFixedPoints: Int {
        
        var count = 0
        
        for (index, element) in self.arrayRepresentation.enumerated() {
            
            if index == element { count += 1 }
        }
        
        return count
    }
    
    
    /**
        Returns the parity of the permutation. This is the number of transpositions in the transposition
        decomposition.
    */
    open var parity: Parity {
        
        return sum(self.cycles.map{ $0.parity })
    }
    
    
    /**
        Returns the sign (aka signature) of the permutation. This is either 1 if the permutation has an even parity
        or -1 if the permutation has an odd parity.
    */
    open var sign: Int {
        
        return self.parity.sign
    }
    
    
    
    // MARK: Element Methods
    
    /**
        Returns the element at the given index. This is the element that will take
        the index' place when the permutation is performed.
    
        :exception: Throws an exception when the given index is invalid. This means it's either
                    negative or bigger than the permutation's size.
    */
    open func element(_ index: Int) -> Int {
        
        if index < 0 || index >= self.length {
            NSException(name: NSExceptionName(rawValue: "Invalid Index"), reason: "The given index is not valid.", userInfo: nil).raise()
        }
        
        return self.arrayRepresentation[index]
    }
    
    
    /**
        Returns the index of the given element. This means the given element will take
        the returned index' place when the permutation is performed.
    
        :exception: Throws an exception when the given element's value is not valid.
                    This means it's either negative or bigger than the permutation's
                    length.
    
        :complexity: This method runs in O(n), where n is the size of the permutation.
    */
    open func indexOfElement(_ element: Int) -> Int {
        
        if element < 0 || element >= self.length {
            NSException(name: NSExceptionName(rawValue: "Invalid Element"), reason: "The given element is not valid.", userInfo: nil).raise()
        }
        
        return self.arrayRepresentation.index(of: element)!
    }
    
    
    
    // MARK: Mutators
    
    /**
        Switches the elements at the given indices.

        - parameter fromIndex:   The index of the first element.
        - parameter toIndex:     The index of the second element.
    */
    open func switchElements(_ i: Int, _ j: Int) {
        
        let temp = self[i]
        self.arrayRepresentation[i] = self[j]
        self.arrayRepresentation[j] = temp
    }
    
    /**
     Returns the inverse of the permutation.
     */
    open func inverse() -> Permutation {
        var newArrayRepresentation = [Int](repeating: 0, count: self.length)
        for (i, element) in self.arrayRepresentation.enumerated() {
            newArrayRepresentation[element] = i
        }
        return Permutation(arrayRepresentation: newArrayRepresentation)
    }
    
    /**
     Inverses the permutation.
     */
    open func inverseInPlace() {
        var newArrayRepresentation = [Int](repeating: 0, count: self.length)
        for (i, element) in self.arrayRepresentation.enumerated() {
            newArrayRepresentation[element] = i
        }
        self.arrayRepresentation = newArrayRepresentation
    }
    
    
    
    // MARK: Helper Methods
    
    /**
        Returns whether the given array would be a valid array representation for a permutation.
    
        - parameter arrayRepresentation: The array to check.
    
        - returns: true if it would be a valid array representation.
    */
    fileprivate func isValidArrayRepresentation(_ arrayRepresentation: [Int]) -> Bool {
        
        var alreadySeen = Set<Int>()
        let n = arrayRepresentation.count
        
        for element in arrayRepresentation {
            
            if element < 0 || element >= n || alreadySeen.contains(element) {
                
                return false
                
            } else {
                
                alreadySeen.insert(element)
            }
        }
        
        return true
    }
    
    
    
    // MARK: Nested Types
    
    /**
        An enumeration representing the type of description a permutation uses.
    */
    public enum DescriptionType {
        
        /**
            Indicates an array representation type of output.
            
            :example: [3, 2, 0, 1]
        */
        case arrayRepresentation
        
        /**
            Indicates one-line notation or a word representation.
        
            :example: 3 2 0 1
        */
        case wordRepresentation
        
        //TODO: Implement cycle notation and transposition notation.
    }
}



// MARK: Equatable

/**
    Returns whether the two given permutations are equal.

    - parameter left:    The left permutation in the equation.
    - parameter right:   The right permutation in the equation.

    - returns: true if the two permutations are equal.
*/
public func == (left: Permutation, right: Permutation) -> Bool {
    
    return left.arrayRepresentation == right.arrayRepresentation
}
