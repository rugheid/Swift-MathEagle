//
//  RandomTests.swift
//  MathEagle
//
//  Created by Rugen Heidbuchel on 01/04/15.
//  Copyright (c) 2015 Jorestha Solutions. All rights reserved.
//

import Cocoa
import XCTest

class RandomTests: XCTestCase {

    func testUIntRandomInInterval() {
        
        for _ in 1 ... 1000 {
            
            var rand = UInt.randomInInterval(0...10)
            XCTAssertTrue(rand >= 0 && rand <= 10)
        }
    }

}
