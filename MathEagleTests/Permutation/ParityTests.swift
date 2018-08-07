//
//  ParityTests.swift
//  MathEagleTests
//
//  Created by Kelly Roach on 8/1/18.
//  Copyright © 2018 Jorestha Solutions. All rights reserved.
//

import XCTest
import MathEagle

class ParityTests: XCTestCase {
    func testParity1() {
        XCTAssertEqual(Parity.fromMod2Remainder(1),Parity.odd)
        XCTAssertEqual(Parity.fromMod2Remainder(2),Parity.even)
        XCTAssertEqual(Parity.fromSign(-1),Parity.odd)
        XCTAssertEqual(Parity.fromSign(1),Parity.even)
        XCTAssertEqual(Parity(integerLiteral:1).mod2Remainder,1)
        XCTAssertEqual(Parity(integerLiteral:2).mod2Remainder,0)
        XCTAssertEqual(Parity(integerLiteral:1).sign,-1)
        XCTAssertEqual(Parity(integerLiteral:2).sign,1)
    }
    func testParity2() {
        XCTAssertEqual(Parity.even+Parity.even,Parity.even)
        XCTAssertEqual(Parity.even+Parity.odd,Parity.odd)
        XCTAssertEqual(Parity.odd+Parity.even,Parity.odd)
        XCTAssertEqual(Parity.odd+Parity.odd,Parity.even)
        XCTAssertEqual(Parity.even-Parity.even,Parity.even)
        XCTAssertEqual(Parity.even-Parity.odd,Parity.odd)
        XCTAssertEqual(Parity.odd-Parity.even,Parity.odd)
        XCTAssertEqual(Parity.odd-Parity.odd,Parity.even)
        XCTAssertEqual(Parity.even*Parity.even,Parity.even)
        XCTAssertEqual(Parity.even*Parity.odd,Parity.even)
        XCTAssertEqual(Parity.odd*Parity.even,Parity.even)
        XCTAssertEqual(Parity.odd*Parity.odd,Parity.odd)
    }
    func testParity3() {
        // Test focussed on +=
        var x : Parity = Parity.even
        x+=Parity.odd
        XCTAssertEqual(x,Parity.odd)
        x+=Parity.odd
        XCTAssertEqual(x,Parity.even)
        x+=Parity.even
        XCTAssertEqual(x,Parity.even)
    }
}
