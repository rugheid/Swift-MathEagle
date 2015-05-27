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
public class Permutation: Printable {
    
    
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
    
        :example: [4, 2, 1, 3]
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
    public init(arrayRepresentation: [Int]) {
        
        if !isValidArrayRepresentation(arrayRepresentation) {
            NSException(name: "Invalid Array Representation", reason: "The given array representation is not a valid array representation.", userInfo: nil).raise()
        }
        
        self.arrayRepresentation = arrayRepresentation
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
            for i in 1 ... length {
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
        
        get {
            return self.arrayRepresentation[index]
        }
        
        set(newElement) {
            self.arrayRepresentation[index] = newElement
        }
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
    
        :example: 4 3 1 2
    */
    public var wordRepresentation: String {
        
        return reduce(self.arrayRepresentation, ""){ $0 + " \($1)" }
    }
    
    
    
    // MARK: Mutators
    
    /**
        Switches the elements at the given indices.

        :param: fromIndex   The index of the first element.
        :param: toIndex     The index of the second element.
    */
    public func switchElements(i: Int, j: Int) {
        
        let temp = self[i]
        self[i] = self[j]
        self[j] = temp
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
            
            if element < 1 || element > n || alreadySeen.contains(element) {
                
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
            
            :example: [4, 3, 1, 2]
        */
        case ArrayRepresentation
        
        /**
            Indicates one-line notation or a word representation.
        
            :example: 4 3 1 2
        */
        case WordRepresentation
        
        //TODO: Implement cycle notation and transposition notation.
    }
}