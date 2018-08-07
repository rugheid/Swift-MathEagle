//
//  SolverTests.swift
//  SwiftMath
//
//  Created by Rugen Heidbuchel on 26/01/15.
//  Copyright (c) 2015 Jorestha Solutions. All rights reserved.
//

import Cocoa
import XCTest
import MathEagle

class SolverTests: XCTestCase {
    
    
    func testBisection() {

        var x = Solver.bisection(-1.0, 1.0){ $0 }
        XCTAssertEqual(0.0, x, accuracy: ACCURACY)
        
        x = Solver.bisection(0.0, 5.0){ (1 - sqrt($0))/log($0 + 5) }
        XCTAssertEqual(1.0, x, accuracy: ACCURACY)
        
        x = Solver.bisection(-0.5, 5.0){ ($0**4 - 1)/exp(2*$0) }
        XCTAssertEqual(1.0, x, accuracy: ACCURACY)
    }
    
    func testBisectionPerformance() {
        
        let time = timeBlock(n: 1000){
            
            Solver.bisection(-0.5, 5.0){ ($0**4 - 1)/exp(2*$0) }
        }
        
        let baseline = 6.36100769042969e-06
        
        print("Bisection time = \(time)\nBaseline = \(baseline)\n\(baseline/time) times faster than baseline")
    }
    
    func testNewtonWithExactDf() {
        
        var x = Solver.newton(1.0, df: { (x) -> Double in 1.0 }, f: { $0 })
        XCTAssertEqual(0.0, x, accuracy: ACCURACY)
        
        var df = {(x: Double) -> Double in
            
            var a = log(x+5.0) * x - 2.0*x
            a += 5.0*log(x+5.0) + 2.0*sqrt(x)
            let b = sqrt(x)*(log(x+5.0)**2.0)*(x+5.0)
            
            return -0.5*a/b
        }
        
        x = Solver.newton(0.5, df: df, f: { (1 - sqrt($0))/log($0 + 5) })
        XCTAssertEqual(1.0, x, accuracy: ACCURACY)
        
        df = {(x: Double) -> Double in
            
            let a = -2.0*exp(-2.0*x)
            let b = x**4.0 - 2.0*x**3.0 - 1.0
            
            return a*b
        }
        
        x = Solver.newton(-0.5, df: df, f: { ($0**4 - 1)/exp(2*$0) })
        XCTAssertEqual(1.0, x, accuracy: ACCURACY)
    }
    
    func testNewtonWithExactDfPerformance() {
        
        let time = timeBlock(n: 1000){
            
            let df = {(x: Double) -> Double in
                
                let a = -2.0*exp(-2.0*x)
                let b = x**4.0 - 2.0*x**3.0 - 1.0
                
                return a*b
            }
            
            return Solver.newton(-0.5, df: df, f: { ($0**4.0 - 1.0)/exp(2.0*$0) })
        }
        
        let baseline = 3.12000513076782e-06
        
        print("Exact Newton time = \(time)\nBaseline = \(baseline)\n\(baseline/time) times faster than baseline")
    }
    
    func testNewtonWithApproxDf() {
        
        var x = Solver.newton(1.0, f: { $0 })
        XCTAssertEqual(0.0, x, accuracy: ACCURACY)
        
        x = Solver.newton(0.5, f: { (1 - sqrt($0))/log($0 + 5) })
        XCTAssertEqual(1.0, x, accuracy: ACCURACY)
        
        x = Solver.newton(-0.5, f: { ($0**4 - 1)/exp(2*$0) })
        XCTAssertEqual(1.0, x, accuracy: ACCURACY)
    }
    
    func testNewtonWithApproxDfPerformance() {
        
        let time = timeBlock(n: 1000){
            
            return Solver.newton(-0.5, f: { ($0**4.0 - 1.0)/exp(2.0*$0) })
        }
        
        let baseline = 3.23200225830078e-06
        
        print("Approx Newton time = \(time)\nBaseline = \(baseline)\n\(baseline/time) times faster than baseline")
    }
    
}
