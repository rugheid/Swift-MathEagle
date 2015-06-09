//
//  SequenceFunctionsTests.swift
//  MathEagle
//
//  Created by Rugen Heidbuchel on 09/06/15.
//  Copyright (c) 2015 Jorestha Solutions. All rights reserved.
//

import Cocoa
import XCTest
import MathEagle

class SequenceFunctionsTests: XCTestCase {
    
    
    // MARK: Sum
    
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
        
        let vector = Vector<Float>(randomWithLength: 10_000, intervals: -10.0...10.0)
        XCTAssertEqualWithAccuracy(reduce(vector, 0, +), sum(vector), 1e-7)
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
        
        compareBaseline(0.00408849716186523, title: "10_000 Sequence Sum (Double)", n: 10){
            
            sum(seq)
        }
    }
    
    
    func testSumDoubleVectorBenchmarking() {
        
        calculateBenchmarkingTimes(10, maxPower: 6, title: "Sequence Double Sum Benchmarking"){
            
            let seq = Vector<Double>(randomWithLength: $0)
            
            return timeBlock(n: 10){
                
                sum(seq)
            }
        }
    }
    
    
    
    // MARK: Product
    
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
    
    
    
    // MARK: Min
    
    func testMin() {
        
        let seq1 = [1, 4, 3, 2, 5, 6, 9, 8, 10]
        XCTAssertEqual(1, min(seq1))
        
        let seq2: [UInt] = [4, 2, 1, 7, 6, 4, 2, 3, 8, 9, 0, 3, 2, 1]
        XCTAssertEqual(0, min(seq2))
        
        let vector = Vector([4, 2, 1, 7, 6, 4, 2, 3, 8, 9, 0, 3, 2, 1])
        XCTAssertEqual(0, min(vector))
    }
    
    
    func testMinFloatVector() {
        
        let vector = Vector<Float>([1, 4, 3, 2, 5, 6, 9, 8, 10])
        XCTAssertEqual(1, min(vector))
    }
    
    
    func testMinFloatVectorPerformance() {
        
        let vector = Vector<Float>(randomWithLength: 10_000)
        compareBaseline(0.00356079936027527, title: "10_000 vector minimum (Float)", n: 10){
            min(vector)
        }
    }
    
    
    func testMinFloatVectorBenchmarking() {
        
        calculateBenchmarkingTimes(10, maxPower: 6, title: "Sequence Float Min Benchmarking"){
            
            let seq = Vector<Float>(randomWithLength: $0)
            
            return timeBlock(n: 10){
                
                min(seq)
            }
        }
    }
    
    
    
    // MARK: Max
    
    func testMax() {
        
        let seq1 = [1, 4, 3, 2, 5, 6, 9, 8, 10]
        XCTAssertEqual(10, max(seq1))
        
        let seq2: [UInt] = [4, 2, 1, 7, 6, 4, 2, 3, 8, 9, 0, 3, 2, 1]
        XCTAssertEqual(9, max(seq2))
        
        let vector = Vector([4, 2, 1, 7, 6, 4, 2, 3, 8, 9, 0, 3, 2, 1])
        XCTAssertEqual(9, max(vector))
    }
    
}