//
//  Optimization.swift
//  SwiftMath
//
//  Created by Rugen Heidbuchel on 27/01/15.
//  Copyright (c) 2015 Jorestha Solutions. All rights reserved.
//

import Foundation

open class Optimization {
    
    
    //MARK: Parameters
    open static var accuracy = 1e-7
    open static var maxTime = 10.0
    
    
    open class func goldenSection(_ a0: Double, _ b0: Double, k_max: Int = 100, error err: Double? = nil, maxTime t_m: Double? = nil, f: (Double) -> Double) -> Double {
        
        let start = Date()
        
        let error = err ?? accuracy
        let t_max = t_m ?? maxTime
        
        var a = a0, b = b0
        var v = a + INVERSE_GOLDEN_RATIO*(b-a)
        var fv = f(v)
        var u = a + b - v
        var fu = f(u)
        
        let k = 1
        
        while k <= k_max && b-a > 2*error && Date().timeIntervalSince(start) < t_max {
            
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
