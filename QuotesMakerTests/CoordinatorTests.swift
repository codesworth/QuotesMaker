//
//  CoordinatorTests.swift
//  QuotesMakerTests
//
//  Created by Shadrach Mensah on 09/10/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import XCTest
@testable import QuotesMaker

class CoordinatorTests: XCTestCase {
    
    private var coordinator:EditingCoordinator!

    override func setUp() {
        
        coordinator = EditingCoordinator(canvas: Canvas(aspect: .instagram))
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
