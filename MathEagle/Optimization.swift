//
//  Optimization.swift
//  SwiftMath
//
//  Created by Rugen Heidbuchel on 27/01/15.
//  Copyright (c) 2015 Jorestha Solutions. All rights reserved.
//

import Foundation

var OPTIMIZATION_ACCURACY = 1e-7
var OPTIMIZATION_MAX_TIME = 10.0

class Optimization {
    
    class func goldenSection(a0: Double, _ b0: Double, _ f: (Double) -> Double, k_max: Int = 100, error err: Double? = nil, maxTime t_m: Double? = nil) -> Double {
        
        let start = NSDate()
        
        let error = err ?? OPTIMIZATION_ACCURACY
        let t_max = t_m ?? OPTIMIZATION_MAX_TIME
        
        let phi = (sqrt(5.0) - 1.0)/2.0
        
        var a = a0, b = b0
        var v = a + phi*(b-a)
        var fv = f(v)
        var u = a + b - v
        var fu = f(u)
        
        var k = 1
        
        while k <= k_max && b-a > 2*error {
            
            if fu >= fv {
                
                a = u
                u = v
                fu = fv
                v = b - u + a
                fv = f(v)
                
            } else {
                
                b = v
                v = u
                fv = fu
                u = a + b - v
                fu = f(u)
            }
        }
        
        return (a+b)/2
    }
}