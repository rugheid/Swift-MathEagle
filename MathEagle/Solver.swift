//
//  Solver.swift
//  SwiftMath
//
//  Created by Rugen Heidbuchel on 26/01/15.
//  Copyright (c) 2015 Jorestha Solutions. All rights reserved.
//

import Foundation

public class Solver {
    
    //MARK: Parameters
    public static var accuracy = 1e-7
    public static var maxTime = 10.0
    
    
    /**
        Returns the zero value of f with the given accuracy, starting with the given interval [a,b] and using the bisection rule. The signs of f(a) and f(b) should not be equal.
    
        :param: a The beginpoint of the interval.
        :param: b The endpoint of the interval.
        :param: f The function to find the zero of.
        :param: accuracy The accuracy, this is standard set on 10^-7.
        :param: maxTime The maximum time (in seconds) the solving should take, this is standard set on 10 seconds.
    
        :returns: The zero value of f.
    
        :exception: An exception will be thrown if the signs of f(a) and f(b) are equal. This means the bisection method can not known whether the interval contains a zero.
    
        :exception: An exception will be thrown if a > b.
    */
    public class func bisection(a: Double, _ b: Double, accuracy err: Double? = nil, maxTime t_m: Double? = nil, _ f: (Double) -> Double) -> Double {
        
        if a > b {
            
            NSException(name: "a > b", reason: "[\(a), \(b)] is not a valid interval. a should be smaller than b.", userInfo: nil).raise()
        }
        
        let start = NSDate()
        
        let error = err ?? accuracy
        let t_max = t_m ?? maxTime
        
        var fa = f(a), fb = f(b)
        
        if sign(fa) == sign(fb) {
            
            NSException(name: "Not shure if given interval contains zero", reason: "The signs of f(a) and f(b) are equal, which means the bisection method cannot narrow the search. You have to provide a valid interval.", userInfo: nil).raise()
        }
        
        var A = a, B = b, x = (A+B)*0.5
        
        while NSDate().timeIntervalSinceDate(start) < t_max && abs(B-A) > 2*error {
            
            let fx = f(x)
            
            if sign(fx) == sign(fb) {
                
                B = x
                fb = fx
                
            } else {
                
                A = x
                fa = fx
            }
            
            x = (A+B)*0.5
        }
        
        return x
    }
    
    
    /**
        Returns a zero value of f with the given accuracy, starting with x0 and using Newton's method. You can explicitley pass the derivative as well, otherwise the derivative will be approximated.
    
        :param: x0 The starting point for the iteration.
        :param: f The function to find the zero of.
        :param: accuracy The accuracy, this is standard set on 10^-7.
        :param: k_max The maximum allowed number of iterations.
        :param: maxTime The maximum time (in seconds) the solving should take, this is standard set on 10 seconds.
    
        :returns: The zero value of f.
    */
    public class func newton(x0: Double, df: ((Double) -> Double)? = nil, accuracy err: Double? = nil, k_max: Int = 100, maxTime t_m: Double? = nil, f: (Double) -> Double) -> Double {
        
        let start = NSDate()
        
        let error = err ?? accuracy
        let t_max = t_m ?? maxTime
        let shouldApproximateDf = (df == nil)
        
        var converged = false
        var k = 1
        var x = x0
        
        while k <= k_max && NSDate().timeIntervalSinceDate(start) < t_max && !converged {
            
            let xprev = x
            let diff = shouldApproximateDf ? (f(x + accuracy) - f(x - accuracy))/(2 * accuracy) : df!(x)
            
            x = x - f(x)/diff
            converged = abs(x - xprev) <= error
            
            k++
        }
        
        return x
    }
    
}