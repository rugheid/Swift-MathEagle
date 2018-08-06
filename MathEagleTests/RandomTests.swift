//
//  RandomTests.swift
//  MathEagle
//
//  Created by Rugen Heidbuchel on 01/04/15.
//  Copyright (c) 2015 Jorestha Solutions. All rights reserved.
//

import Cocoa
import XCTest
import MathEagle

class RandomTests: XCTestCase {

    var N = 10000
    var MAX = 100
    
    func testRangeConstructors() {
        print(String(describing:type(of:10.0..<20.0)))
        print(String(describing:type(of:10.0...20.0)))
        print(String(describing:type(of:10..<20)))
        print(String(describing:type(of:10...20)))
        XCTAssert((10.0..<20.0 as Any) is Range<Double>)
        XCTAssert((10.0...20.0 as Any) is ClosedRange<Double>)
        XCTAssert((10..<20 as Any) is CountableRange<Int>)
        XCTAssert((10...20 as Any) is CountableClosedRange<Int>)
    }
    
    // MARK: random within upperBound
    
    func testRandomInt() {
        for _ in 1...N {
            let x=Int.random()
            XCTAssert((x as Any) is Int)
            XCTAssert(0<=x && x<=1)
        }
        let m=Int.random(Int(MAX))
        XCTAssert((m as Any) is Int)
        XCTAssert(0<=m && m<=MAX)
        for _ in 1...N {
            let x=Int.random(m)
            XCTAssert((x as Any) is Int)
            XCTAssert(0<=x && x<=m)
        }
        for _ in 1...N {
            let x=Int.random(-m)
            XCTAssert((x as Any) is Int)
            XCTAssert(-m<=x && x<=0)
        }
    }
    
    func testRandomInt8() {
        for _ in 1...N {
            let x=Int8.random()
            XCTAssert((x as Any) is Int8)
            XCTAssert(0<=x && x<=1)
        }
        let m=Int8.random(Int8(MAX))
        XCTAssert((m as Any) is Int8)
        XCTAssert(0<=m && m<=MAX)
        for _ in 1...N {
            let x=Int8.random(m)
            XCTAssert((x as Any) is Int8)
            XCTAssert(0<=x && x<=m)
        }
        for _ in 1...N {
            let x=Int8.random(-m)
            XCTAssert((x as Any) is Int8)
            XCTAssert(-m<=x && x<=0)
        }
    }
    
    func testRandomInt16() {
        for _ in 1...N {
            let x=Int16.random()
            XCTAssert((x as Any) is Int16)
            XCTAssert(0<=x && x<=1)
        }
        let m=Int16.random(Int16(MAX))
        XCTAssert((m as Any) is Int16)
        XCTAssert(0<=m && m<=MAX)
        for _ in 1...N {
            let x=Int16.random(m)
            XCTAssert((x as Any) is Int16)
            XCTAssert(0<=x && x<=m)
        }
        for _ in 1...N {
            let x=Int16.random(-m)
            XCTAssert((x as Any) is Int16)
            XCTAssert(-m<=x && x<=0)
        }
    }
    
    func testRandomInt32() {
        for _ in 1...N {
            let x=Int32.random()
            XCTAssert((x as Any) is Int32)
            XCTAssert(0<=x && x<=1)
        }
        let m=Int32.random(Int32(MAX))
        XCTAssert((m as Any) is Int32)
        XCTAssert(0<=m && m<=MAX)
        for _ in 1...N {
            let x=Int32.random(m)
            XCTAssert((x as Any) is Int32)
            XCTAssert(0<=x && x<=m)
        }
        for _ in 1...N {
            let x=Int32.random(-m)
            XCTAssert((x as Any) is Int32)
            XCTAssert(-m<=x && x<=0)
        }
    }
    
    func testRandomInt64() {
        for _ in 1...N {
            let x=Int64.random()
            XCTAssert((x as Any) is Int64)
            XCTAssert(0<=x && x<=1)
        }
        let m=Int64.random(Int64(MAX))
        XCTAssert((m as Any) is Int64)
        XCTAssert(0<=m && m<=MAX)
        for _ in 1...N {
            let x=Int64.random(m)
            XCTAssert((x as Any) is Int64)
            XCTAssert(0<=x && x<=m)
        }
        for _ in 1...N {
            let x=Int64.random(-m)
            XCTAssert((x as Any) is Int64)
            XCTAssert(-m<=x && x<=0)
        }
    }
    
    func testRandomUInt() {
        for _ in 1...N {
            let x=UInt.random()
            XCTAssert((x as Any) is UInt)
            XCTAssert(0<=x && x<=1)
        }
        let m=UInt.random(UInt(MAX))
        XCTAssert((m as Any) is UInt)
        XCTAssert(0<=m && m<=MAX)
        for _ in 1...N {
            let x=UInt.random(m)
            XCTAssert((x as Any) is UInt)
            XCTAssert(0<=x && x<=m)
        }
    }
    
    func testRandomUInt8() {
        for _ in 1...N {
            let x=UInt8.random()
            XCTAssert((x as Any) is UInt8)
            XCTAssert(0<=x && x<=1)
        }
        let m=UInt8.random(UInt8(MAX))
        XCTAssert((m as Any) is UInt8)
        XCTAssert(0<=m && m<=MAX)
        for _ in 1...N {
            let x=UInt8.random(m)
            XCTAssert((x as Any) is UInt8)
            XCTAssert(0<=x && x<=m)
        }
    }
    
    func testRandomUInt16() {
        for _ in 1...N {
            let x=UInt16.random()
            XCTAssert((x as Any) is UInt16)
            XCTAssert(0<=x && x<=1)
        }
        let m=UInt16.random(UInt16(MAX))
        XCTAssert((m as Any) is UInt16)
        XCTAssert(0<=m && m<=MAX)
        for _ in 1...N {
            let x=UInt16.random(m)
            XCTAssert((x as Any) is UInt16)
            XCTAssert(0<=x && x<=m)
        }
    }
    
    func testRandomUInt32() {
        for _ in 1...N {
            let x=UInt32.random()
            XCTAssert((x as Any) is UInt32)
            XCTAssert(0<=x && x<=1)
        }
        let m=UInt32.random(UInt32(MAX))
        XCTAssert((m as Any) is UInt32)
        XCTAssert(0<=m && m<=MAX)
        for _ in 1...N {
            let x=UInt32.random(m)
            XCTAssert((x as Any) is UInt32)
            XCTAssert(0<=x && x<=m)
        }
    }
    
    func testRandomUInt64() {
        for _ in 1...N {
            let x=UInt64.random()
            XCTAssert((x as Any) is UInt64)
            XCTAssert(0<=x && x<=1)
        }
        let m=UInt64.random(UInt64(MAX))
        XCTAssert((m as Any) is UInt64)
        XCTAssert(0<=m && m<=MAX)
        for _ in 1...N {
            let x=UInt64.random(m)
            XCTAssert((x as Any) is UInt64)
            XCTAssert(0<=x && x<=m)
        }
    }
    
    func testRandomFloat() {
        for _ in 1...N {
            let x=Float.random()
            XCTAssert((x as Any) is Float)
            XCTAssert(0<=x && x<=1)
        }
        let m=Float.random(Float(MAX))
        XCTAssert((m as Any) is Float)
        XCTAssert(0<=m && m<=Float(MAX))
        for _ in 1...N {
            let x=Float.random(m)
            XCTAssert((x as Any) is Float)
            XCTAssert(0<=x && x<=m)
        }
        for _ in 1...N {
            let x=Float.random(-m)
            XCTAssert((x as Any) is Float)
            XCTAssert(-m<=x && x<=0)
        }
    }
    
    func testRandomDouble() {
        for _ in 1...N {
            let x=Double.random()
            XCTAssert((x as Any) is Double)
            XCTAssert(0<=x && x<=1)
        }
        let m=Double.random(Double(MAX))
        XCTAssert((m as Any) is Double)
        XCTAssert(0<=m && m<=Double(MAX))
        for _ in 1...N {
            let x=Double.random(m)
            XCTAssert((x as Any) is Double)
            XCTAssert(0<=x && x<=m)
        }
        for _ in 1...N {
            let x=Double.random(-m)
            XCTAssert((x as Any) is Double)
            XCTAssert(-m<=x && x<=0)
        }
    }
    
    func testRandomCGFloat() {
        for _ in 1...N {
            let x=CGFloat.random()
            XCTAssert((x as Any) is CGFloat)
            XCTAssert(0<=x && x<=1)
        }
        let m=CGFloat.random(CGFloat(MAX))
        XCTAssert((m as Any) is CGFloat)
        XCTAssert(0<=m && m<=CGFloat(MAX))
        for _ in 1...N {
            let x=CGFloat.random(m)
            XCTAssert((x as Any) is CGFloat)
            XCTAssert(0<=x && x<=m)
        }
        for _ in 1...N {
            let x=CGFloat.random(-m)
            XCTAssert((x as Any) is CGFloat)
            XCTAssert(-m<=x && x<=0)
        }
    }
    
    // MARK: random in a Range

    func testRandomInInt() {
        let m=Int.random(Int(-MAX)..<Int(MAX))
        XCTAssert((m as Any) is Int)
        XCTAssert(-MAX<=m && m<MAX)
        let n=Int.random((m+1)...Int(MAX))
        XCTAssert((n as Any) is Int)
        XCTAssert(m<n && n<=MAX)
        for _ in 1...N {
            let x=Int.random(m..<n)
            XCTAssert((x as Any) is Int)
            XCTAssert(m<=x && x<n)
        }
        for _ in 1...N {
            let x=Int.random(m...n)
            XCTAssert((x as Any) is Int)
            XCTAssert(m<=x && x<=n)
        }
    }
    
    func testRandomInInt8() {
        let m=Int8.random(Int8(-MAX)..<Int8(MAX))
        XCTAssert((m as Any) is Int8)
        XCTAssert(-MAX<=m && m<MAX)
        let n=Int8.random((m+1)...Int8(MAX))
        XCTAssert((n as Any) is Int8)
        XCTAssert(m<n && n<=MAX)
        for _ in 1...N {
            let x=Int8.random(m..<n)
            XCTAssert((x as Any) is Int8)
            XCTAssert(m<=x && x<n)
        }
        for _ in 1...N {
            let x=Int8.random(m...n)
            XCTAssert((x as Any) is Int8)
            XCTAssert(m<=x && x<=n)
        }
    }
    
    func testRandomInInt16() {
        let m=Int16.random(Int16(-MAX)..<Int16(MAX))
        XCTAssert((m as Any) is Int16)
        XCTAssert(-MAX<=m && m<MAX)
        let n=Int16.random((m+1)...Int16(MAX))
        XCTAssert((n as Any) is Int16)
        XCTAssert(m<n && n<=MAX)
        for _ in 1...N {
            let x=Int16.random(m..<n)
            XCTAssert((x as Any) is Int16)
            XCTAssert(m<=x && x<n)
        }
        for _ in 1...N {
            let x=Int16.random(m...n)
            XCTAssert((x as Any) is Int16)
            XCTAssert(m<=x && x<=n)
        }
    }
    
    func testRandomInInt32() {
        let m=Int32.random(Int32(-MAX)..<Int32(MAX))
        XCTAssert((m as Any) is Int32)
        XCTAssert(-MAX<=m && m<MAX)
        let n=Int32.random((m+1)...Int32(MAX))
        XCTAssert((n as Any) is Int32)
        XCTAssert(m<n && n<=MAX)
        for _ in 1...N {
            let x=Int32.random(m..<n)
            XCTAssert((x as Any) is Int32)
            XCTAssert(m<=x && x<n)
        }
        for _ in 1...N {
            let x=Int32.random(m...n)
            XCTAssert((x as Any) is Int32)
            XCTAssert(m<=x && x<=n)
        }
    }
    
    func testRandomInInt64() {
        let m=Int64.random(Int64(-MAX)..<Int64(MAX))
        XCTAssert((m as Any) is Int64)
        XCTAssert(-MAX<=m && m<MAX)
        let n=Int64.random((m+1)...Int64(MAX))
        XCTAssert((n as Any) is Int64)
        XCTAssert(m<n && n<=MAX)
        for _ in 1...N {
            let x=Int64.random(m..<n)
            XCTAssert((x as Any) is Int64)
            XCTAssert(m<=x && x<n)
        }
        for _ in 1...N {
            let x=Int64.random(m...n)
            XCTAssert((x as Any) is Int64)
            XCTAssert(m<=x && x<=n)
        }
    }
    
    func testRandomInUInt() {
        let m=UInt.random(0..<UInt(MAX))
        XCTAssert((m as Any) is UInt)
        XCTAssert(0<=m && m<MAX)
        let n=UInt.random((m+1)...UInt(MAX))
        XCTAssert((n as Any) is UInt)
        XCTAssert(m<n && n<=MAX)
        for _ in 1...N {
            let x=UInt.random(m..<n)
            XCTAssert((x as Any) is UInt)
            XCTAssert(m<=x && x<n)
        }
        for _ in 1...N {
            let x=UInt.random(m...n)
            XCTAssert((x as Any) is UInt)
            XCTAssert(m<=x && x<=n)
        }
    }
    
    func testRandomInUInt8() {
        let m=UInt8.random(0..<UInt8(MAX))
        XCTAssert((m as Any) is UInt8)
        XCTAssert(0<=m && m<MAX)
        let n=UInt8.random((m+1)...UInt8(MAX))
        XCTAssert((n as Any) is UInt8)
        XCTAssert(m<n && n<=MAX)
        for _ in 1...N {
            let x=UInt8.random(m..<n)
            XCTAssert((x as Any) is UInt8)
            XCTAssert(m<=x && x<n)
        }
        for _ in 1...N {
            let x=UInt8.random(m...n)
            XCTAssert((x as Any) is UInt8)
            XCTAssert(m<=x && x<=n)
        }
    }
    
    func testRandomInUInt16() {
        let m=UInt16.random(0..<UInt16(MAX))
        XCTAssert((m as Any) is UInt16)
        XCTAssert(0<=m && m<MAX)
        let n=UInt16.random((m+1)...UInt16(MAX))
        XCTAssert((n as Any) is UInt16)
        XCTAssert(m<n && n<=MAX)
        for _ in 1...N {
            let x=UInt16.random(m..<n)
            XCTAssert((x as Any) is UInt16)
            XCTAssert(m<=x && x<n)
        }
        for _ in 1...N {
            let x=UInt16.random(m...n)
            XCTAssert((x as Any) is UInt16)
            XCTAssert(m<=x && x<=n)
        }
    }
    
    func testRandomInUInt32() {
        let m=UInt32.random(0..<UInt32(MAX))
        XCTAssert((m as Any) is UInt32)
        XCTAssert(0<=m && m<MAX)
        let n=UInt32.random((m+1)...UInt32(MAX))
        XCTAssert((n as Any) is UInt32)
        XCTAssert(m<n && n<=MAX)
        for _ in 1...N {
            let x=UInt32.random(m..<n)
            XCTAssert((x as Any) is UInt32)
            XCTAssert(m<=x && x<n)
        }
        for _ in 1...N {
            let x=UInt32.random(m...n)
            XCTAssert((x as Any) is UInt32)
            XCTAssert(m<=x && x<=n)
        }
    }
    
    func testRandomInUInt64() {
        let m=UInt64.random(0..<UInt64(MAX))
        XCTAssert((m as Any) is UInt64)
        XCTAssert(0<=m && m<MAX)
        let n=UInt64.random((m+1)...UInt64(MAX))
        XCTAssert((n as Any) is UInt64)
        XCTAssert(m<n && n<=MAX)
        for _ in 1...N {
            let x=UInt64.random(m..<n)
            XCTAssert((x as Any) is UInt64)
            XCTAssert(m<=x && x<n)
        }
        for _ in 1...N {
            let x=UInt64.random(m...n)
            XCTAssert((x as Any) is UInt64)
            if (!(m<=x && x<=n)) {
                print([m,n,x])
                print("Oh Oh")
            }
            XCTAssert(m<=x && x<=n)
        }
    }
    
    func testRandomInFloat() {
        let m=Float.random(Float(-MAX)..<Float(MAX))
        XCTAssert((m as Any) is Float)
        XCTAssert(-Float(MAX)<=m && m<Float(MAX))
        let n=Float.random(m...Float(MAX))
        XCTAssert((n as Any) is Float)
        // Ignoring astronomically small chance m==n
        XCTAssert(m<n && n<=Float(MAX))
        for _ in 1...N {
            let x=Float.random(m..<n)
            XCTAssert((x as Any) is Float)
            XCTAssert(m<=x && x<n)
        }
        for _ in 1...N {
            let x=Float.random(m...n)
            XCTAssert((x as Any) is Float)
            XCTAssert(m<=x && x<=n)
        }
    }
    
    func testRandomInDouble() {
        let m=Double.random(Double(-MAX)..<Double(MAX))
        XCTAssert((m as Any) is Double)
        XCTAssert(-Double(MAX)<=m && m<Double(MAX))
        let n=Double.random(m...Double(MAX))
        XCTAssert((n as Any) is Double)
        // Ignoring astronomically small chance m==n
        XCTAssert(m<n && n<=Double(MAX))
        for _ in 1...N {
            let x=Double.random(m..<n)
            XCTAssert((x as Any) is Double)
            XCTAssert(m<=x && x<n)
        }
        for _ in 1...N {
            let x=Double.random(m...n)
            XCTAssert((x as Any) is Double)
            XCTAssert(m<=x && x<=n)
        }
    }

    func testRandomInCGFloat() {
        let m=CGFloat.random(CGFloat(-MAX)..<CGFloat(MAX))
        XCTAssert((m as Any) is CGFloat)
        XCTAssert(-CGFloat(MAX)<=m && m<CGFloat(MAX))
        let n=CGFloat.random(m...CGFloat(MAX))
        XCTAssert((n as Any) is CGFloat)
        // Ignoring astronomically small chance m==n
        XCTAssert(m<n && n<=CGFloat(MAX))
        for _ in 1...N {
            let x=CGFloat.random(m..<n)
            XCTAssert((x as Any) is CGFloat)
            XCTAssert(m<=x && x<n)
        }
        for _ in 1...N {
            let x=CGFloat.random(m...n)
            XCTAssert((x as Any) is CGFloat)
            XCTAssert(m<=x && x<=n)
        }
    }
    
    // MARK: randomArray to one

    func testRandomArrayInt() {
        do {
            let range = Int(0)...Int(1)
            let X = Int.randomArray(N)
            for x in X {
                XCTAssert(range.contains(x))
            }
            if (N>=100) {
                let mu = 0.5
                let s = 1.0/sqrt(12.0)
                XCTAssert(s>0)
                let D = X.asDoubleArray()
                XCTAssert(D.min()!<mu)
                XCTAssert(D.max()!>mu)
                let z = (D.mean()-mu)/(s/sqrt(Double(N)))
                XCTAssert(abs(z)<6.0)
            }
        }
    }
    
    func testRandomArrayInt8() {
        do {
            let range = Int8(0)...Int8(1)
            let X = Int8.randomArray(N)
            for x in X {
                XCTAssert(range.contains(x))
            }
            if (N>=100) {
                let mu = 0.5
                let s = 1.0/sqrt(12.0)
                XCTAssert(s>0)
                let D = X.asDoubleArray()
                XCTAssert(D.min()!<mu)
                XCTAssert(D.max()!>mu)
                let z = (D.mean()-mu)/(s/sqrt(Double(N)))
                XCTAssert(abs(z)<6.0)
            }
        }
    }
    
    func testRandomArrayInt16() {
        do {
            let range = Int16(0)...Int16(1)
            let X = Int16.randomArray(N)
            for x in X {
                XCTAssert(range.contains(x))
            }
            if (N>=100) {
                let mu = 0.5
                let s = 1.0/sqrt(12.0)
                XCTAssert(s>0)
                let D = X.asDoubleArray()
                XCTAssert(D.min()!<mu)
                XCTAssert(D.max()!>mu)
                let z = (D.mean()-mu)/(s/sqrt(Double(N)))
                XCTAssert(abs(z)<6.0)
            }
        }
    }
    
    func testRandomArrayInt32() {
        do {
            let range = Int32(0)...Int32(1)
            let X = Int32.randomArray(N)
            for x in X {
                XCTAssert(range.contains(x))
            }
            if (N>=100) {
                let mu = 0.5
                let s = 1.0/sqrt(12.0)
                XCTAssert(s>0)
                let D = X.asDoubleArray()
                XCTAssert(D.min()!<mu)
                XCTAssert(D.max()!>mu)
                let z = (D.mean()-mu)/(s/sqrt(Double(N)))
                XCTAssert(abs(z)<6.0)
            }
        }
    }
    
    func testRandomArrayInt64() {
        do {
            let range = Int64(0)...Int64(1)
            let X = Int64.randomArray(N)
            for x in X {
                XCTAssert(range.contains(x))
            }
            if (N>=100) {
                let mu = 0.5
                let s = 1.0/sqrt(12.0)
                XCTAssert(s>0)
                let D = X.asDoubleArray()
                XCTAssert(D.min()!<mu)
                XCTAssert(D.max()!>mu)
                let z = (D.mean()-mu)/(s/sqrt(Double(N)))
                XCTAssert(abs(z)<6.0)
            }
        }
    }
    
    func testRandomArrayUInt() {
        do {
            let range = UInt(0)...UInt(1)
            let X = UInt.randomArray(N)
            for x in X {
                XCTAssert(range.contains(x))
            }
            if (N>=100) {
                let mu = 0.5
                let s = 1.0/sqrt(12.0)
                XCTAssert(s>0)
                let D = X.asDoubleArray()
                XCTAssert(D.min()!<mu)
                XCTAssert(D.max()!>mu)
                let z = (D.mean()-mu)/(s/sqrt(Double(N)))
                XCTAssert(abs(z)<6.0)
            }
        }
    }
    
    func testRandomArrayUInt8() {
        do {
            let range = UInt8(0)...UInt8(1)
            let X = UInt8.randomArray(N)
            for x in X {
                XCTAssert(range.contains(x))
            }
            if (N>=100) {
                let mu = 0.5
                let s = 1.0/sqrt(12.0)
                XCTAssert(s>0)
                let D = X.asDoubleArray()
                XCTAssert(D.min()!<mu)
                XCTAssert(D.max()!>mu)
                let z = (D.mean()-mu)/(s/sqrt(Double(N)))
                XCTAssert(abs(z)<6.0)
            }
        }
    }
    
    func testRandomArrayUInt16() {
        do {
            let range = UInt16(0)...UInt16(1)
            let X = UInt16.randomArray(N)
            for x in X {
                XCTAssert(range.contains(x))
            }
            if (N>=100) {
                let mu = 0.5
                let s = 1.0/sqrt(12.0)
                XCTAssert(s>0)
                let D = X.asDoubleArray()
                XCTAssert(D.min()!<mu)
                XCTAssert(D.max()!>mu)
                let z = (D.mean()-mu)/(s/sqrt(Double(N)))
                XCTAssert(abs(z)<6.0)
            }
        }
    }
    
    func testRandomArrayUInt32() {
        do {
            let range = UInt32(0)...UInt32(1)
            let X = UInt32.randomArray(N)
            for x in X {
                XCTAssert(range.contains(x))
            }
            if (N>=100) {
                let mu = 0.5
                let s = 1.0/sqrt(12.0)
                XCTAssert(s>0)
                let D = X.asDoubleArray()
                XCTAssert(D.min()!<mu)
                XCTAssert(D.max()!>mu)
                let z = (D.mean()-mu)/(s/sqrt(Double(N)))
                XCTAssert(abs(z)<6.0)
            }
        }
    }
    
    func testRandomArrayUInt64() {
        do {
            let range = UInt64(0)...UInt64(1)
            let X = UInt64.randomArray(N)
            for x in X {
                XCTAssert(range.contains(x))
            }
            if (N>=100) {
                let mu = 0.5
                let s = 1.0/sqrt(12.0)
                XCTAssert(s>0)
                let D = X.asDoubleArray()
                XCTAssert(D.min()!<mu)
                XCTAssert(D.max()!>mu)
                let z = (D.mean()-mu)/(s/sqrt(Double(N)))
                XCTAssert(abs(z)<6.0)
            }
        }
    }
    
    func testRandomArrayFloat() {
        do {
            let range = Float(0)...Float(1)
            let X = Float.randomArray(N)
            for x in X {
                XCTAssert(range.contains(x))
            }
            if (N>=100) {
                let mu = Float(0.5)
                let s = Float(1.0/sqrt(12.0))
                XCTAssert(s>0)
                XCTAssert(X.min()!<mu)
                XCTAssert(X.max()!>mu)
                let z = (X.mean()-mu)/(s/sqrt(Float(N)))
                XCTAssert(abs(z)<6.0)
            }
        }
    }
    
    func testRandomArrayDouble() {
        do {
            let range = Double(0)...Double(1)
            let X = Double.randomArray(N)
            for x in X {
                XCTAssert(range.contains(x))
            }
            if (N>=100) {
                let mu = Double(0.5)
                let s = Double(1.0/sqrt(12.0))
                XCTAssert(s>0)
                XCTAssert(X.min()!<mu)
                XCTAssert(X.max()!>mu)
                let z = (X.mean()-mu)/(s/sqrt(Double(N)))
                XCTAssert(abs(z)<6.0)
            }
        }
    }
    
    func testRandomArrayCGFloat() {
        do {
            let range = CGFloat(0)...CGFloat(1)
            let X = CGFloat.randomArray(N)
            for x in X {
                XCTAssert(range.contains(x))
            }
            if (N>=100) {
                let mu = CGFloat(0.5)
                let s = CGFloat(1.0/sqrt(12.0))
                XCTAssert(s>0)
                XCTAssert(X.min()!<mu)
                XCTAssert(X.max()!>mu)
                let z = (X.mean()-mu)/(s/sqrt(CGFloat(N)))
                XCTAssert(abs(z)<6.0)
            }
        }
    }
    
    func testRandomArrayComplex() {
        do {
            let X = Complex.randomArray(N)
            if (N>=100) {
                let mu_X : Complex = X.mean()
                do {
                    let mu_real = 0.5
                    let s_real = 1.0/sqrt(12.0)
                    let z_real = (mu_X.real-mu_real)/(s_real/sqrt(Double(N)))
                    XCTAssert(abs(z_real)<6.0)
                }
                do {
                    let mu_imaginary = 0.5
                    let s_imaginary = 1.0/sqrt(12.0)
                    let z_imaginary = (mu_X.imaginary-mu_imaginary)/(s_imaginary/sqrt(Double(N)))
                    XCTAssert(abs(z_imaginary)<6.0)
                }
            }
        }
    }
    
    // MARK: randomArray to upperBound
    
    func testRandomArrayIntUpperBound() {
        let n=Int.random(1...Int(MAX))
        XCTAssert((n as Any) is Int)
        XCTAssert(n<=MAX)
        do {
            let range = 0...n
            let X = Int.randomArray(N,upperBound:n)
            for x in X {
                XCTAssert(range.contains(x))
            }
            if (N>=100) {
                let mu = Double(n)/2.0
                let s = Double(n)/sqrt(12.0)
                XCTAssert(s>0)
                let D = X.asDoubleArray()
                XCTAssert(D.min()!<mu)
                XCTAssert(D.max()!>mu)
                let z = (D.mean()-mu)/(s/sqrt(Double(N)))
                XCTAssert(abs(z)<6.0)
            }
        }
    }
    
    func testRandomArrayInt8UpperBound() {
        let n=Int8.random(1...Int8(MAX))
        XCTAssert((n as Any) is Int8)
        XCTAssert(n<=MAX)
        do {
            let range = 0...n
            let X = Int8.randomArray(N,upperBound:n)
            for x in X {
                XCTAssert(range.contains(x))
            }
            if (N>=100) {
                let mu = Double(n)/2.0
                let s = Double(n)/sqrt(12.0)
                XCTAssert(s>0)
                let D = X.asDoubleArray()
                XCTAssert(D.min()!<mu)
                XCTAssert(D.max()!>mu)
                let z = (D.mean()-mu)/(s/sqrt(Double(N)))
                XCTAssert(abs(z)<6.0)
            }
        }
    }
    
    func testRandomArrayInt16UpperBound() {
        let n=Int16.random(1...Int16(MAX))
        XCTAssert((n as Any) is Int16)
        XCTAssert(n<=MAX)
        do {
            let range = 0...n
            let X = Int16.randomArray(N,upperBound:n)
            for x in X {
                XCTAssert(range.contains(x))
            }
            if (N>=100) {
                let mu = Double(n)/2.0
                let s = Double(n)/sqrt(12.0)
                XCTAssert(s>0)
                let D = X.asDoubleArray()
                XCTAssert(D.min()!<mu)
                XCTAssert(D.max()!>mu)
                let z = (D.mean()-mu)/(s/sqrt(Double(N)))
                XCTAssert(abs(z)<6.0)
            }
        }
    }
    
    func testRandomArrayInt32UpperBound() {
        let n=Int32.random(1...Int32(MAX))
        XCTAssert((n as Any) is Int32)
        XCTAssert(n<=MAX)
        do {
            let range = 0...n
            let X = Int32.randomArray(N,upperBound:n)
            for x in X {
                XCTAssert(range.contains(x))
            }
            if (N>=100) {
                let mu = Double(n)/2.0
                let s = Double(n)/sqrt(12.0)
                XCTAssert(s>0)
                let D = X.asDoubleArray()
                XCTAssert(D.min()!<mu)
                XCTAssert(D.max()!>mu)
                let z = (D.mean()-mu)/(s/sqrt(Double(N)))
                XCTAssert(abs(z)<6.0)
            }
        }
    }
    
    func testRandomArrayInt64UpperBound() {
        let n=Int64.random(1...Int64(MAX))
        XCTAssert((n as Any) is Int64)
        XCTAssert(n<=MAX)
        do {
            let range = 0...n
            let X = Int64.randomArray(N,upperBound:n)
            for x in X {
                XCTAssert(range.contains(x))
            }
            if (N>=100) {
                let mu = Double(n)/2.0
                let s = Double(n)/sqrt(12.0)
                XCTAssert(s>0)
                let D = X.asDoubleArray()
                XCTAssert(D.min()!<mu)
                XCTAssert(D.max()!>mu)
                let z = (D.mean()-mu)/(s/sqrt(Double(N)))
                XCTAssert(abs(z)<6.0)
            }
        }
    }
    
    func testRandomArrayUIntUpperBound() {
        let n=UInt.random(1...UInt(MAX))
        XCTAssert((n as Any) is UInt)
        XCTAssert(n<=MAX)
        do {
            let range = 0...n
            let X = UInt.randomArray(N,upperBound:n)
            for x in X {
                XCTAssert(range.contains(x))
            }
            if (N>=100) {
                let mu = Double(n)/2.0
                let s = Double(n)/sqrt(12.0)
                XCTAssert(s>0)
                let D = X.asDoubleArray()
                XCTAssert(D.min()!<mu)
                XCTAssert(D.max()!>mu)
                let z = (D.mean()-mu)/(s/sqrt(Double(N)))
                XCTAssert(abs(z)<6.0)
            }
        }
    }
    
    func testRandomArrayUInt8UpperBound() {
        let n=UInt8.random(1...UInt8(MAX))
        XCTAssert((n as Any) is UInt8)
        XCTAssert(n<=MAX)
        do {
            let range = 0...n
            let X = UInt8.randomArray(N,upperBound:n)
            for x in X {
                XCTAssert(range.contains(x))
            }
            if (N>=100) {
                let mu = Double(n)/2.0
                let s = Double(n)/sqrt(12.0)
                XCTAssert(s>0)
                let D = X.asDoubleArray()
                XCTAssert(D.min()!<mu)
                XCTAssert(D.max()!>mu)
                let z = (D.mean()-mu)/(s/sqrt(Double(N)))
                XCTAssert(abs(z)<6.0)
            }
        }
    }
    
    func testRandomArrayUInt16UpperBound() {
        let n=UInt16.random(1...UInt16(MAX))
        XCTAssert((n as Any) is UInt16)
        XCTAssert(n<=MAX)
        do {
            let range = 0...n
            let X = UInt16.randomArray(N,upperBound:n)
            for x in X {
                XCTAssert(range.contains(x))
            }
            if (N>=100) {
                let mu = Double(n)/2.0
                let s = Double(n)/sqrt(12.0)
                XCTAssert(s>0)
                let D = X.asDoubleArray()
                XCTAssert(D.min()!<mu)
                XCTAssert(D.max()!>mu)
                let z = (D.mean()-mu)/(s/sqrt(Double(N)))
                XCTAssert(abs(z)<6.0)
            }
        }
    }
    
    func testRandomArrayUInt32UpperBound() {
        let n=UInt32.random(1...UInt32(MAX))
        XCTAssert((n as Any) is UInt32)
        XCTAssert(n<=MAX)
        do {
            let range = 0...n
            let X = UInt32.randomArray(N,upperBound:n)
            for x in X {
                XCTAssert(range.contains(x))
            }
            if (N>=100) {
                let mu = Double(n)/2.0
                let s = Double(n)/sqrt(12.0)
                XCTAssert(s>0)
                let D = X.asDoubleArray()
                XCTAssert(D.min()!<mu)
                XCTAssert(D.max()!>mu)
                let z = (D.mean()-mu)/(s/sqrt(Double(N)))
                XCTAssert(abs(z)<6.0)
            }
        }
    }
    
    func testRandomArrayUInt64UpperBound() {
        let n=UInt64.random(1...UInt64(MAX))
        XCTAssert((n as Any) is UInt64)
        XCTAssert(n<=MAX)
        do {
            let range = 0...n
            let X = UInt64.randomArray(N,upperBound:n)
            for x in X {
                XCTAssert(range.contains(x))
            }
            if (N>=100) {
                let mu = Double(n)/2.0
                let s = Double(n)/sqrt(12.0)
                XCTAssert(s>0)
                let D = X.asDoubleArray()
                XCTAssert(D.min()!<mu)
                XCTAssert(D.max()!>mu)
                let z = (D.mean()-mu)/(s/sqrt(Double(N)))
                XCTAssert(abs(z)<6.0)
            }
        }
    }
    
    func testRandomArrayFloatUpperBound() {
        let n=Float.random(Float(0.0)...Float(MAX))
        XCTAssert((n as Any) is Float)
        // Ignoring astronomically small chance 0.0==n
        XCTAssert(n<=Float(MAX))
        do {
            let range = 0...n
            let X = Float.randomArray(N,range:range)
            for x in X {
                XCTAssert(range.contains(x))
            }
            if (N>=100) {
                let mu = n/2
                XCTAssert(X.min()!<mu)
                XCTAssert(X.max()!>mu)
                let s = n/sqrt(12.0)
                let z = (X.mean()-mu)/(s/sqrt(Float(N)))
                XCTAssert(abs(z)<6.0)
            }
        }
    }
    
    func testRandomArrayDoubleUpperBound() {
        let n=Double.random(Double(0.0)...Double(MAX))
        XCTAssert((n as Any) is Double)
        // Ignoring astronomically small chance 0.0==n
        XCTAssert(n<=Double(MAX))
        do {
            let range = 0...n
            let X = Double.randomArray(N,range:range)
            for x in X {
                XCTAssert(range.contains(x))
            }
            if (N>=100) {
                let mu = n/2
                XCTAssert(X.min()!<mu)
                XCTAssert(X.max()!>mu)
                let s = n/sqrt(12.0)
                let z = (X.mean()-mu)/(s/sqrt(Double(N)))
                XCTAssert(abs(z)<6.0)
            }
        }
    }
    
    func testRandomArrayCGFloatUpperBound() {
        let n=CGFloat.random(CGFloat(0.0)...CGFloat(MAX))
        XCTAssert((n as Any) is CGFloat)
        // Ignoring astronomically small chance 0.0==n
        XCTAssert(n<=CGFloat(MAX))
        do {
            let range = 0...n
            let X = CGFloat.randomArray(N,range:range)
            for x in X {
                XCTAssert(range.contains(x))
            }
            if (N>=100) {
                let mu = n/2
                XCTAssert(X.min()!<mu)
                XCTAssert(X.max()!>mu)
                let s = n/sqrt(12.0)
                let z = (X.mean()-mu)/(s/sqrt(CGFloat(N)))
                XCTAssert(abs(z)<6.0)
            }
        }
    }
    
    func testRandomArrayComplexUpperBound() {
        let n_real=Double.random(0.0...Double(MAX))
        XCTAssert((n_real as Any) is Double)
        // Ignoring astronomically small chance 0.0==n_real
        XCTAssert(0.0<n_real && n_real<=Double(MAX))
        let n_imaginary=Double.random(0.0...Double(MAX))
        XCTAssert((n_imaginary as Any) is Double)
        // Ignoring astronomically small chance 0.0==n_imaginary
        XCTAssert(0.0<n_imaginary && n_imaginary<=Double(MAX))
        // Complex n
        let n=Complex(n_real,n_imaginary)
        do {
            let X = Complex.randomArray(N,upperBound:n)
            if (N>=100) {
                let mu_X : Complex = X.mean()
                do {
                    let mu_real = n_real/2
                    let s_real = n_real/sqrt(12.0)
                    let z_real = (mu_X.real-mu_real)/(s_real/sqrt(Double(N)))
                    XCTAssert(abs(z_real)<6.0)
                }
                do {
                    let mu_imaginary = n_imaginary/2
                    let s_imaginary = n_imaginary/sqrt(12.0)
                    let z_imaginary = (mu_X.imaginary-mu_imaginary)/(s_imaginary/sqrt(Double(N)))
                    XCTAssert(abs(z_imaginary)<6.0)
                }
            }
        }
    }

    // MARK: randomArray in a range

    func testRandomArrayIntRange() {
        let m=Int.random(Int(-MAX)..<Int(MAX))
        XCTAssert((m as Any) is Int)
        XCTAssert(-MAX<=m && m<MAX)
        let n=Int.random((m+1)...Int(MAX))
        XCTAssert((n as Any) is Int)
        XCTAssert(m<n && n<=MAX)
        do {
            let range = m..<n
            let X = Int.randomArray(N,range:range)
            for x in X {
                XCTAssert(range.contains(x))
            }
            if (N>=100) {
                let b = n-1
                let mu = (Double(m)+Double(b))/2.0
                let s = (Double(b)-Double(m))/sqrt(12.0)
                if (s>0) {
                    let D = X.asDoubleArray()
                    XCTAssert(D.min()!<mu)
                    XCTAssert(D.max()!>mu)
                    let z = (D.mean()-mu)/(s/sqrt(Double(N)))
                    XCTAssert(abs(z)<6.0)
                }
            }
        }
        do {
            let range = m...n
            let X = Int.randomArray(N,range:range)
            for x in X {
                XCTAssert(range.contains(x))
            }
            if (N>=100) {
                let mu = (Double(m)+Double(n))/2.0
                let s = (Double(n)-Double(m))/sqrt(12.0)
                XCTAssert(s>0)
                let D = X.asDoubleArray()
                XCTAssert(D.min()!<mu)
                XCTAssert(D.max()!>mu)
                let z = (D.mean()-mu)/(s/sqrt(Double(N)))
                XCTAssert(abs(z)<6.0)
            }
        }
    }
    
    func testRandomArrayInt8Range() {
        let m=Int8.random(Int8(-MAX)..<Int8(MAX))
        XCTAssert((m as Any) is Int8)
        XCTAssert(-MAX<=m && m<MAX)
        let n=Int8.random((m+1)...Int8(MAX))
        XCTAssert((n as Any) is Int8)
        XCTAssert(m<n && n<=MAX)
        do {
            let range = m..<n
            let X = Int8.randomArray(N,range:range)
            for x in X {
                XCTAssert(range.contains(x))
            }
            if (N>=100) {
                let b = n-1
                let mu = (Double(m)+Double(b))/2.0
                let s = (Double(b)-Double(m))/sqrt(12.0)
                if (s>0) {
                    let D = X.asDoubleArray()
                    XCTAssert(D.min()!<mu)
                    XCTAssert(D.max()!>mu)
                    let z = (D.mean()-mu)/(s/sqrt(Double(N)))
                    XCTAssert(abs(z)<6.0)
                }
            }
        }
        do {
            let range = m...n
            let X = Int8.randomArray(N,range:range)
            for x in X {
                XCTAssert(range.contains(x))
            }
            if (N>=100) {
                let mu = (Double(m)+Double(n))/2.0
                let s = (Double(n)-Double(m))/sqrt(12.0)
                XCTAssert(s>0)
                let D = X.asDoubleArray()
                XCTAssert(D.min()!<mu)
                XCTAssert(D.max()!>mu)
                let z = (D.mean()-mu)/(s/sqrt(Double(N)))
                XCTAssert(abs(z)<6.0)
            }
        }
    }

    func testRandomArrayInt16Range() {
        let m=Int16.random(Int16(-MAX)..<Int16(MAX))
        XCTAssert((m as Any) is Int16)
        XCTAssert(-MAX<=m && m<MAX)
        let n=Int16.random((m+1)...Int16(MAX))
        XCTAssert((n as Any) is Int16)
        XCTAssert(m<n && n<=MAX)
        do {
            let range = m..<n
            let X = Int16.randomArray(N,range:range)
            for x in X {
                XCTAssert(range.contains(x))
            }
            if (N>=100) {
                let b = n-1
                let mu = (Double(m)+Double(b))/2.0
                let s = (Double(b)-Double(m))/sqrt(12.0)
                if (s>0) {
                    let D = X.asDoubleArray()
                    XCTAssert(D.min()!<mu)
                    XCTAssert(D.max()!>mu)
                    let z = (D.mean()-mu)/(s/sqrt(Double(N)))
                    XCTAssert(abs(z)<6.0)
                }
            }
        }
        do {
            let range = m...n
            let X = Int16.randomArray(N,range:range)
            for x in X {
                XCTAssert(range.contains(x))
            }
            if (N>=100) {
                let mu = (Double(m)+Double(n))/2.0
                let s = (Double(n)-Double(m))/sqrt(12.0)
                XCTAssert(s>0)
                let D = X.asDoubleArray()
                XCTAssert(D.min()!<mu)
                XCTAssert(D.max()!>mu)
                let z = (D.mean()-mu)/(s/sqrt(Double(N)))
                XCTAssert(abs(z)<6.0)
            }
        }
    }
    
    func testRandomArrayInt32Range() {
        let m=Int32.random(Int32(-MAX)..<Int32(MAX))
        XCTAssert((m as Any) is Int32)
        XCTAssert(-MAX<=m && m<MAX)
        let n=Int32.random((m+1)...Int32(MAX))
        XCTAssert((n as Any) is Int32)
        XCTAssert(m<n && n<=MAX)
        do {
            let range = m..<n
            let X = Int32.randomArray(N,range:range)
            for x in X {
                XCTAssert(range.contains(x))
            }
            if (N>=100) {
                let b = n-1
                let mu = (Double(m)+Double(b))/2.0
                let s = (Double(b)-Double(m))/sqrt(12.0)
                if (s>0) {
                    let D = X.asDoubleArray()
                    XCTAssert(D.min()!<mu)
                    XCTAssert(D.max()!>mu)
                    let z = (D.mean()-mu)/(s/sqrt(Double(N)))
                    XCTAssert(abs(z)<6.0)
                }
            }
        }
        do {
            let range = m...n
            let X = Int32.randomArray(N,range:range)
            for x in X {
                XCTAssert(range.contains(x))
            }
            if (N>=100) {
                let mu = (Double(m)+Double(n))/2.0
                let s = (Double(n)-Double(m))/sqrt(12.0)
                XCTAssert(s>0)
                let D = X.asDoubleArray()
                XCTAssert(D.min()!<mu)
                XCTAssert(D.max()!>mu)
                let z = (D.mean()-mu)/(s/sqrt(Double(N)))
                XCTAssert(abs(z)<6.0)
            }
        }
    }
    
    func testRandomArrayInt64Range() {
        let m=Int64.random(Int64(-MAX)..<Int64(MAX))
        XCTAssert((m as Any) is Int64)
        XCTAssert(-MAX<=m && m<MAX)
        let n=Int64.random((m+1)...Int64(MAX))
        XCTAssert((n as Any) is Int64)
        XCTAssert(m<n && n<=MAX)
        do {
            let range = m..<n
            let X = Int64.randomArray(N,range:range)
            for x in X {
                XCTAssert(range.contains(x))
            }
            if (N>=100) {
                let b = n-1
                let mu = (Double(m)+Double(b))/2.0
                let s = (Double(b)-Double(m))/sqrt(12.0)
                if (s>0) {
                    let D = X.asDoubleArray()
                    XCTAssert(D.min()!<mu)
                    XCTAssert(D.max()!>mu)
                    let z = (D.mean()-mu)/(s/sqrt(Double(N)))
                    XCTAssert(abs(z)<6.0)
                }
            }
        }
        do {
            let range = m...n
            let X = Int64.randomArray(N,range:range)
            for x in X {
                XCTAssert(range.contains(x))
            }
            if (N>=100) {
                let mu = (Double(m)+Double(n))/2.0
                let s = (Double(n)-Double(m))/sqrt(12.0)
                XCTAssert(s>0)
                let D = X.asDoubleArray()
                XCTAssert(D.min()!<mu)
                XCTAssert(D.max()!>mu)
                let z = (D.mean()-mu)/(s/sqrt(Double(N)))
                XCTAssert(abs(z)<6.0)
            }
        }
    }
    
    func testRandomArrayUIntRange() {
        let m=UInt.random(0..<UInt(MAX))
        XCTAssert((m as Any) is UInt)
        XCTAssert(-MAX<=m && m<MAX)
        let n=UInt.random((m+1)...UInt(MAX))
        XCTAssert((n as Any) is UInt)
        XCTAssert(m<n && n<=MAX)
        do {
            let range = m..<n
            let X = UInt.randomArray(N,range:range)
            for x in X {
                XCTAssert(range.contains(x))
            }
            if (N>=100) {
                let b = n-1
                let mu = (Double(m)+Double(b))/2.0
                let s = (Double(b)-Double(m))/sqrt(12.0)
                if (s>0) {
                    let D = X.asDoubleArray()
                    XCTAssert(D.min()!<mu)
                    XCTAssert(D.max()!>mu)
                    let z = (D.mean()-mu)/(s/sqrt(Double(N)))
                    XCTAssert(abs(z)<6.0)
                }
            }
        }
        do {
            let range = m...n
            let X = UInt.randomArray(N,range:range)
            for x in X {
                XCTAssert(range.contains(x))
            }
            if (N>=100) {
                let mu = (Double(m)+Double(n))/2.0
                let s = (Double(n)-Double(m))/sqrt(12.0)
                XCTAssert(s>0)
                let D = X.asDoubleArray()
                XCTAssert(D.min()!<mu)
                XCTAssert(D.max()!>mu)
                let z = (D.mean()-mu)/(s/sqrt(Double(N)))
                XCTAssert(abs(z)<6.0)
            }
        }
    }
    
    func testRandomArrayUInt8Range() {
        let m=UInt8.random(0..<UInt8(MAX))
        XCTAssert((m as Any) is UInt8)
        XCTAssert(-MAX<=m && m<MAX)
        let n=UInt8.random((m+1)...UInt8(MAX))
        XCTAssert((n as Any) is UInt8)
        XCTAssert(m<n && n<=MAX)
        do {
            let range = m..<n
            let X = UInt8.randomArray(N,range:range)
            for x in X {
                XCTAssert(range.contains(x))
            }
            if (N>=100) {
                let b = n-1
                let mu = (Double(m)+Double(b))/2.0
                let s = (Double(b)-Double(m))/sqrt(12.0)
                if (s>0) {
                    let D = X.asDoubleArray()
                    XCTAssert(D.min()!<mu)
                    XCTAssert(D.max()!>mu)
                    let z = (D.mean()-mu)/(s/sqrt(Double(N)))
                    XCTAssert(abs(z)<6.0)
                }
            }
        }
        do {
            let range = m...n
            let X = UInt8.randomArray(N,range:range)
            for x in X {
                XCTAssert(range.contains(x))
            }
            if (N>=100) {
                let mu = (Double(m)+Double(n))/2.0
                let s = (Double(n)-Double(m))/sqrt(12.0)
                XCTAssert(s>0)
                let D = X.asDoubleArray()
                XCTAssert(D.min()!<mu)
                XCTAssert(D.max()!>mu)
                let z = (D.mean()-mu)/(s/sqrt(Double(N)))
                XCTAssert(abs(z)<6.0)
            }
        }
    }
    
    func testRandomArrayUInt16Range() {
        let m=UInt16.random(0..<UInt16(MAX))
        XCTAssert((m as Any) is UInt16)
        XCTAssert(-MAX<=m && m<MAX)
        let n=UInt16.random((m+1)...UInt16(MAX))
        XCTAssert((n as Any) is UInt16)
        XCTAssert(m<n && n<=MAX)
        do {
            let range = m..<n
            let X = UInt16.randomArray(N,range:range)
            for x in X {
                XCTAssert(range.contains(x))
            }
            if (N>=100) {
                let b = n-1
                let mu = (Double(m)+Double(b))/2.0
                let s = (Double(b)-Double(m))/sqrt(12.0)
                if (s>0) {
                    let D = X.asDoubleArray()
                    XCTAssert(D.min()!<mu)
                    XCTAssert(D.max()!>mu)
                    let z = (D.mean()-mu)/(s/sqrt(Double(N)))
                    XCTAssert(abs(z)<6.0)
                }
            }
        }
        do {
            let range = m...n
            let X = UInt16.randomArray(N,range:range)
            for x in X {
                XCTAssert(range.contains(x))
            }
            if (N>=100) {
                let mu = (Double(m)+Double(n))/2.0
                let s = (Double(n)-Double(m))/sqrt(12.0)
                XCTAssert(s>0)
                let D = X.asDoubleArray()
                XCTAssert(D.min()!<mu)
                XCTAssert(D.max()!>mu)
                let z = (D.mean()-mu)/(s/sqrt(Double(N)))
                XCTAssert(abs(z)<6.0)
            }
        }
    }
    
    func testRandomArrayUInt32Range() {
        let m=UInt32.random(0..<UInt32(MAX))
        XCTAssert((m as Any) is UInt32)
        XCTAssert(-MAX<=m && m<MAX)
        let n=UInt32.random((m+1)...UInt32(MAX))
        XCTAssert((n as Any) is UInt32)
        XCTAssert(m<n && n<=MAX)
        do {
            let range = m..<n
            let X = UInt32.randomArray(N,range:range)
            for x in X {
                XCTAssert(range.contains(x))
            }
            if (N>=100) {
                let b = n-1
                let mu = (Double(m)+Double(b))/2.0
                let s = (Double(b)-Double(m))/sqrt(12.0)
                if (s>0) {
                    let D = X.asDoubleArray()
                    XCTAssert(D.min()!<mu)
                    XCTAssert(D.max()!>mu)
                    let z = (D.mean()-mu)/(s/sqrt(Double(N)))
                    XCTAssert(abs(z)<6.0)
                }
            }
        }
        do {
            let range = m...n
            let X = UInt32.randomArray(N,range:range)
            for x in X {
                XCTAssert(range.contains(x))
            }
            if (N>=100) {
                let mu = (Double(m)+Double(n))/2.0
                let s = (Double(n)-Double(m))/sqrt(12.0)
                XCTAssert(s>0)
                let D = X.asDoubleArray()
                XCTAssert(D.min()!<mu)
                XCTAssert(D.max()!>mu)
                let z = (D.mean()-mu)/(s/sqrt(Double(N)))
                XCTAssert(abs(z)<6.0)
            }
        }
    }
    
    func testRandomArrayUInt64Range() {
        let m=UInt64.random(0..<UInt64(MAX))
        XCTAssert((m as Any) is UInt64)
        XCTAssert(-MAX<=m && m<MAX)
        let n=UInt64.random((m+1)...UInt64(MAX))
        XCTAssert((n as Any) is UInt64)
        XCTAssert(m<n && n<=MAX)
        do {
            let range = m..<n
            let X = UInt64.randomArray(N,range:range)
            for x in X {
                XCTAssert(range.contains(x))
            }
            if (N>=100) {
                let b = n-1
                let mu = (Double(m)+Double(b))/2.0
                let s = (Double(b)-Double(m))/sqrt(12.0)
                if (s>0) {
                    let D = X.asDoubleArray()
                    XCTAssert(D.min()!<mu)
                    XCTAssert(D.max()!>mu)
                    let z = (D.mean()-mu)/(s/sqrt(Double(N)))
                    XCTAssert(abs(z)<6.0)
                }
            }
        }
        do {
            let range = m...n
            let X = UInt64.randomArray(N,range:range)
            for x in X {
                XCTAssert(range.contains(x))
            }
            if (N>=100) {
                let mu = (Double(m)+Double(n))/2.0
                let s = (Double(n)-Double(m))/sqrt(12.0)
                XCTAssert(s>0)
                let D = X.asDoubleArray()
                XCTAssert(D.min()!<mu)
                XCTAssert(D.max()!>mu)
                let z = (D.mean()-mu)/(s/sqrt(Double(N)))
                XCTAssert(abs(z)<6.0)
            }
        }
    }
    
    func testRandomArrayFloatRange() {
        let m=Float.random(Float(-MAX)..<Float(MAX))
        XCTAssert((m as Any) is Float)
        XCTAssert(-Float(MAX)<=m && m<Float(MAX))
        let n=Float.random(m...Float(MAX))
        XCTAssert((n as Any) is Float)
        // Ignoring astronomically small chance m==n
        XCTAssert(m<n && n<=Float(MAX))
        do {
            let range = m..<n
            let X = Float.randomArray(N,range:range)
            for x in X {
                XCTAssert(range.contains(x))
            }
            if (N>=100) {
                let mu = (m+n)/2
                XCTAssert(X.min()!<mu)
                XCTAssert(X.max()!>mu)
                let s = (n-m)/sqrt(12.0)
                let z = (X.mean()-mu)/(s/sqrt(Float(N)))
                XCTAssert(abs(z)<6.0)
            }
        }
        do {
            let range = m...n
            let X = Float.randomArray(N,range:range)
            for x in X {
                XCTAssert(range.contains(x))
            }
            if (N>=100) {
                let mu = (m+n)/2
                XCTAssert(X.min()!<mu)
                XCTAssert(X.max()!>mu)
                let s = (n-m)/sqrt(12.0)
                let z = (X.mean()-mu)/(s/sqrt(Float(N)))
                XCTAssert(abs(z)<6.0)
            }
        }
    }

    func testRandomArrayDoubleRange() {
        let m=Double.random(Double(-MAX)..<Double(MAX))
        XCTAssert((m as Any) is Double)
        XCTAssert(-Double(MAX)<=m && m<Double(MAX))
        let n=Double.random(m...Double(MAX))
        XCTAssert((n as Any) is Double)
        // Ignoring astronomically small chance m==n
        XCTAssert(m<n && n<=Double(MAX))
        do {
            let range = m..<n
            let X = Double.randomArray(N,range:range)
            for x in X {
                XCTAssert(range.contains(x))
            }
            if (N>=100) {
                let mu = (m+n)/2
                XCTAssert(X.min()!<mu)
                XCTAssert(X.max()!>mu)
                let s = (n-m)/sqrt(12.0)
                let z = (X.mean()-mu)/(s/sqrt(Double(N)))
                XCTAssert(abs(z)<6.0)
            }
        }
        do {
            let range = m...n
            let X = Double.randomArray(N,range:range)
            for x in X {
                XCTAssert(range.contains(x))
            }
            if (N>=100) {
                let mu = (m+n)/2
                XCTAssert(X.min()!<mu)
                XCTAssert(X.max()!>mu)
                let s = (n-m)/sqrt(12.0)
                let z = (X.mean()-mu)/(s/sqrt(Double(N)))
                XCTAssert(abs(z)<6.0)
            }
        }
    }
    
    func testRandomArrayCGFloatRange() {
        let m=CGFloat.random(CGFloat(-MAX)..<CGFloat(MAX))
        XCTAssert((m as Any) is CGFloat)
        XCTAssert(-CGFloat(MAX)<=m && m<CGFloat(MAX))
        let n=CGFloat.random(m...CGFloat(MAX))
        XCTAssert((n as Any) is CGFloat)
        // Ignoring astronomically small chance m==n
        XCTAssert(m<n && n<=CGFloat(MAX))
        do {
            let range = m..<n
            let X = CGFloat.randomArray(N,range:range)
            for x in X {
                XCTAssert(range.contains(x))
            }
            if (N>=100) {
                let mu = (m+n)/2
                XCTAssert(X.min()!<mu)
                XCTAssert(X.max()!>mu)
                let s = (n-m)/sqrt(12.0)
                let z = (X.mean()-mu)/(s/sqrt(CGFloat(N)))
                XCTAssert(abs(z)<6.0)
            }
        }
        do {
            let range = m...n
            let X = CGFloat.randomArray(N,range:range)
            for x in X {
                XCTAssert(range.contains(x))
            }
            if (N>=100) {
                let mu = (m+n)/2
                XCTAssert(X.min()!<mu)
                XCTAssert(X.max()!>mu)
                let s = (n-m)/sqrt(12.0)
                let z = (X.mean()-mu)/(s/sqrt(CGFloat(N)))
                XCTAssert(abs(z)<6.0)
            }
        }
    }
    
    func testRandomArrayComplexRange() {
        let m_real=Double.random(Double(-MAX)..<Double(MAX))
        XCTAssert((m_real as Any) is Double)
        XCTAssert(-Double(MAX)<=m_real && m_real<Double(MAX))
        let n_real=Double.random(m_real...Double(MAX))
        XCTAssert((n_real as Any) is Double)
        // Ignoring astronomically small chance m_real==n_real
        XCTAssert(m_real<n_real && n_real<=Double(MAX))
        let m_imaginary=Double.random(Double(-MAX)..<Double(MAX))
        XCTAssert((m_imaginary as Any) is Double)
        XCTAssert(-Double(MAX)<=m_imaginary && m_imaginary<Double(MAX))
        let n_imaginary=Double.random(m_imaginary...Double(MAX))
        XCTAssert((n_imaginary as Any) is Double)
        // Ignoring astronomically small chance m_imaginary==n_imaginary
        XCTAssert(m_imaginary<n_imaginary && n_imaginary<=Double(MAX))
        // Complex m and n
        let m=Complex(m_real,m_imaginary)
        let n=Complex(n_real,n_imaginary)
        do {
            let range = m..<n
            let X = Complex.randomArray(N,range:range)
            if (N>=100) {
                let mu_X : Complex = X.mean()
                do {
                    let mu_real = (m_real+n_real)/2
                    let s_real = (n_real-m_real)/sqrt(12.0)
                    let z_real = (mu_X.real-mu_real)/(s_real/sqrt(Double(N)))
                    XCTAssert(abs(z_real)<6.0)
                }
                do {
                    let mu_imaginary = (m_imaginary+n_imaginary)/2
                    let s_imaginary = (n_imaginary-m_imaginary)/sqrt(12.0)
                    let z_imaginary = (mu_X.imaginary-mu_imaginary)/(s_imaginary/sqrt(Double(N)))
                    XCTAssert(abs(z_imaginary)<6.0)
                }
            }
        }
        do {
            let range = m...n
            let X = Complex.randomArray(N,range:range)
            if (N>=100) {
                let mu_X : Complex = X.mean()
                do {
                    let mu_real = (m_real+n_real)/2
                    let s_real = (n_real-m_real)/sqrt(12.0)
                    let z_real = (mu_X.real-mu_real)/(s_real/sqrt(Double(N)))
                    XCTAssert(abs(z_real)<6.0)
                }
                do {
                    let mu_imaginary = (m_imaginary+n_imaginary)/2
                    let s_imaginary = (n_imaginary-m_imaginary)/sqrt(12.0)
                    let z_imaginary = (mu_X.imaginary-mu_imaginary)/(s_imaginary/sqrt(Double(N)))
                    XCTAssert(abs(z_imaginary)<6.0)
                }
            }
        }
    }
    
    // MARK: randomArray Performance
    
    func testRandomArrayUIntPerformance() {
        compareBaseline(0.000478798151016235, title: "Random UInt Array of length 10000", n: 10) {
            UInt.randomArray(10000)
        }
    }

    func testRandomArrayIntPerformance() {
        compareBaseline(0.000473904609680176, title: "Random Int Array of length 10000", n: 10) {
            Int.randomArray(10000)
        }
    }
    
    func testRandomArrayInt8Permormance() {
        compareBaseline(0.000310802459716797, title: "Random Int8 Array of length 10000", n: 10) {
            UInt8.randomArray(10000)
        }
    }
    
    func testRandomArrayInt16Permormance() {
        compareBaseline(0.000315195322036743, title: "Random Int16 Array of length 10000", n: 10) {
            Int16.randomArray(10000)
        }
    }
    
    func testRandomArrayInt32Permormance() {
        compareBaseline(0.0002532958984375, title: "Random Int32 Array of length 10000", n: 10) {
            Int32.randomArray(10000)
        }
    }
    
    func testRandomArrayInt64Permormance() {
        compareBaseline(0.000450801849365234, title: "Random Int64 Array of length 10000", n: 10) {
            Int64.randomArray(10000)
        }
    }
    
    func testRandomArrayFloatPerformance() {
        compareBaseline(0.000304659207661947, title: "Random Float Array of length 10000", n: 10) {
            Float.randomArray(10000)
        }
    }
    
    func testRandomArrayDoublePerformance() {
        compareBaseline(0.000660339991251628, title: "Random Double Array of length 10000", n: 10) {
            Double.randomArray(10000)
        }
    }
}
