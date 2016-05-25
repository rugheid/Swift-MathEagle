//
//  Helper.swift
//  SwiftMath
//
//  Created by Rugen Heidbuchel on 26/01/15.
//  Copyright (c) 2015 Rugen Heidbuchel. All rights reserved.
//

import Foundation
import MathEagle
import XCTest


// MARK: Constants

let ACCURACY = 1e-7


// MARK: Time Helper Functions

func getCoefficients(n0 n0: Int, numberOfIterations k: Int, timeBlock: Int -> Double) -> (Double, Double) {
    
    var prev: Double = 0
    var a: Double = 0, b: Double = 0
    
    for i in 0 ... k {
        
        let n = n0 * Int(pow(2, Double(i)))
        
        let time = timeBlock(n)
        
        if i > 0 {
            
            let ratio = time/prev
            
            b = log2(ratio)
            a = time / pow(Double(n), b)
            
            print("a = \(a), b = \(b) ->  \(a) * n ^ \(b)")
        }
        
        prev = time
    }
    
    return (a, b)
}

func timeBlock(n n: Int = 1, block: Void -> Any) -> Double {
    
    let start = NSDate()
    
    for _ in 1 ... n {
        
        block()
    }
    
    let end = NSDate()
    
    return Double(end.timeIntervalSinceDate(start)) / Double(n)
}

func compareBaseline(baseline: Double, title: String = "", n: Int = 1, block: Void -> Any) {
    
    let time = timeBlock(n: n, block: block)
    
    print("")
    print("")
    if !title.isEmpty {
        print(title)
        print(String(count: title.characters.count, repeatedValue: Character("-")))
    }
    print("Baseline:\t\t\t\t\t\(baseline)")
    print("Time:\t\t\t\t\t\t\(time)")
    print("Times faster than baseline:\t\(baseline/time)")
    print("")
    print("")
}

func calculateBenchmarkingTimes(base: Int, maxPower k: Int, title: String = "", timeBlock: (Int) -> Double) {
    
    print("")
    print("")
    if !title.isEmpty {
        print(title)
        print(String(count: title.characters.count, repeatedValue: Character("-")))
    }
    
    for i in 1 ... k {
        
        let n = Int(base ** Double(i))
        print(timeBlock(n))
    }
    
    print("")
    print("")
}


// MARK: XCT Extensions

func XCTAssertContentEqual <T: Equatable> (expression1: [T], _ expression2: [T]) {
    
    XCTAssertEqual(expression1.count, expression2.count)
    
    for element in expression1 {
        XCTAssertTrue(expression2.contains{ (value) -> Bool in
            return value == element
        })
    }
}
