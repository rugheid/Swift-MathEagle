//
//  MathTests.swift
//  SwiftMath
//
//  Created by Rugen Heidbuchel on 26/01/15.
//  Copyright (c) 2015 Jorestha Solutions. All rights reserved.
//

import Cocoa
import XCTest
import MathEagle

class MathTests: XCTestCase {
    func testFloatModulable() {
        repeat {
            let x : Float = 9.0
            let y : Float = 4.0
            XCTAssertEqual(x % y,Float(1.0))
            XCTAssert(((x % y) as Any) is Float)
        } while false
        repeat {
            let x : Float = -9.0
            let y : Float = 4.0
            XCTAssertEqual(x % y,Float(-1.0))
            XCTAssert(((x % y) as Any) is Float)
        } while false
        repeat {
            let x : Float = 9.0
            let y : Float = -4.0
            XCTAssertEqual(x % y,Float(1.0))
            XCTAssert(((x % y) as Any) is Float)
        } while false
        repeat {
            let x : Float = -9.0
            let y : Float = -4.0
            XCTAssertEqual(x % y,Float(-1.0))
            XCTAssert(((x % y) as Any) is Float)
        } while false
    }
    func testDoubleModulable() {
        repeat {
            let x : Double = 9.0
            let y : Double = 4.0
            XCTAssertEqual(x % y,Double(1.0))
            XCTAssert(((x % y) as Any) is Double)
        } while false
        repeat {
            let x : Double = -9.0
            let y : Double = 4.0
            XCTAssertEqual(x % y,Double(-1.0))
            XCTAssert(((x % y) as Any) is Double)
        } while false
        repeat {
            let x : Double = 9.0
            let y : Double = -4.0
            XCTAssertEqual(x % y,Double(1.0))
            XCTAssert(((x % y) as Any) is Double)
        } while false
        repeat {
            let x : Double = -9.0
            let y : Double = -4.0
            XCTAssertEqual(x % y,Double(-1.0))
            XCTAssert(((x % y) as Any) is Double)
        } while false
    }
    func testCGFloatModulable() {
        repeat {
            let x : CGFloat = 9.0
            let y : CGFloat = 4.0
            XCTAssertEqual(x % y,CGFloat(1.0))
            XCTAssert(((x % y) as Any) is CGFloat)
        } while false
        repeat {
            let x : CGFloat = -9.0
            let y : CGFloat = 4.0
            XCTAssertEqual(x % y,CGFloat(-1.0))
            XCTAssert(((x % y) as Any) is CGFloat)
        } while false
        repeat {
            let x : CGFloat = 9.0
            let y : CGFloat = -4.0
            XCTAssertEqual(x % y,CGFloat(1.0))
            XCTAssert(((x % y) as Any) is CGFloat)
        } while false
        repeat {
            let x : CGFloat = -9.0
            let y : CGFloat = -4.0
            XCTAssertEqual(x % y,CGFloat(-1.0))
            XCTAssert(((x % y) as Any) is CGFloat)
        } while false
    }
}
