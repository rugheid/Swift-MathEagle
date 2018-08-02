//
//  ExtensionsTests.swift
//  SwiftMath
//
//  Created by Rugen Heidbuchel on 27/01/15.
//  Copyright (c) 2015 Jorestha Solutions. All rights reserved.
//

import Cocoa
import XCTest
import MathEagle

class ExtensionsTests: XCTestCase {
    func testIsNegative() {
        XCTAssertFalse(2.0.isNegative)
        XCTAssertFalse(0.0.isNegative)
        XCTAssertFalse(1023432.0.isNegative)
        XCTAssertFalse(1.4532.isNegative)
        XCTAssertTrue((-1.4532).isNegative)
        XCTAssertTrue((-1.0).isNegative)
    }
    func testIsPositive() {
        XCTAssertTrue(2.0.isPositive)
        XCTAssertFalse(0.0.isPositive)
        XCTAssertTrue(1023432.0.isPositive)
        XCTAssertTrue(1.4532.isPositive)
        XCTAssertFalse((-1.4532).isPositive)
        XCTAssertFalse((-1.0).isPositive)
    }
    func testIsNatural() {
        XCTAssertTrue(2.0.isNatural)
        XCTAssertTrue(0.0.isNatural)
        XCTAssertTrue(1023432.0.isNatural)
        XCTAssertFalse(1.4532.isNatural)
        XCTAssertFalse((-1.4532).isNatural)
        XCTAssertFalse((-1.0).isNatural)
    }
    func testIsInteger() {
        XCTAssertTrue(2.0.isInteger)
        XCTAssertTrue(0.0.isInteger)
        XCTAssertTrue((-2.0).isInteger)
        XCTAssertFalse(2.12.isInteger)
        XCTAssertFalse((-2.12).isInteger)
    }
    func testExtensionsDouble() {
        repeat {
            let x : Double = 1.0
            XCTAssertFalse(x.isNegative)
            XCTAssertTrue(x.isPositive)
            XCTAssertTrue(x.isInteger)
            XCTAssertTrue(x.isNatural)
        } while false
        repeat {
            let x : Double = -1.0
            XCTAssertTrue(x.isNegative)
            XCTAssertFalse(x.isPositive)
            XCTAssertTrue(x.isInteger)
            XCTAssertFalse(x.isNatural)
        } while false
        repeat {
            let x : Double = 3.14159
            XCTAssertFalse(x.isNegative)
            XCTAssertTrue(x.isPositive)
            XCTAssertFalse(x.isInteger)
            XCTAssertFalse(x.isNatural)
        } while false
        repeat {
            let x : Double = 0.0
            XCTAssertFalse(x.isNegative)
            XCTAssertFalse(x.isPositive)
            XCTAssertTrue(x.isInteger)
            XCTAssertTrue(x.isNatural)
        } while false
    }
    func testExtensionsFloat() {
        repeat {
            let x : Float = 1.0
            XCTAssertFalse(x.isNegative)
            XCTAssertTrue(x.isPositive)
            XCTAssertTrue(x.isInteger)
            XCTAssertTrue(x.isNatural)
        } while false
        repeat {
            let x : Float = -1.0
            XCTAssertTrue(x.isNegative)
            XCTAssertFalse(x.isPositive)
            XCTAssertTrue(x.isInteger)
            XCTAssertFalse(x.isNatural)
        } while false
        repeat {
            let x : Float = 3.14159
            XCTAssertFalse(x.isNegative)
            XCTAssertTrue(x.isPositive)
            XCTAssertFalse(x.isInteger)
            XCTAssertFalse(x.isNatural)
        } while false
        repeat {
            let x : Float = 0.0
            XCTAssertFalse(x.isNegative)
            XCTAssertFalse(x.isPositive)
            XCTAssertTrue(x.isInteger)
            XCTAssertTrue(x.isNatural)
        } while false
    }
    func testExtensionsCGFloat() {
        repeat {
            let x : CGFloat = 1.0
            XCTAssertFalse(x.isNegative)
            XCTAssertTrue(x.isPositive)
            XCTAssertTrue(x.isInteger)
            XCTAssertTrue(x.isNatural)
        } while false
        repeat {
            let x : CGFloat = -1.0
            XCTAssertTrue(x.isNegative)
            XCTAssertFalse(x.isPositive)
            XCTAssertTrue(x.isInteger)
            XCTAssertFalse(x.isNatural)
        } while false
        repeat {
            let x : CGFloat = 3.14159
            XCTAssertFalse(x.isNegative)
            XCTAssertTrue(x.isPositive)
            XCTAssertFalse(x.isInteger)
            XCTAssertFalse(x.isNatural)
        } while false
        repeat {
            let x : CGFloat = 0.0
            XCTAssertFalse(x.isNegative)
            XCTAssertFalse(x.isPositive)
            XCTAssertTrue(x.isInteger)
            XCTAssertTrue(x.isNatural)
        } while false
    }
    func testExtensionsInt() {
        repeat {
            let x : Int = 1
            XCTAssertFalse(x.isNegative)
            XCTAssertTrue(x.isPositive)
            XCTAssertTrue(x.isInteger)
            XCTAssertTrue(x.isNatural)
        } while false
        repeat {
            let x : Int = -1
            XCTAssertTrue(x.isNegative)
            XCTAssertFalse(x.isPositive)
            XCTAssertTrue(x.isInteger)
            XCTAssertFalse(x.isNatural)
        } while false
        repeat {
            let x : Int = 0
            XCTAssertFalse(x.isNegative)
            XCTAssertFalse(x.isPositive)
            XCTAssertTrue(x.isInteger)
            XCTAssertTrue(x.isNatural)
        } while false
    }
    func testExtensionsInt8() {
        repeat {
            let x : Int8 = 1
            XCTAssertFalse(x.isNegative)
            XCTAssertTrue(x.isPositive)
            XCTAssertTrue(x.isInteger)
            XCTAssertTrue(x.isNatural)
        } while false
        repeat {
            let x : Int8 = -1
            XCTAssertTrue(x.isNegative)
            XCTAssertFalse(x.isPositive)
            XCTAssertTrue(x.isInteger)
            XCTAssertFalse(x.isNatural)
        } while false
        repeat {
            let x : Int8 = 0
            XCTAssertFalse(x.isNegative)
            XCTAssertFalse(x.isPositive)
            XCTAssertTrue(x.isInteger)
            XCTAssertTrue(x.isNatural)
        } while false
    }
    func testExtensionsInt16() {
        repeat {
            let x : Int16 = 1
            XCTAssertFalse(x.isNegative)
            XCTAssertTrue(x.isPositive)
            XCTAssertTrue(x.isInteger)
            XCTAssertTrue(x.isNatural)
        } while false
        repeat {
            let x : Int16 = -1
            XCTAssertTrue(x.isNegative)
            XCTAssertFalse(x.isPositive)
            XCTAssertTrue(x.isInteger)
            XCTAssertFalse(x.isNatural)
        } while false
        repeat {
            let x : Int16 = 0
            XCTAssertFalse(x.isNegative)
            XCTAssertFalse(x.isPositive)
            XCTAssertTrue(x.isInteger)
            XCTAssertTrue(x.isNatural)
        } while false
    }
    func testExtensionsInt32() {
        repeat {
            let x : Int32 = 1
            XCTAssertFalse(x.isNegative)
            XCTAssertTrue(x.isPositive)
            XCTAssertTrue(x.isInteger)
            XCTAssertTrue(x.isNatural)
        } while false
        repeat {
            let x : Int32 = -1
            XCTAssertTrue(x.isNegative)
            XCTAssertFalse(x.isPositive)
            XCTAssertTrue(x.isInteger)
            XCTAssertFalse(x.isNatural)
        } while false
        repeat {
            let x : Int32 = 0
            XCTAssertFalse(x.isNegative)
            XCTAssertFalse(x.isPositive)
            XCTAssertTrue(x.isInteger)
            XCTAssertTrue(x.isNatural)
        } while false
    }
    func testExtensionsInt64() {
        repeat {
            let x : Int64 = 1
            XCTAssertFalse(x.isNegative)
            XCTAssertTrue(x.isPositive)
            XCTAssertTrue(x.isInteger)
            XCTAssertTrue(x.isNatural)
        } while false
        repeat {
            let x : Int64 = -1
            XCTAssertTrue(x.isNegative)
            XCTAssertFalse(x.isPositive)
            XCTAssertTrue(x.isInteger)
            XCTAssertFalse(x.isNatural)
        } while false
        repeat {
            let x : Int64 = 0
            XCTAssertFalse(x.isNegative)
            XCTAssertFalse(x.isPositive)
            XCTAssertTrue(x.isInteger)
            XCTAssertTrue(x.isNatural)
        } while false
    }
    func testExtensionsUInt() {
        repeat {
            let x : UInt = 1
            XCTAssertFalse(x.isNegative)
            XCTAssertTrue(x.isPositive)
            XCTAssertTrue(x.isInteger)
            XCTAssertTrue(x.isNatural)
        } while false
        repeat {
            let x : UInt = 0
            XCTAssertFalse(x.isNegative)
            XCTAssertFalse(x.isPositive)
            XCTAssertTrue(x.isInteger)
            XCTAssertTrue(x.isNatural)
        } while false
    }
    func testExtensionsUInt8() {
        repeat {
            let x : UInt8 = 1
            XCTAssertFalse(x.isNegative)
            XCTAssertTrue(x.isPositive)
            XCTAssertTrue(x.isInteger)
            XCTAssertTrue(x.isNatural)
        } while false
        repeat {
            let x : UInt8 = 0
            XCTAssertFalse(x.isNegative)
            XCTAssertFalse(x.isPositive)
            XCTAssertTrue(x.isInteger)
            XCTAssertTrue(x.isNatural)
        } while false
    }
    func testExtensionsUInt16() {
        repeat {
            let x : UInt16 = 1
            XCTAssertFalse(x.isNegative)
            XCTAssertTrue(x.isPositive)
            XCTAssertTrue(x.isInteger)
            XCTAssertTrue(x.isNatural)
        } while false
        repeat {
            let x : UInt16 = 0
            XCTAssertFalse(x.isNegative)
            XCTAssertFalse(x.isPositive)
            XCTAssertTrue(x.isInteger)
            XCTAssertTrue(x.isNatural)
        } while false
    }
    func testExtensionsUInt32() {
        repeat {
            let x : UInt32 = 1
            XCTAssertFalse(x.isNegative)
            XCTAssertTrue(x.isPositive)
            XCTAssertTrue(x.isInteger)
            XCTAssertTrue(x.isNatural)
        } while false
        repeat {
            let x : UInt32 = 0
            XCTAssertFalse(x.isNegative)
            XCTAssertFalse(x.isPositive)
            XCTAssertTrue(x.isInteger)
            XCTAssertTrue(x.isNatural)
        } while false
    }
    func testExtensionsUInt64() {
        repeat {
            let x : UInt64 = 1
            XCTAssertFalse(x.isNegative)
            XCTAssertTrue(x.isPositive)
            XCTAssertTrue(x.isInteger)
            XCTAssertTrue(x.isNatural)
        } while false
        repeat {
            let x : UInt64 = 0
            XCTAssertFalse(x.isNegative)
            XCTAssertFalse(x.isPositive)
            XCTAssertTrue(x.isInteger)
            XCTAssertTrue(x.isNatural)
        } while false
    }
}
