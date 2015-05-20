//
//  FunctionsTests.swift
//  SwiftMath
//
//  Created by Rugen Heidbuchel on 27/01/15.
//  Copyright (c) 2015 Jorestha Solutions. All rights reserved.
//

import Cocoa
import XCTest

class FunctionsTests: XCTestCase {
    
    
    func testSign() {
        
        var x = -1.2
        XCTAssertEqual(-1, sign(x))
        
        x = 3.4
        XCTAssertEqual(1, sign(x))
        
        x = 0
        XCTAssertEqual(0, sign(x))
    }
    
    
    func testDivisors() {
        
        XCTAssertEqual([1, 5], divisors(5))
        XCTAssertEqual([1, 2, 4, 5, 10, 20], divisors(20))
        XCTAssertEqual([1, 2, 4, 5, 8, 10, 20, 25, 40, 50, 100, 125, 200, 250, 500, 1000], divisors(1000))
    }
    
    
    func testProperDivisors() {
        
        XCTAssertEqual([1], properDivisors(5))
        XCTAssertEqual([1, 2, 4, 5, 10], properDivisors(20))
        XCTAssertEqual([1, 2, 4, 5, 8, 10, 20, 25, 40, 50, 100, 125, 200, 250, 500], properDivisors(1000))
    }
    
    
    func testIsPerfect() {
        
        for i: UInt in 1 ... 60 {
            
            if i == 6 || i == 28 {
                XCTAssertTrue(isPerfect(i))
            } else {
                XCTAssertFalse(isPerfect(i))
            }
        }
    }
    
    
    func testIsAbundant() {
        
        for i: UInt in 1 ... 60 {
            
            let abundants: [UInt] = [12, 18, 20, 24, 30, 36, 40, 42, 48, 54, 56, 60]
            
            if contains(abundants, i) {
                XCTAssertTrue(isAbundant(i))
            } else {
                let abundant = isAbundant(i)
                XCTAssertFalse(abundant)
            }
        }
    }
    
    
    func testGCD() {
        
        XCTAssertEqual(5, gcd(0, 5))
        XCTAssertEqual(5, gcd(5, 0))
        XCTAssertEqual(0, gcd(0, 0))
        XCTAssertEqual(1, gcd(13, 5))
        XCTAssertEqual(10, gcd(20, 10))
        XCTAssertEqual(5, gcd(34510, 431195))
        XCTAssertEqual(2, gcd(33234, 58798))
        XCTAssertEqual(1, gcd(13, -5))
        XCTAssertEqual(10, gcd(-20, -10))
    }
    
    
    func testLCM() {
        
        XCTAssertEqual(0, lcm(0, 0))
        XCTAssertEqual(0, lcm(0, 5))
        XCTAssertEqual(0, lcm(5, 0))
        XCTAssertEqual(60, lcm(10, 12))
        XCTAssertEqual(65, lcm(13, 5))
        XCTAssertEqual(2_976_107_890, lcm(34510, 431195))
        XCTAssertEqual(60, lcm(-10, 12))
        XCTAssertEqual(65, lcm(13, -5))
        XCTAssertEqual(2_976_107_890, lcm(-34510, -431195))
    }
    
    
    func testFactorial() {
        
        let fact = Vector(length: 10, generator: factorial)
        let expected = Vector([1, 1, 2, 6, 24, 120, 720, 5_040, 40_320, 362_880])
        
        XCTAssertEqual(expected, fact)
    }
    
    
    func testFib() {
        
        let fibonacci = Vector(length: 11, generator: fib)
        let expected = Vector([0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55])
        
        XCTAssertEqual(expected, fibonacci)
        
        XCTAssertEqual(832_040, fib(30))
    }
    
    
    func testFibPerformance() {
        
        let (a, b) = getCoefficients(n0: 5, numberOfIterations: 4){ x in
            
            return timeBlock(n: 40){
                
                fib(x)
            }
        }
        
        println()
        println("Fibonacci: \(a)*n^\(b)")
        println()
    }
    
    
    // MARK: Sequence Functions Tests
    
    func testSum() {
        
        var seq1 = [1, 2, 3, 4, 5, 6]
        XCTAssertEqual(21, sum(seq1))
        
        let seq2: [UInt] = [1, 2, 3, 4, 5, 6]
        XCTAssertEqual(21 as UInt, sum(seq2))
        
        seq1 = []
        XCTAssertEqual(0, sum(seq1))
        
        let seq3 = [1.0, -2.0, 3.0, -4.0, 5.0, -6.0]
        XCTAssertEqual(-3.0, sum(seq3))
    }
    
    func testSumFloatVector() {
        
        let vector = Vector<Float>(randomWithLength: 10_000)
        XCTAssertEqual(reduce(vector, 0, +), sum(vector))
    }
    
    func testSumFloatVectorPerformance() {
        
        let seq = Vector<Float>(randomWithLength: 10_000)
        
        compareBaseline(0.00408849716186523, title: "10_000 Sequence Sum (Float)", n: 10){
            
            sum(seq)
        }
    }
    
    func testSumFloatVectorBenchmarking() {
        
        calculateBenchmarkingTimes(10, maxPower: 6, title: "Sequence Float Sum Benchmarking"){
            
            let seq = Vector<Float>(randomWithLength: $0)
            
            return timeBlock(n: 10){
                
                sum(seq)
            }
        }
    }
    
    func testSumDoubleVector() {
        
        let vector = Vector<Double>(randomWithLength: 10_000)
        XCTAssertEqual(reduce(vector, 0, +), sum(vector))
    }
    
    func testSumDoubleVectorPerformance() {
        
        let seq = Vector<Double>(randomWithLength: 10_000)
        
        compareBaseline(0.00408849716186523, title: "10_000 Sequence Sum (Float)", n: 10){
            
            sum(seq)
        }
    }
    
    func testSumDoubleVectorBenchmarking() {
        
        calculateBenchmarkingTimes(10, maxPower: 6, title: "Sequence Float Sum Benchmarking"){
            
            let seq = Vector<Double>(randomWithLength: $0)
            
            return timeBlock(n: 10){
                
                sum(seq)
            }
        }
    }
    
    func testProduct() {
        
        var seq1 = [1, 2, 3, 4, 5, 6]
        XCTAssertEqual(720, product(seq1))
        
        let seq2: [UInt] = [1, 2, 3, 4, 5, 6]
        XCTAssertEqual(720 as UInt, product(seq2))
        
        seq1 = []
        XCTAssertEqual(1, product(seq1))
        
        let seq3 = [1.0, -2.0, 3.0, -4.0, 5.0, -6.0]
        XCTAssertEqual(-720.0, product(seq3))
    }
    
    func testMin() {
        
        let seq1 = [1, 4, 3, 2, 5, 6, 9, 8, 10]
        XCTAssertEqual(1, min(seq1))
        
        let seq2: [UInt] = [4, 2, 1, 7, 6, 4, 2, 3, 8, 9, 0, 3, 2, 1]
        XCTAssertEqual(0, min(seq2))
        
        let vector = Vector([4, 2, 1, 7, 6, 4, 2, 3, 8, 9, 0, 3, 2, 1])
        XCTAssertEqual(0, min(vector))
    }
    
    func testMax() {
        
        let seq1 = [1, 4, 3, 2, 5, 6, 9, 8, 10]
        XCTAssertEqual(10, max(seq1))
        
        let seq2: [UInt] = [4, 2, 1, 7, 6, 4, 2, 3, 8, 9, 0, 3, 2, 1]
        XCTAssertEqual(9, max(seq2))
        
        let vector = Vector([4, 2, 1, 7, 6, 4, 2, 3, 8, 9, 0, 3, 2, 1])
        XCTAssertEqual(9, max(vector))
    }
    
}