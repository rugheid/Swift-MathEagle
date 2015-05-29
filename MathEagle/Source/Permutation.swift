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
public class Permutation: ArrayLiteralConvertible, Printable {
    
    
    // MARK: Class Settings
    
    /**
        Defines how the descriptions of Permuations are formatted.
    */
    public static var descriptionType: DescriptionType = .ArrayRepresentation
    
    
    
    // MARK: Inner Structure
    
    /**
        Returns the array representation of the permutation.
        The indices start at 1. Every element represents the position
        of the element that will take it's place.
    
        :example: [3, 1, 0, 4]
    */
    public var arrayRepresentation = [Int]()
    
    
    
    // MARK: Initialisers
    
    /**
        Creates an empty permutation.
    */
    public init() {}
    
    
    /**
        Creates a permutation with the given array representation.
    
        :exception: An exception is thrown when the array representation is not valid.
    */
    public init(_ arrayRepresentation: [Int]) {
        
        if !isValidArrayRepresentation(arrayRepresentation) {
            NSException(name: "Invalid Array Representation", reason: "The given array representation is not a valid array representation.", userInfo: nil).raise()
        }
        
        self.arrayRepresentation = arrayRepresentation
    }
    
    
    /**
        Creates a permutation from an array literal.
    
        :exception: Throws an exception when the array representation is not valid.
    */
    public convenience required init(arrayLiteral elements: Int...) {
        
        self.init(elements)
    }
    
    
    /**
        Creates an identity permutation of the given length.
    
        :param: length  The length of the permutation.
    
        :exception: Throws an exception when the given length is negative.
    */
    public init(identityOfLength length: Int) {
        
        if length < 0 {
            NSException(name: "Negative Length", reason: "A permutation can not have a negative length.", userInfo: nil).raise()
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
        
        :param: index   The index to take the element from.
    */
    public subscript(index: Int) -> Int {
        
        return self.element(index)
    }
    
    
    /**
        Returns the elements at the given index range:
    
        :param: indexRange  The indices to take the elements from.
    */
    public subscript(indexRange: Range<Int>) -> [Int] {
        
        get {
            var slice = [Int]()
            
            for index in indexRange {
                slice.append(self.arrayRepresentation[index])
            }
            
            return slice
        }
        
        set(newElements) {
            self.arrayRepresentation.replaceRange(indexRange, with: newElements)
        }
    }
    
    
    
    // MARK: Properties
    
    /**
        Returns the length of the permutation.
    */
    public var length: Int {
        
        return self.arrayRepresentation.count
    }
    
    
    /**
        Returns a description of the permutation. The formatting of this description can be set
        using Permutation's `descriptionType` property.
    */
    public var description: String {
        
        switch Permutation.descriptionType {
            
        case .ArrayRepresentation:
            
            return self.arrayRepresentation.description
            
        case .WordRepresentation:
            
            return self.wordRepresentation
            
        default:
            
            return self.wordRepresentation
        }
    }
    
    
    /**
        Returns the one-line notation or word representation of the permutation.
    
        :example: 3 2 0 1
    */
    public var wordRepresentation: String {
        
        return reduce(self.arrayRepresentation, ""){ $0 + " \($1)" }
    }
    
    
    
    // MARK: Element Methods
    
    /**
        Returns the element at the given index. This is the element that will take
        the index' place when the permutation is performed.
    
        :exception: Throws an exception when the given index is invalid. This means it's either
                    negative or bigger than the permutation's size.
    */
    public func element(index: Int) -> Int {
        
        if index < 0 || index >= self.length {
            NSException(name: "Invalid Index", reason: "The given index is not valid.", userInfo: nil).raise()
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
    public func indexOfElement(element: Int) -> Int {
        
        if element < 0 || element >= self.length {
            NSException(name: "Invalid Element", reason: "The given element is not valid.", userInfo: nil).raise()
        }
        
        return find(self.arrayRepresentation, element)!
    }
    
    
    
    // MARK: Mutators
    
    /**
        Switches the elements at the given indices.

        :param: fromIndex   The index of the first element.
        :param: toIndex     The index of the second element.
    */
    public func switchElements(i: Int, _ j: Int) {
        
        let temp = self[i]
        self.arrayRepresentation[i] = self[j]
        self.arrayRepresentation[j] = temp
    }
    
    
    
    // MARK: Helper Methods
    
    /**
        Returns whether the given array would be a valid array representation for a permutation.
    
        :param: arrayRepresentation The array to check.
    
        :returns: true if it would be a valid array representation.
    */
    private func isValidArrayRepresentation(arrayRepresentation: [Int]) -> Bool {
        
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
        case ArrayRepresentation
        
        /**
            Indicates one-line notation or a word representation.
        
            :example: 3 2 0 1
        */
        case WordRepresentation
        
        //TODO: Implement cycle notation and transposition notation.
    }
}