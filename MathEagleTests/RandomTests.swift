//
//  RandomTests.swift
//  MathEagle
//
//  Created by Rugen Heidbuchel on 01/04/15.
//  Copyright (c) 2015 Jorestha Solutions. All rights reserved.
//

import Cocoa
import XCTest
import MathEagle

class RandomTests: XCTestCase {
    
    
    // MARK: Int
    
    func testIntRandomArrayOfLengthPerformance() {
        
        compareBaseline(0.000257396697998047, title: "Random Int Array of length 10_000", n: 10){
            
            Int.randomArrayOfLength(10_000)
        }
    }
    
    
    
    // MARK: UInt

    func testUIntRandomInInterval() {
        
        for _ in 1 ... 1000 {
            
            var rand = UInt.randomInInterval(0...10)
            XCTAssertTrue(rand >= 0 && rand <= 10)
        }
    }
    
    func testUIntRandomArrayOfLengthPerformance() {
        
        compareBaseline(0.000478798151016235, title: "Random Int Array of length 10_000", n: 10){
            
            UInt.randomArrayOfLength(10_000)
        }
    }
    
    
    
    // MARK: Float
    
    func testFloatRandomArrayOfLength() {
        
        let array = Float.randomArrayOfLength(10_000)
        
        XCTAssertNotEqual(array[0], array[1])
    }
    
    func testFloatRandomArrayOfLengthPerformance() {
        
        compareBaseline(0.000304659207661947, title: "Random Float Array of length 10_000", n: 10){
            
            Float.randomArrayOfLength(10_000)
        }
    }
    
    
    
    // MARK: Double
    
    func testDoubleRandomArrayOfLength() {
        
        let array = Double.randomArrayOfLength(10_000)
        
        XCTAssertNotEqual(array[0], array[1])
    }
    
    func testDoubleRandomArrayOfLengthPerformance() {
        
        compareBaseline(0.000660339991251628, title: "Random Double Array of length 10_000", n: 10){
            
            Double.randomArrayOfLength(10_000)
        }
    }

}
