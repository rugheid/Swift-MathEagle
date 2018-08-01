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
    
    
    // MARK: UInt

    func testUIntRandomInInterval() {
        
        for _ in 1 ... 1000 {
            
            let rand = UInt.randomInInterval(0...10)
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
        
        let length = 1_000_000
        let array = UInt8.randomArrayOfLength(length)
        
        var mean = 0.0
        
        for element in array {
            
            mean += Double(element)/Double(length)
        }
        
        print("Mean = \(mean)")
        XCTAssertEqual(Double(UInt8.max)/2.0, mean, accuracy: 10.0)
    }
    
    func testUInt8RandomArrayOfLengthPermormance() {
        
        compareBaseline(0.000305402278900146, title: "Random UInt8 Array of length 10_000", n: 10){
            
            UInt8.randomArrayOfLength(10_000)
        }
    }
    
    
    
    // MARK: UInt16
    
    func testUInt16RandomArrayOfLength() {
        
        let length = 1_000_000
        let array = UInt16.randomArrayOfLength(length)
        
        var mean = 0.0
        
        for element in array {
            
            mean += Double(element)/Double(length)
        }
        
        print("Mean = \(mean)")
        XCTAssertEqual(Double(UInt16.max)/2.0, mean, accuracy: 100.0)
    }
    
    func testUInt16RandomArrayOfLengthPermormance() {
        
        compareBaseline(0.000304996967315674, title: "Random UInt16 Array of length 10_000", n: 10){
            
            UInt16.randomArrayOfLength(10_000)
        }
    }
    
    
    
    // MARK: UInt32
    
    func testUInt32RandomArrayOfLengthPermormance() {
        
        compareBaseline(0.000248199701309204, title: "Random UInt32 Array of length 10_000", n: 10){
            
            UInt32.randomArrayOfLength(10_000)
        }
    }
    
    
    
    // MARK: UInt64
    
    func testUInt64RandomArrayOfLengthPermormance() {
        
        compareBaseline(0.00044180154800415, title: "Random UInt64 Array of length 10_000", n: 10){
            
            UInt64.randomArrayOfLength(10_000)
        }
    }
    
    
    
    // MARK: Int
    
    func testIntRandomArrayOfLength() {
        
        let length = 10_000
        let array = Int.randomArrayOfLength(length)
        
        var positiveCount = 0
        
        for element in array {
            
            if element > 0 { positiveCount += 1 }
        }
        
        let positiveFraction = Double(positiveCount)/Double(length)
        print("Positive Fraction = \(positiveFraction)")
        XCTAssertEqual(0.5, Double(positiveCount)/Double(length), accuracy: 0.1)
    }
    
    func testIntRandomArrayOfLengthPerformance() {
        
        compareBaseline(0.000473904609680176, title: "Random Int Array of length 10_000", n: 10){
            
            Int.randomArrayOfLength(10_000)
        }
    }
    
    
    
    // MARK: Int8
    
    func testInt8RandomArrayOfLength() {
        
        let length = 1_000_000
        let array = Int8.randomArrayOfLength(length)
        
        var mean = 0.0
        
        for element in array {
            
            mean += Double(element)/Double(length)
        }
        
        print("Mean = \(mean)")
        XCTAssertEqual(0.0, mean, accuracy: 10.0)
    }
    
    func testInt8RandomArrayOfLengthPermormance() {
        
        compareBaseline(0.000310802459716797, title: "Random Int8 Array of length 10_000", n: 10){
            
            UInt8.randomArrayOfLength(10_000)
        }
    }
    
    
    
    // MARK: Int16
    
    func testInt16RandomArrayOfLength() {
        
        let length = 1_000_000
        let array = Int16.randomArrayOfLength(length)
        
        var mean = 0.0
        
        for element in array {
            
            mean += Double(element)/Double(length)
        }
        
        print("Mean = \(mean)")
        XCTAssertEqual(0.0, mean, accuracy: 100.0)
    }
    
    func testInt16RandomArrayOfLengthPermormance() {
        
        compareBaseline(0.000315195322036743, title: "Random Int16 Array of length 10_000", n: 10){
            
            Int16.randomArrayOfLength(10_000)
        }
    }
    
    
    
    // MARK: Int32
    
    func testInt32RandomArrayOfLengthPermormance() {
        
        compareBaseline(0.0002532958984375, title: "Random Int32 Array of length 10_000", n: 10){
            
            Int32.randomArrayOfLength(10_000)
        }
    }
    
    
    
    // MARK: UInt64
    
    func testInt64RandomArrayOfLengthPermormance() {
        
        compareBaseline(0.000450801849365234, title: "Random Int64 Array of length 10_000", n: 10){
            
            Int64.randomArrayOfLength(10_000)
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
