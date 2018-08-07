//
//  Cycle.swift
//  MathEagle
//
//  Created by Rugen Heidbuchel on 31/05/15.
//  Copyright (c) 2015 Jorestha Solutions. All rights reserved.
//


/**
    A class representing a cycle in a permutation.
*/
open class Cycle: ExpressibleByArrayLiteral, CustomStringConvertible, Hashable {
    
    
    // MARK: Inner Structure
    
    /**
        Represents the cycle. Every element will be replaced by the next element.
        The last element will be replaced by the first.
    
        :example: `[0, 1, 2]`:
                    When this is applied to the array `[1, 2, 3]` this gives `[2, 3, 1]`.
    */
    open var cycleRepresentation: [Int] = []
    
    

    // MARK: Initialisers
    
    /**
        Creates an empty cycle.
    */
    public init() {}
    
    
    /**
        Creates a cycle with the given cycle representation.
    */
    public init(_ cycleRepresentation: [Int]) {
        
        self.cycleRepresentation = cycleRepresentation
    }

    
    /**
        Creates a cycle with the given cycle representation.
    */
    public convenience required init(arrayLiteral elements: Int...) {
        
        self.init(elements)
    }
    
    
    
    // MARK: Properties
    
    /**
        Returns a dictionary representation of the cycle.
    
        :example: (3 4 7) gives [3: 4, 4: 7, 7: 3]
    */
    open var dictionaryRepresentation: [Int: Int] {
        
        get {
            
            var dict = [Int: Int]()
            
            for (index, element) in self.cycleRepresentation.enumerated() {
                
                dict[element] = self.cycleRepresentation[index == self.length-1 ? 0 : index+1]
            }
            
            return dict
        }
    }
    
    
    /**
        Returns the length of the cycle.
    */
    open var length: Int {
        
        return self.cycleRepresentation.count
    }
    
    
    /**
        Retursn the parity of the cycle. The cycle is even when it's length is odd.
    */
    open var parity: Parity {
        
        return self.length % 2 == 0 ? .odd : .even
    }
    
    
    /**
        Returns a description of the cycle.
    
        :example: (4 3 2)
    */
    open var description: String {
        
        let combine = { (a: String, b: Int) in a + (a == "" ? "" : " ") + "\(b)" }
        
        return "(" + self.cycleRepresentation.reduce("", combine) + ")"
    }
    
    
    /**
        Returns a hash value for the cycle.
    */
    open var hashValue: Int {
        
        //FIXME: This is a bad implementation
        return sum(self.cycleRepresentation)
    }
    
    
}



// MARK: Equatable

/**
    Returns whether the two given cycles are equal. This means they have the same effect.
    Note that the cycle representations may vary.
*/
public func == (left: Cycle, right: Cycle) -> Bool {
    
    //TODO: This has to be more efficient
    return left.dictionaryRepresentation == right.dictionaryRepresentation
}
