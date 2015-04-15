//
//  OptimizationTests.swift
//  SwiftMath
//
//  Created by Rugen Heidbuchel on 27/01/15.
//  Copyright (c) 2015 Jorestha Solutions. All rights reserved.
//

import Cocoa
import XCTest

class OptimizationTests: XCTestCase {
    
    
    func testGoldenSection() {
        
        var x = Optimization.goldenSection(-3.0, 3.0){ $0**2 + $0 - 4 }
        XCTAssertEqualWithAccuracy(-0.5, x, ACCURACY)
        
        x = Optimization.goldenSection(0.5, 2.0){ (log($0**2 + 1) + exp($0))/$0 }
        XCTAssertEqualWithAccuracy(0.8754963230, x, ACCURACY)
        
        x = Optimization.goldenSection(-2.0, 1.5){ -sin($0)/$0 }
        XCTAssertEqualWithAccuracy(0.0, x, ACCURACY)
    }
    
    func testGoldenSectionPerformance() {
        
        let time = timeBlock(n: 1000){
            
            Optimization.goldenSection(0.5, 2.0){ (log($0**2 + 1) + exp($0))/$0 }
        }
        
        let baseline = 1.0
        
        println("Golden section time = \(time)\nBaseline = \(baseline)\n\(baseline/time) times faster than baseline")
    }
    
}