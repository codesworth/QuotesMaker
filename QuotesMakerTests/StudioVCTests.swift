//
//  StudioVCTests.swift
//  QuotesMakerTests
//
//  Created by Shadrach Mensah on 16/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import XCTest

@testable import QuotesMaker

class StudioVCTests: XCTestCase {

    var studioVc:StudioVC!
    override func setUp() {
        studioVc = (UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "\(StudioVC.self)") as! StudioVC)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_StackTableInclusion(){
        let baseView = BaseView(frame: [20])
        let wrapper = WrapperView(frame: baseView.bounds, layer: BackingGradientlayer())
        baseView.addSubview(wrapper)
        studioVc.baseView = baseView
        let stack = studioVc.makeStackTable()
        XCTAssertNotNil(stack)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
           studioVc.viewDidLoad()
        }
    }

}
