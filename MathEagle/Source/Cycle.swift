//
//  Cycle.swift
//  MathEagle
//
//  Created by Rugen Heidbuchel on 31/05/15.
//  Copyright (c) 2015 Jorestha Solutions. All rights reserved.
//


/**
    A class representing a cycle or cyclic permutation. Fixed points are not allowed.
*/
public class Cycle: Permutation {
    
    
    // MARK: Inner Structure
    
    /**
        Represents the cycle. Every element will be replaced by the next element.
        The last element will be replaced by the first.
    
        :example: `[0, 1, 2]`:
                    When this is applied to the array `[1, 2, 3]` this gives `[2, 3, 1]`.
    */
    public var cycleRepresentation: [Int] = []
    
    
    /**
        Returns the array representation of the permutation.
        The indices start at 1. Every element represents the position
        of the element that will take it's place.
    
        :example: [3, 1, 0, 4]
    */
    override public var arrayRepresentation: [Int] {
        
        get {
            var arrayRepresentation = [Int](count: self.length, repeatedValue: 0)
            
            for (index, element) in enumerate(self.cycleRepresentation) {
                arrayRepresentation[element] = self.cycleRepresentation[index == self.length-1 ? 0 : index+1]
            }
            
            return arrayRepresentation
        }
        
        set(newArrayRepresentation) {
            
            //TODO: Implement this
        }
    }
    
    

    // MARK: Initialisers
    
    /**
        Creates a cycle with the given cycle representation.
    */
    public init(cycleRepresentation: [Int]) {
        
        self.cycleRepresentation = cycleRepresentation
        super.init()
    }

    
    
    public convenience required init(arrayLiteral elements: Int...) {
        fatalError("init(arrayLiteral:) has not been implemented")
    }
    
    
    
    // MARK: Properties
    
    /**
        Returns the length of the permutation.
    */
    override public var length: Int {
        
        return self.cycleRepresentation.count
    }
    
    
}
