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

    func testUIntRandom() {
        
        for _ in 1 ... 10_000 {
            UInt.random()
        }
    }

}
