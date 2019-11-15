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
        studioVc = StudioVC(model: nil, canvas: Canvas(aspect: .instagram))
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_tapping_AddLayerOptionAddsALayerToBaseView(){
        studioVc.loadViewIfNeeded()
        
        XCTAssertNil(studioVc.coordinator.baseView.currentSubview,"Error Initialized with a default subview")
        studioVc.studioPanel.collectionView(studioVc.studioPanel.collectionView, didSelectItemAt: IndexPath(row: 1, section: 0))
        XCTAssertNotNil(studioVc.coordinator.baseView.currentSubview,"Current Baseview has no current subview")
        XCTAssertNotNil(studioVc.coordinator.baseView.currentSubview as? RectView, "Wrong Layer Added")
        

    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
           studioVc.viewDidLoad()
        }
    }

}
