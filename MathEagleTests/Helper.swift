//
//  Helper.swift
//  SwiftMath
//
//  Created by Rugen Heidbuchel on 26/01/15.
//  Copyright (c) 2015 Jorestha Solutions. All rights reserved.
//

import Foundation


// MARK: Constants

let ACCURACY = 1e-7


// MARK: Time Helper Functions

func getCoefficients(#n0: Int, numberOfIterations k: Int, timeBlock: Int -> Double) -> (Double, Double) {
    
    var prev: Double = 0
    var a: Double = 0, b: Double = 0
    
    for i in 0 ... k {
        
        let n = n0 * Int(pow(2, Double(i)))
        
        let time = timeBlock(n)
        
        if i > 0 {
            
            let ratio = time/prev
            
            b = log2(ratio)
            a = time / pow(Double(n), b)
            
            println("a = \(a), b = \(b) ->  \(a) * n ^ \(b)")
        }
        
        prev = time
    }
    
    return (a, b)
}

func timeBlock(n: Int = 1, block: Void -> Any) -> Double {
    
    var start = NSDate()
    
    for _ in 1 ... n {
        
        block()
    }
    
    var end = NSDate()
    
    return Double(end.timeIntervalSinceDate(start)) / Double(n)
}

func compareBaseline(baseline: Double, title: String = "", n: Int = 1, block: Void -> Any) {
    
    let time = timeBlock(n: n, block)
    
    println()
    println()
    if !title.isEmpty {
        println(title)
        println(String(count: count(title), repeatedValue: Character("-")))
    }
    println("Baseline:\t\t\t\t\t\(baseline)")
    println("Time:\t\t\t\t\t\t\(time)")
    println("Times faster than baseline:\t\(baseline/time)")
    println()
    println()
}