//
//  OptimizationTests.swift
//  SwiftMath
//
//  Created by Rugen Heidbuchel on 27/01/15.
//  Copyright (c) 2015 Rugen Heidbuchel. All rights reserved.
//

import Cocoa
import XCTest
import MathEagle

class OptimizationTests: XCTestCase {
    
    
    func testGoldenSection() {
        
        var x = Optimization.goldenSection(-3.0, 3.0){ $0**2 + $0 - 4 }
        XCTAssertEqualWithAccuracy(-0.5, x, accuracy: ACCURACY)
        
        let f = { (x: Double) -> Double in
            (log(x**2 + 1) + exp(x))/x
        }
        
        x = Optimization.goldenSection(0.5, 2.0, f: f)
        XCTAssertEqualWithAccuracy(0.8754963230, x, accuracy: ACCURACY)
        
        x = Optimization.goldenSection(-2.0, 1.5){ -sin($0)/$0 }
        XCTAssertEqualWithAccuracy(0.0, x, accuracy: ACCURACY)
    }
    
    func testGoldenSectionPerformance() {
        
        let f = { (x: Double) -> Double in
            (log(x**2 + 1) + exp(x))/x
        }
        
        let time = timeBlock(n: 1000){
            
            Optimization.goldenSection(0.5, 2.0, f: f)
        }
        
        let baseline = 1.0
        
        print("Golden section time = \(time)\nBaseline = \(baseline)\n\(baseline/time) times faster than baseline")
    }
    
}