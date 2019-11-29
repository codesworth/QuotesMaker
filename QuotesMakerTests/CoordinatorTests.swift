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
        let studio = StudioVC(model: nil, canvas: Canvas(aspect: .instagram))
        coordinator = studio.coordinator
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        Persistence.main.deleteModel(name:"test1")
    }

    func test_saveModel(){
        
        coordinator.persistModel(title: "test1")
        XCTAssert(Persistence.main.fileExists(name: "test1", with: .json, in: .savedModels), "File fdoesnt Exist")
        
    }
    
    
    
    func test_deletCurrentWorks(){
        coordinator.addText()
        XCTAssertNotNil(coordinator.baseView.currentSubview, "Current subview still nil")
        coordinator.deleteCurrent()
        XCTAssertNil(coordinator.baseView.currentSubview, "unbale to delete current subvuiew")
    }
    
    func test_layer_movement(){
        coordinator.shapeSelected()
        XCTAssertNotNil(coordinator.baseView.currentSubview, "Current subview still nil")
        XCTAssert((coordinator.baseView.currentSubview as? RectView) != nil)
        coordinator.imageOptionSelected()
        XCTAssert((coordinator.baseView.currentSubview as? BackingImageView) != nil)
        coordinator.moveSubiewBackward()
        XCTAssert((coordinator.baseView.subviews.last as? RectView) != nil)
        XCTAssert((coordinator.baseView.subviews.first as? BackingImageView) != nil)
        
    }
    
    

}
