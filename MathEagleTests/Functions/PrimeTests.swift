//
//  PrimeTests.swift
//  MathEagle
//
//  Created by Rugen Heidbuchel on 05/03/15.
//  Copyright (c) 2015 Jorestha Solutions. All rights reserved.
//

import Cocoa
import XCTest
import MathEagle

class PrimeTests: XCTestCase {

    func testIsPrime() {
        XCTAssertFalse(isPrime(0))

        XCTAssertFalse(isPrime(1))
        XCTAssertTrue(isPrime(2))
        XCTAssertTrue(isPrime(3))
        XCTAssertFalse(isPrime(4))
        XCTAssertTrue(isPrime(5))
        XCTAssertFalse(isPrime(6))
        XCTAssertTrue(isPrime(7))
        XCTAssertFalse(isPrime(8))
        XCTAssertTrue(isPrime(104743))
        XCTAssertFalse(isPrime(104744))
        XCTAssertFalse(isPrime(99999))
        XCTAssertFalse(isPrime(123456789))
        
        XCTAssertFalse(isPrime(-1))
        XCTAssertTrue(isPrime(-2))
        XCTAssertTrue(isPrime(-3))
        XCTAssertFalse(isPrime(-4))
        XCTAssertTrue(isPrime(-5))
        XCTAssertFalse(isPrime(-6))
        XCTAssertTrue(isPrime(-7))
        XCTAssertFalse(isPrime(-8))
        XCTAssertTrue(isPrime(-104743))
        XCTAssertFalse(isPrime(-104744))
        XCTAssertFalse(isPrime(-99999))
        XCTAssertFalse(isPrime(-123456789))
    }
    
    func testIsComposite() {
        XCTAssertFalse(isComposite(0))
        
        XCTAssertFalse(isComposite(1))
        XCTAssertFalse(isComposite(2))
        XCTAssertFalse(isComposite(3))
        XCTAssertTrue(isComposite(4))
        XCTAssertFalse(isComposite(5))
        XCTAssertTrue(isComposite(6))
        XCTAssertFalse(isComposite(7))
        XCTAssertTrue(isComposite(8))
        XCTAssertFalse(isComposite(104743))
        XCTAssertTrue(isComposite(104744))
        XCTAssertTrue(isComposite(99999))
        XCTAssertTrue(isComposite(123456789))
        
        XCTAssertFalse(isComposite(-1))
        XCTAssertFalse(isComposite(-2))
        XCTAssertFalse(isComposite(-3))
        XCTAssertTrue(isComposite(-4))
        XCTAssertFalse(isComposite(-5))
        XCTAssertTrue(isComposite(-6))
        XCTAssertFalse(isComposite(-7))
        XCTAssertTrue(isComposite(-8))
        XCTAssertFalse(isComposite(-104743))
        XCTAssertTrue(isComposite(-104744))
        XCTAssertTrue(isComposite(-99999))
        XCTAssertTrue(isComposite(-123456789))
    }
    
    func testAreCoprime() {
        XCTAssertTrue(areCoprime(5, 7))
        XCTAssertTrue(areCoprime(14, 15))
        XCTAssertTrue(areCoprime(1, 6))
        XCTAssertFalse(areCoprime(14, 6))
    }
    
    func testPrimesUpTo() {
        XCTAssertEqual([2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47], primesUpTo(50))
        XCTAssertEqual([], primesUpTo(-10))
        XCTAssertEqual([2.0, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47], primesUpTo(50.0))
    }
    
    func testPrimeFactors() {
        XCTAssertEqual([2, 2, 2, 5], primeFactors(40))
        XCTAssertEqual([43], primeFactors(43))
        XCTAssertEqual([5, 7, 11], primeFactors(385))
        XCTAssertEqual([], primeFactors(-40))
        XCTAssertEqual([2], primeFactors(2))
        XCTAssertEqual([], primeFactors(1))
    }

}
