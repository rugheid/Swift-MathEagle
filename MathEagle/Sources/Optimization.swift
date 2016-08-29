//
//  Optimization.swift
//  SwiftMath
//
//  Created by Rugen Heidbuchel on 27/01/15.
//  Copyright (c) 2015 Jorestha Solutions. All rights reserved.
//

import Foundation

public class Optimization {
    
    
    //MARK: Parameters
    public static var accuracy = 1e-7
    public static var maxTime = 10.0
    
    
    public class func goldenSection(a0: Double, _ b0: Double, k_max: Int = 100, error err: Double? = nil, maxTime t_m: Double? = nil, f: (Double) -> Double) -> Double {
        
        let start = NSDate()
        
        let error = err ?? accuracy
        let t_max = t_m ?? maxTime
        
        var a = a0, b = b0
        var v = a + INVERSE_GOLDEN_RATIO*(b-a)
        var fv = f(v)
        var u = a + b - v
        var fu = f(u)
        
        let k = 1
        
        while k <= k_max && b-a > 2*error && NSDate().timeIntervalSinceDate(start) < t_max {
            
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