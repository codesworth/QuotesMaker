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

    func test_tapping_AddLayerOptionAddsABlankLayerToBaseView(){
        studioVc.loadViewIfNeeded()
        
        XCTAssertNil(studioVc.coordinator.baseView.currentSubview,"Error Initialized with a default subview")
        studioVc.studioPanel.collectionView(studioVc.studioPanel.collectionView, didSelectItemAt: IndexPath(row: 1, section: 0))
        XCTAssertNotNil(studioVc.coordinator.baseView.currentSubview,"Current Baseview has no current subview")
        XCTAssertNotNil(studioVc.coordinator.baseView.currentSubview as? RectView, "Wrong Layer Added")
        

    }
    
    func test_tapping_AddImageOptionAddsImageBackingLayerAndSetsImageProperty(){
        studioVc.loadViewIfNeeded()

        XCTAssertNil(studioVc.coordinator.baseView.currentSubview,"Error Initialized with a default subview")
        studioVc.studioPanel.collectionView(studioVc.studioPanel.collectionView, didSelectItemAt: IndexPath(row: 2, section: 0))
        let bundle = Bundle(for: StudioVCTests.self)
        let image = UIImage(named: "testImage", in: bundle, compatibleWith: nil)
        XCTAssertNotNil(image, "Unable to load test Image")
        studioVc.imagePickerController(UIImagePickerController(), didFinishPickingMediaWithInfo: [UIImagePickerController.InfoKey.originalImage:image!])
        XCTAssertNotNil(studioVc.coordinator.baseView.currentSubview,"Current Baseview has no current subview")
        XCTAssertNotNil(studioVc.coordinator.baseView.currentSubview as? BackingImageView, "Wrong Layer Added")
        XCTAssertNotNil((studioVc.coordinator.baseView.currentSubview as? BackingImageView)?.image, "Failed to set image to backing ImageView")
        
       
    }
    
    func test_tapping_AddTextOptionAddsTextLayerToBaseView(){
        studioVc.loadViewIfNeeded()
        
        XCTAssertNil(studioVc.coordinator.baseView.currentSubview,"Error Initialized with a default subview")
        studioVc.studioPanel.collectionView(studioVc.studioPanel.collectionView, didSelectItemAt: IndexPath(row: 3, section: 0))
        XCTAssertNotNil(studioVc.coordinator.baseView.currentSubview,"Current Baseview has no current subview")
        XCTAssertNotNil(studioVc.coordinator.baseView.currentSubview as? BackingTextView, "Wrong Layer Added")
        

    }
    
    func test_tapping_StartOverOptionClearsBaseViewSubviews(){
        studioVc.loadViewIfNeeded()
        
        XCTAssertNil(studioVc.coordinator.baseView.currentSubview,"Error Initialized with a default subview")
        for _ in 0...5{
            studioVc.studioPanel.collectionView(studioVc.studioPanel.collectionView, didSelectItemAt: IndexPath(row: 1, section: 0))
        }
        
        XCTAssertNotNil(studioVc.coordinator.baseView.currentSubview,"Current Baseview has no current subview")
        XCTAssertEqual(studioVc.coordinator.baseView.subviews.count, 6)
        studioVc.studioPanel.collectionView(studioVc.studioPanel.collectionView, didSelectItemAt: IndexPath(row: 6, section: 0))
        
        XCTAssertNil(studioVc.coordinator.baseView.currentSubview, "Failed to clear CurrentSubview")
        XCTAssertEqual(studioVc.coordinator.baseView.subviews.count, 0)
        
    }
    
    func test_DuplicatesOptionWorks(){
        studioVc.loadViewIfNeeded()
        
        XCTAssertNil(studioVc.coordinator.baseView.currentSubview,"Error Initialized with a default subview")
        studioVc.studioPanel.collectionView(studioVc.studioPanel.collectionView, didSelectItemAt: IndexPath(row: 1, section: 0))
        studioVc.studioTab.collectionView(studioVc.studioTab.collectionview, didSelectItemAt: IndexPath(row: 3, section: 0))
        XCTAssertEqual(studioVc.coordinator.baseView.subviews.count, 2, "Unable to duplicate Layers")
    }
    
    func test_DeleteLayerWorks(){
        studioVc.loadViewIfNeeded()
        XCTAssertNil(studioVc.coordinator.baseView.currentSubview,"Error Initialized with a default subview")
        studioVc.studioPanel.collectionView(studioVc.studioPanel.collectionView, didSelectItemAt: IndexPath(row: 1, section: 0))
        studioVc.studioTab.collectionView(studioVc.studioTab.collectionview, didSelectItemAt: IndexPath(row: 9, section: 0))
        XCTAssertEqual(studioVc.coordinator.baseView.subviews.count, 0, "Unable to duplicate Layers")
    }
    
    func test_Select_Gradient_Swaps_BlankLayer_To_GradientLayer_ViseVersa(){
        studioVc.loadViewIfNeeded()
        XCTAssertNil(studioVc.coordinator.baseView.currentSubview,"Error Initialized with a default subview")
        studioVc.studioPanel.collectionView(studioVc.studioPanel.collectionView, didSelectItemAt: IndexPath(row: 1, section: 0))
        studioVc.studioTab.collectionView(studioVc.studioTab.collectionview, didSelectItemAt: IndexPath(row: 0, section: 0))
        studioVc.gradientPanel.colorSliderDidChanged(studioVc.gradientPanel.colorSlider)
        XCTAssertNotNil((studioVc.coordinator.baseView.currentSubview as? RectView)?.model.gradient, "Failed to swap Gradient Layer")
        //studioVc.colorPanel.colorChanged(studioVc.colorPanel.colorSlider)
        XCTAssertTrue((studioVc.coordinator.baseView.currentSubview as? RectView)?.model.isGradient ?? false, "Falied to change Gradient Layer to Fill layer")
    }
    
    func test_Select_FillColor_ChangesGradientViewToFillView(){
        
    }
    
    

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
           studioVc.viewDidLoad()
        }
    }

}
