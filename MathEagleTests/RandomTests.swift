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
    
    func testIntRandomArrayOfLength() {
        
        let length = 10_000
        let array = Int.randomArrayOfLength(length)
        
        var positiveCount = 0
        
        for element in array {
            
            if element > 0 { positiveCount++ }
        }
        
        let positiveFraction = Double(positiveCount)/Double(length)
        println("Positive Fraction = \(positiveFraction)")
        XCTAssertEqualWithAccuracy(0.5, Double(positiveCount)/Double(length), 0.1)
    }
    
    func testIntRandomArrayOfLengthPerformance() {
        
        compareBaseline(0.000473904609680176, title: "Random Int Array of length 10_000", n: 10){
            
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
    
    func testUIntRandomArrayOfLength() {
        
        let array = UInt.randomArrayOfLength(10_000)
        
        XCTAssertNotEqual(array[0], array[1])
    }
    
    func testUIntRandomArrayOfLengthPerformance() {
        
        compareBaseline(0.000478798151016235, title: "Random UInt Array of length 10_000", n: 10){
            
            UInt.randomArrayOfLength(10_000)
        }
    }
    
    
    
    // MARK: UInt8
    
    func testUInt8RandomArrayOfLength() {
        
        let array = UInt8.randomArrayOfLength(10_000)
        
        XCTAssertNotEqual(array[0], array[1])
    }
    
    func testUInt8RandomArrayOfLengthPermormance() {
        
        compareBaseline(0.000305402278900146, title: "Random UInt8 Array of length 10_000", n: 10){
            
            UInt8.randomArrayOfLength(10_000)
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
