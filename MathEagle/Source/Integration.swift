//
//  Integration.swift
//  SwiftMath
//
//  Created by Rugen Heidbuchel on 26/01/15.
//  Copyright (c) 2015 Jorestha Solutions. All rights reserved.
//

import Foundation

public class Integration {
    
    
    // MARK: Parameters
    public static var accuracy = 1e-7
    public static var maxTime = 10.0
    
    
    // MARK: single integrals
    
    /**
        Calculates the single integral of f in the interval [a,b] with the given accuracy using midpoint integration.
    
        - parameter a: The beginpoint of the interval.
        - parameter b: The endpoint of the interval.
        - parameter f: The function to integrate.
        - parameter error: The accuracy, this is standard set on 10^-7.
        - parameter k_max: The maximum number of iterations to perform.
        - parameter maxTime: The maximum time (in seconds) the integration can take, this is standard set on 10 seconds.
    
        - returns: The integral of f in the interval [a,b] with the given accuracy.
    */
    public class func midpoint(a: Double, _ b: Double, error err: Double? = nil, k_max: Int = 100, maxTime t_m: Double? = nil, _ f: (Double) -> Double) -> Double {
        
        let start = NSDate()
        
        let error = err ?? accuracy
        let t_max = t_m ?? maxTime
        
        var h = b - a
        var I = h * f( (a + b) * 0.5 )
        
        var converged = false
        var k = 0
        
        while k <= k_max && NSDate().timeIntervalSinceDate(start) < t_max && !converged {
            
            h = h/3
            
            var S = 0.0
            var i = 1.0
            
            while a + i*0.5*h < b {
                
                if i%3 == 0.0 { i += 2; continue }
                
                S += f(a + i*0.5*h)
                i += 2
            }
            
            converged = abs(h*S - 2*I/3) < error
            
            I = I/3 + h*S
            
            k++
        }
        
        return I
    }
    
    
    /**
    Calculates the single integral of f in the interval [a,b] with the given accuracy using trapezoid integration.
    
    - parameter a: The beginpoint of the interval.
    - parameter b: The endpoint of the interval.
    - parameter f: The function to integrate.
    - parameter error: The accuracy, this is standard set on 10^-7.
    - parameter k_max: The maximum number of iterations to perform.
    - parameter maxTime: The maximum time (in seconds) the integration can take, this is standard set on 10 seconds.
    
    - returns: The integral of f in the interval [a,b] with the given accuracy.
    */
    public class func trapezoid(a: Double, _ b: Double, error err: Double? = nil, k_max: Int = 100, maxTime t_m: Double? = nil, _ f: (Double) -> Double) -> Double {
        
        let start = NSDate()
        
        let error = err ?? accuracy
        let t_max = t_m ?? maxTime
        
        var h = b - a
        var I = 0.5 * h * (f(a) + f(b))
        
        var converged = false
        var k = 0.0
        
        while k <= Double(k_max) && NSDate().timeIntervalSinceDate(start) < t_max && !converged {
            
            h = 0.5 * h
            
            var S = 0.0
            var i = 0.0
            
            while i < 2.0 ** k {
                
                S += f(a + (2.0*i + 1.0) * h)
                i += 1.0
            }
            
            let L = h*S
            
            converged = abs(L - 0.5*I) < error
            
            I = 0.5 * I + L
            
            k += 1.0
        }
        
        return I
    }
    
    
    /**
    Calculates the single integral of f in the interval [a,b] with the given accuracy using simpson integration.
    
    - parameter a: The beginpoint of the interval.
    - parameter b: The endpoint of the interval.
    - parameter f: The function to integrate.
    - parameter error: The accuracy, this is standard set on 10^-7.
    - parameter k_max: The maximum number of iterations to perform.
    - parameter maxTime: The maximum time (in seconds) the integration can take, this is standard set on 10 seconds.
    
    - returns: The integral of f in the interval [a,b] with the given accuracy.
    */
    public class func simpson(a: Double, _ b: Double, error err: Double? = nil, k_max: Int = 100, maxTime t_m: Double? = nil, _ f: (Double) -> Double) -> Double {
        
        let start = NSDate()
        
        let error = err ?? accuracy
        let t_max = t_m ?? maxTime
        
        var h = b - a
        var S0 = f( (a+b)*0.5 )
        var I = h/3.0 * ( f(a) + f(b) + 4.0*S0 )
        
        var converged = false
        var k = 0.0
        
        while k <= Double(k_max) && NSDate().timeIntervalSinceDate(start) < t_max && !converged {
            
            h = h * 0.5
            let S = S0
            S0 = 0.0
            var i = 0.0
            
            while i < 2.0 ** k {
                
                S0 += f( a + (2*i + 1)*h )
                i += 1.0
            }
            
            let L = h/3.0 * (4.0*S0 - 2.0*S)
            
            converged = abs(L - 0.5*I) < error
            
            I = 0.5*I + L
            
            k += 1.0
        }
        
        return I
    }
    
    
    /**
    Calculates the single integral of f in the interval [a,b] with the given accuracy using adaptive simpson integration.
    
    - parameter a: The beginpoint of the interval.
    - parameter b: The endpoint of the interval.
    - parameter f: The function to integrate.
    - parameter error: The accuracy, this is standard set on 10^-7.
    - parameter k_max: The maximum number of iterations to perform.
    - parameter maxTime: The maximum time (in seconds) the integration can take, this is standard set on 10 seconds.
    
    - returns: The integral of f in the interval [a,b] with the given accuracy.
    */
    public class func adaptiveSimpson(a: Double, _ b: Double, error err: Double? = nil, _ f: (Double) -> Double) -> Double {
        
        let error = err ?? accuracy
        
        return adaptiveSimpson(a, b, f, error: error, whole: simpsons_rule(a, b, f))
    }
    
    private class func adaptiveSimpson(a: Double, _ b: Double, _ f: (Double) -> Double, error: Double, whole: Double) -> Double {
        
        let c = (a+b)*0.5
        
        let left = simpsons_rule(a, c, f)
        let right = simpsons_rule(c, b, f)
        
        if abs(left + right - whole) <= 15*error {
            
            return left + right + (left + right - whole)/15
        }
        
        return adaptiveSimpson(a, c, f, error: error/2, whole: left) + adaptiveSimpson(c, b, f, error: error/2, whole: right)
    }
    
    private class func simpsons_rule(a: Double, _ b: Double, _ f: (Double) -> Double) -> Double {
        
        let c = (a+b)*0.5
        let h = abs(b-a)/6.0
        
        return h * (f(a) + 4*f(c) + f(b))
    }
    
    /*
        Should still be implemented:
        - Gauss-Kronrod Adaptive Quadrature
        - Clenshaw-Curtis Adaptive Quadrature
        - Double, Triple or even n-dimension Integration functions
    */
    
}