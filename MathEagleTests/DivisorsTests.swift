//
//  DivisorsTests.swift
//  MathEagle
//
//  Created by Rugen Heidbuchel on 06/06/15.
//  Copyright (c) 2015 Jorestha Solutions. All rights reserved.
//

import XCTest
import MathEagle


class DivisorsTests: XCTestCase {
    
    func testDivisors() {
        
        XCTAssertEqual([1, 5], divisors(5))
        XCTAssertEqual([1, 2, 4], divisors(4))
        XCTAssertEqual([1, 2, 4, 5, 10, 20], divisors(20))
        XCTAssertEqual([1, 2, 4, 5, 8, 10, 20, 25, 40, 50, 100, 125, 200, 250, 500, 1000], divisors(1000))
    }
    
    
    func testProperDivisors() {
        
        XCTAssertEqual([1], properDivisors(5))
        XCTAssertEqual([1, 2], properDivisors(4))
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
            
            if abundants.contains(i) {
                XCTAssertTrue(isAbundant(i))
            } else {
                XCTAssertFalse(isAbundant(i))
            }
        }
    }
    
    
    func testAbundantsUpTo() {
        
        let abundants: Set<Int> = [12, 18, 20, 24, 30, 36, 40, 42, 48, 54, 56, 60]
        XCTAssertEqual(abundants, abundantsUpTo(60))
        XCTAssertEqual(abundants, abundantsUpTo(65))
        XCTAssertEqual(Set<Int>(), abundantsUpTo(10))
    }
    
    
    func testIsDeficient() {
        
        for i: UInt in 1 ... 60 {
            
            let deficients: [UInt] = [1, 2, 3, 4, 5, 7, 8, 9, 10, 11, 13, 14, 15, 16, 17, 19, 21, 22, 23, 25, 26, 27, 29, 31, 32, 33, 34, 35, 37, 38, 39, 41, 43, 44, 45, 46, 47, 49, 50, 51, 52, 53, 55, 57, 58, 59]
            
            if deficients.contains(i) {
                let deficient = isDeficient(i)
                XCTAssertTrue(deficient)
            } else {
                XCTAssertFalse(isDeficient(i))
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
    
    
    func testIsPower() {
        
        XCTAssertTrue(isPower(4, 2, integersAllowed: false))
        XCTAssertTrue(isPower(4, 2, integersAllowed: true))
        XCTAssertTrue(isPower(8, 3, integersAllowed: false))
//        XCTAssertTrue(isPower(-8, 3, integersAllowed: true))
        
        XCTAssertFalse(isPower(4, 3, integersAllowed: false))
        XCTAssertFalse(isPower(4, 3, integersAllowed: true))
        XCTAssertFalse(isPower(-8, 3, integersAllowed: false))
    }
}
