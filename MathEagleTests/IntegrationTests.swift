//
//  IntegrationTests.swift
//  SwiftMath
//
//  Created by Rugen Heidbuchel on 26/01/15.
//  Copyright (c) 2015 Rugen Heidbuchel. All rights reserved.
//

import Cocoa
import Foundation
import XCTest
import MathEagle

class IntegrationTests: XCTestCase {
    
    func testMidpoint() {
        
        var I = Integration.midpoint(0.0, 2.0){ $0 }
        XCTAssertEqualWithAccuracy(I, 2.0, accuracy: ACCURACY)
        
        I = Integration.midpoint(0.0, M_PI){ sin($0) }
        XCTAssertEqualWithAccuracy(I, 2.0, accuracy: ACCURACY)
        
        I = Integration.midpoint(1.0, 3.0){ log($0) }
        XCTAssertEqualWithAccuracy(I, 1.295836867, accuracy: ACCURACY)
    }
    
    func testMidpointPerformance() {
        
        let time = timeBlock(n: 1000){
            
            Integration.midpoint(1.0, 3.0){ log($0) }
        }
        
        let baseline = 0.000213389039039612
        
        print("Midpoint time = \(time)\nBaseline = \(baseline)\n\(baseline/time) times faster than baseline")
    }
    
    func testTrapezoid() {
        
        var I = Integration.trapezoid(0.0, 2.0){ $0 }
        XCTAssertEqualWithAccuracy(I, 2.0, accuracy: ACCURACY)
        
        I = Integration.trapezoid(0.0, M_PI){ sin($0) }
        XCTAssertEqualWithAccuracy(I, 2.0, accuracy: ACCURACY)
        
        I = Integration.trapezoid(1.0, 3.0){ log($0) }
        XCTAssertEqualWithAccuracy(I, 1.295836867, accuracy: ACCURACY)
    }
    
    func testTrapezoidPerformance() {
        
        let time = timeBlock(n: 1000){
            
            Integration.trapezoid(1.0, 3.0){ log($0) }
        }
        
        let baseline = 0.000166074991226196
        
        print("Trapezoid time = \(time)\nBaseline = \(baseline)\n\(baseline/time) times faster than baseline")
    }
    
    func testSimpson() {
        
        var I = Integration.simpson(0.0, 2.0){ $0 }
        XCTAssertEqualWithAccuracy(I, 2.0, accuracy: ACCURACY)
        
        I = Integration.simpson(0.0, M_PI){ sin($0) }
        XCTAssertEqualWithAccuracy(I, 2.0, accuracy: ACCURACY)
        
        I = Integration.simpson(1.0, 3.0){ log($0) }
        XCTAssertEqualWithAccuracy(I, 1.295836867, accuracy: ACCURACY)
    }
    
    func testSimpsonPerformance() {
        
        let time = timeBlock(n: 10){
            
            Integration.simpson(1.0, 3.0){ log($0) }
        }
        
        let baseline = 0.616011303663254
        
        print("Simpson time = \(time)\nBaseline = \(baseline)\n\(baseline/time) times faster than baseline")
    }
    
    func testAdaptiveSimpson() {
        
        var I = Integration.adaptiveSimpson(0.0, 2.0){ $0 }
        XCTAssertEqualWithAccuracy(I, 2.0, accuracy: ACCURACY)
        
        I = Integration.adaptiveSimpson(0.0, M_PI){ sin($0) }
        XCTAssertEqualWithAccuracy(I, 2.0, accuracy: ACCURACY)
        
        I = Integration.adaptiveSimpson(1.0, 3.0){ log($0) }
        XCTAssertEqualWithAccuracy(I, 1.295836867, accuracy: ACCURACY)
    }
    
    func testAdaptiveSimpsonPerformance() {
        
        let time = timeBlock(n: 1000){
            
            Integration.adaptiveSimpson(1.0, 3.0){ log($0) }
        }
        
        let baseline = 4.67902421951294e-06
        
        print("Adaptive simpson time = \(time)\nBaseline = \(baseline)\n\(baseline/time) times faster than baseline")
    }
    
}