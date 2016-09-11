//
//  Solver.swift
//  SwiftMath
//
//  Created by Rugen Heidbuchel on 26/01/15.
//  Contributed by Benzi Ahamed on 23/05/16.
//  Copyright (c) 2015 Jorestha Solutions. All rights reserved.
//

import Foundation


/**
 *  A structs that provides static methods for solving functions.
 */
public struct Solver {
    
    //MARK: Parameters
    public static var maxTime = 10.0
    
    /**
        Returns the zero value of f with the given accuracy, starting with the given interval [a,b] and using the bisection rule. The signs of f(a) and f(b) should not be equal.
    
        - parameter a: The beginpoint of the interval.
        - parameter b: The endpoint of the interval.
        - parameter f: The function to find the zero of.
        - parameter accuracy: The accuracy, this is standard set on 10^-7.
        - parameter maxTime: The maximum time (in seconds) the solving should take, this is standard set on 10 seconds.
    
        - returns: The zero value of f.
    
        :exception: An exception will be thrown if the signs of f(a) and f(b) are equal. This means the bisection method can not known whether the interval contains a zero.
    
        :exception: An exception will be thrown if a > b.
    */
    public static func bisection <T: Addable & Subtractable & Equatable & Comparable & ExpressibleByIntegerLiteral & Negatable & Multiplicable & ExpressibleByFloatLiteral> (_ a: T, _ b: T, accuracy error: T = 1e-7, maxTime t_m: Double? = nil, _ f: (T) -> T) -> T {
        
        if a > b {
            
            NSException(name: NSExceptionName(rawValue: "a > b"), reason: "[\(a), \(b)] is not a valid interval. a should be smaller than b.", userInfo: nil).raise()
        }
        
        let start = Date()
        
        let t_max = t_m ?? maxTime
        
        var fa = f(a), fb = f(b)
        
        if sign(fa) == sign(fb) {
            
            NSException(name: NSExceptionName(rawValue: "Not sure if given interval contains zero"), reason: "The signs of f(a) and f(b) are equal, which means the bisection method cannot narrow the search. You have to provide a valid interval.", userInfo: nil).raise()
        }
        
        var A = a, B = b, x = (A+B)*0.5
        
        while Date().timeIntervalSince(start) < t_max && abs(B-A) > 2*error {
            
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
    
        - parameter x0: The starting point for the iteration.
        - parameter f: The function to find the zero of.
        - parameter accuracy: The accuracy, this is standard set on 10^-7.
        - parameter k_max: The maximum allowed number of iterations.
        - parameter maxTime: The maximum time (in seconds) the solving should take, this is standard set on 10 seconds.
    
        - returns: The zero value of f.
    */
    public static func newton <T: Addable & Subtractable & Negatable & Multiplicable & Dividable & ExpressibleByIntegerLiteral & ExpressibleByFloatLiteral & Equatable & Comparable> (_ x0: T, df: ((T) -> T)? = nil, accuracy error: T = 1e-7, k_max: Int = 100, maxTime t_m: Double? = nil, f: (T) -> T) -> T {
        
        let start = Date()
        
        let t_max = t_m ?? maxTime
        let shouldApproximateDf = (df == nil)
        
        var converged = false
        var k = 1
        var x = x0
        
        while k <= k_max && Date().timeIntervalSince(start) < t_max && !converged {
            
            let xprev = x
            let diff = shouldApproximateDf ? (f(x + error) - f(x - error))/(2 * error) : df!(x)
            
            x = x - f(x)/diff
            converged = abs(x - xprev) <= error
            
            k += 1
        }
        
        return x
    }
    
}
